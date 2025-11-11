# Entity Spawning and Management

This lesson will discuss the concept of "spawning" and ownership of entities. There's no special commands here to review, but rather it's a way of thinking about object management.

Many games dynamically create entities that exist temporarily in the game. Bullets, particle effects, and hordes of enemies are examples. These objects can either have a temporary lifespan based on time, or they can expire based on specific conditions, like a bullet hitting a wall.

Dynamically spawned entities must be managed:

- Entities must be stored in a table of some type, so that they don't go out of scope and get deleted automatically.
- Some entities must be continually updated each frame.
- There must be some method of deleting the entities after a limited amount of time has passed, or based on actions in the game.

## Projectiles

This example shows how projectiles can be spawned when the player holds the space key, and how they can be managed until it is time to delete them.

```lua
-- Get the displays
local displays = GetDisplays()

-- Create window
local window = CreateWindow("Leadwerks", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create world
local world = CreateWorld()
world:SetAmbientLight(1)

-- Create the ground
local ground = CreateBox(world, 50, 1, 50)
ground:SetPosition(0,-0.5,0)
ground:SetColor(0.5)

-- Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetRotation(35,0,0)
camera:Move(0,0,-10)

-- Create the player
local player = CreateCylinder(world, 0.5, 2)
player:SetCollider(nil)
player:SetPosition(0,1,0)
player:SetColor(0,0,1)
player.lastfiretime = 0
player:SetPickMode(PICK_NONE)

--Table for storing bullets
player.bullets = {}

--Player update function, gets called once per loop
function player:Update()

	local window = ActiveWindow()
	if window == nil then return end

    -- Control the player with the arrow keys
    if window:KeyDown(KEY_RIGHT) then player:Turn(0,1,0) end
    if window:KeyDown(KEY_LEFT) then player:Turn(0,-1,0) end
    if window:KeyDown(KEY_UP) then player:Move(0,0,0.1) end
    if window:KeyDown(KEY_DOWN) then player:Move(0,0,-0.1) end
	
	local now = self.world:GetTime()
	
	if window:KeyDown(KEY_SPACE) then		
		if now - self.lastfiretime > 200 then
			self.lastfiretime = now
			
			local bullet = CreateSphere(world)
			bullet:SetPosition(player.position)
			bullet:SetRotation(player.rotation)
			bullet:SetPickMode(PICK_NONE)
			bullet:SetColor(0.25)
			bullet.spawntime = now
			
			table.insert(self.bullets, bullet)
			
		end
	end
	
	-- Update bullets
	for n = #self.bullets, 1, -1 do
		
		local dir = TransformNormal(0,0,1,self.bullets[n],nil)
		
		-- Perform a raycast to see if the bullet will hit anything
		local pick = world:Pick(self.bullets[n].position, self.bullets[n].position + dir, 0, true)
		if pick.entity then
			-- Object hit; Apply some force and hide the bullet
			pick.entity:AddPointForce(dir * 2, pick.position, true)
			self.bullets[n]:SetHidden(true)
		else
			-- Nothing hit, so move bullet forward
			self.bullets[n]:Move(0, 0, 1)
		end
		
		-- Hide the bullet if it times out
		if now - self.bullets[n].spawntime > 3000 then
			self.bullets[n]:SetHidden(true)
		end
		
		-- If the bullet was hidden for any reason, remove it from the list
		if self.bullets[n]:GetHidden() then
			self.bullets[n]:SetHidden(true)
			table.remove(self.bullets, n)
		end
		
	end
	
end

--Add some things to shoot
local boxes = {}
for n = 1, 10 do
	local box = CreateBox(world, 1,4,1)
	box:SetRotation(0,Random(360),0)
	box:SetMass(1)
	box:SetPosition(Random(-10,10), 2, Random(-10,10))
	box:SetColor(0, Random(1), Random(1))
	table.insert(boxes, box)
end

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do

	-- Garbage collection step
	collectgarbage()

    -- Update the world
    world:Update()

    -- Render the world
    world:Render(framebuffer)

end
```
