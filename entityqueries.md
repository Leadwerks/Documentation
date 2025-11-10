# Entity Filters

By default, the [World:GetEntities](World_GetEntities.md) returns all entities in the world. We can also define optional arguments that let you filter the results. You can use this to retrieve a list of entities in the world that meet conditions you can specify. (This functionality is only available in the Lua API.)

You can define any number of filter arguments, in sets of three. Each set must include the following arguments, in order:

| Property | Type | Description |
|---|---|---|
| field | string | the name of a field to check |
| operation | string | the operation to perform. This can be set to "==", "~=", "<", ">", "<=", or ">="
| value | any | the value to compare the entity field value to. This can be any Lua value. |

This can be used to easily retrieve a list of entities according to any criteria you want. Note that unlike our previous examples using [World:GetEntitiesInArea](World_GetEntitiesInArea.md), this method will return all entities in the world, regardless of their location.

## Example

In the example below, we retrieve a filtered list of all entities on team two that have more than zero health. This allows the hunters to find the objects they are looking for, while preventing them from attacking each other.

```lua
-- Get the displays
local displays = GetDisplays()

-- Create window
local window = CreateWindow("Leadwerks", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create world
local world = CreateWorld()
world:SetAmbientLight(0.1)

-- Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetRotation(35,0,0)
camera:Move(0,0,-10)

-- Create light
local light = CreateDirectionalLight(world)
light:SetColor(1.2)
light:SetRotation(65,45,0)
light:SetShadowCascadeDistance(10,20,40,80)

-- Create the ground
local ground = CreateBox(world, 50, 1, 50)
ground:SetPosition(0,-0.5,0)
ground:SetColor(0.5)

-- This table will prevent objects from going out of scope and being deleted
local monsters = {}

-- Big monsters - These hunt the small monsters
for n = 1, 2 do
	
	--Create a pivot with player physics
	local bigmonster = CreatePivot(world)
	bigmonster:SetMass(10)
	bigmonster:SetPhysicsMode(PHYSICS_PLAYER)
	bigmonster:SetCollisionType(COLLISION_PLAYER)
	bigmonster:SetPosition(0,0,-2)
	bigmonster:SetPosition(Random(-8,8), 0.5, Random(-5,10))  
	bigmonster.health = 100
    bigmonster.team = 1
	bigmonster.speed = 2
	
	--Create a visible model for the player
	local model = CreateCylinder(world, 0.5, 2)
	model:SetPosition(0,1,0)
	model:SetParent(bigmonster, false)
	model:SetCollider(nil)
	model:SetCollisionType(COLLISION_NONE)
	model:SetColor(0,0,1)
	
	function bigmonster:Update()
	
		if self.target and self.target.health == 0 then
			self.target = nil
		end
	
		if self.target == nil then
			
			-- Get all entities in the world on team two with more than zero health
			local entities = self.world:GetEntities("health", ">", 0, "team", "==", 2)
			
			-- In the array of returned entities, find the closest one and use that for the target
			local n
			local mindist
			for n = 1, #entities do
				local d = entities[n]:GetDistance(self)
				if n == 1 or d < mindist then
					self.target = entities[n]
					mindist = d
				end
			end
			
		end
	
		if self.target then
			-- Move towards the target
			local dir = self.target.position - self.position
			dir.y = 0
			dir = dir:Normalize() * self.speed
			self:SetInput(0, dir.z, dir.x)
		else
			--Stop
			self:SetInput(0,0)
		end		
		
	end
	
	-- When the monster hits any little monster that is alive, kill it
	function bigmonster:Collide(entity, position, normal, speed)
		if entity.team == 2 and entity.health > 0 then
			entity.health = 0
			entity:SetColor(0.25)
			entity.Update = nil
			self.speed = self.speed + 0.25-- The big monster will get faster the more it eats!
			if self.target == entity then self.target = nil end
		end
	end	
	
	table.insert(monsters, bigmonster)
end

-- Small monsters - These just wander around and get eaten
for n = 1, 100 do
    local littlemonster = CreateSphere(world, 0.25)
    littlemonster:SetColor(0,1,0)
    littlemonster:SetPosition(Random(-8,8), 0.5, Random(-5,10))  
	littlemonster:SetCollisionType(COLLISION_TRIGGER)
	littlemonster.health = 10
    littlemonster.team = 2
	littlemonster:SetRotation(0, Random(0,360), 0)
	littlemonster.deltayaw = Random(-5,5)
	
	-- Update function for little monsters...they will just wander around
	function littlemonster:Update()
		local yaw = self.rotation.y
		littlemonster.deltayaw = littlemonster.deltayaw + Random(-1,1)
		littlemonster.deltayaw = Clamp(littlemonster.deltayaw, -5, 5)
		yaw = yaw + littlemonster.deltayaw
		self:SetRotation(0, yaw, 0)
		self:Move(0,0,0.025)
	end

	table.insert(monsters, littlemonster)
end

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do

    -- Update the world
    world:Update()

    -- Render the world
    world:Render(framebuffer)

end
```
