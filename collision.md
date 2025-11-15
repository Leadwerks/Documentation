# Collision

Collision is an important feature in that acts on both game physics and as an interaction method. In this lessons we will be focusing on collision as a method of initializing interactions between objects.

## Entity Collision Detection

Collision is most commonly handled in the [Collide](https://www.leadwerks.com/learn/Entity_Collide?lang=lua&nocpp=1) function in an entity script. You can read a tutorial using this approach [here](entityscripts.md).

Collisions will only occur between objects that are active in the physics simulation. In order for a collision to occur, one or both of the colliding objects must have a mass and a velocity. Both objects must have a [Collider](Collider.md) attached to them. Two objects that are overlapping but not physically active will not register a collision.

For the sake of simplifying this example, we can simply declare a function called Collide and add it to the entity object. This has the exact same result as placing an object in a scene and selecting an entity script in its properties.

```lua
-- Get the displays
local displays = GetDisplays()

-- Create window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create world
local world = CreateWorld()
world:SetAmbientLight(0.1)

-- Create light
local light = CreateDirectionalLight(world)
light:SetColor(1.2)
light:SetRotation(65,45,0)
light:SetShadowCascadeDistance(10,20,40,80)

-- Create the ground
local ground = CreateBox(world, 50, 1, 50)
ground:SetPosition(0,-0.5,0)
ground:SetColor(0.5)

-- Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetRotation(35,0,0)
camera:Move(0,0,-5)

-- Create a model
local box = CreateBox(world)
box:SetColor(0,0,1)
box:SetPosition(0,20,0)
box:SetMass(1)

function box:Collide(entity, position, normal, speed)
	Print(position)
end

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do
	
    -- Update the world
    world:Update()
	
    -- Render the world
    world:Render(framebuffer)

end
```

The collision positions will be printed into the script editor log when they occur in this program.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/collision.gif?raw=true)

Alternatively, we can enable collisions recording on the box model and iterate through all collisions that occur in the world. This will only contain collisions in which at least one of the colliding entities has collision recording enabled:

```lua
-- Get the displays
local displays = GetDisplays()

-- Create window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create world
local world = CreateWorld()
world:SetAmbientLight(0.1)

-- Create light
local light = CreateDirectionalLight(world)
light:SetColor(1.2)
light:SetRotation(65,45,0)
light:SetShadowCascadeDistance(10,20,40,80)

-- Create the ground
local ground = CreateBox(world, 50, 1, 50)
ground:SetPosition(0,-0.5,0)
ground:SetColor(0.5)

-- Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetRotation(35,0,0)
camera:Move(0,0,-5)

-- Create a model
local box = CreateBox(world)
box:SetColor(0,0,1)
box:SetPosition(0,20,0)
box:SetMass(1)

-- Enable collision recording
box:RecordCollisions(true)

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do
	
	for n = 1, #world.collisions do
		if world.collisions[n].entity[1] == box or world.collisions[n].entity[2] == box then
			Print(world.collisions[n].position)
		end
	end
	
    -- Update the world
    world:Update()
	
    -- Render the world
    world:Render(framebuffer)

end
```

## Collision Types

Each entity has a collision type. The types are just constant values with no intrinsic meaning, but they can be set to react based on the collision type of the other colliding entity. You can specify the collision response for every pair of collision types.

There are three possible responded.

- _COLLISION_COLLIDE_ will register a collision and cause the physics to react to the interpenetration of objects.
- _COLLISION_DETECT_ will register a collision you can detect, but physics will be unaffected.
- _COLLISION_NONE_ will not register any collision or affect physics.

The following collision types and their behavior are defined by default:

| Type 1 | Type 2 | Response |
|---|---|---|
| COLLISION_PROP | COLLISION_PROP | COLLISION_COLLIDE |
| COLLISION_PROP | COLLISION_SCENE | COLLISION_COLLIDE |
| COLLISION_DEBRIS | COLLISION_SCENE | COLLISION_COLLIDE |
| COLLISION_DEBRIS | COLLISION_PROP | COLLISION_COLLIDE |
| COLLISION_SCENE | COLLISION_PLAYER | COLLISION_COLLIDE |
| COLLISION_PROP | COLLISION_PLAYER | COLLISION_COLLIDE |
| COLLISION_PLAYER | COLLISION_PLAYER | COLLISION_COLLIDE |
| COLLISION_SCENE | COLLISION_PROJECTILE | COLLISION_COLLIDE |
| COLLISION_PROP | COLLISION_PROJECTILE | COLLISION_COLLIDE |
| COLLISION_PLAYER | COLLISION_TRIGGER | COLLISION_DETECT |

You may add your own if you wish, using the [World:SetCollisionResponse](World_SetCollisionResponse.md) command.

## Collision Triggers

Very often, we may wish to perform some action when a collision occurs. For example, if we have a game where the player has to collect some items, the actual goal is to collide with the desired item. Here is an example of a game where the player collects coins, which increase their score until they are all collected and the player wins:

```lua
-- Get the displays
local displays = GetDisplays()

-- Create window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

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

--Create the player
local player = CreatePivot(world)
player:SetMass(10)
player:SetPhysicsMode(PHYSICS_PLAYER)
player:SetCollisionType(COLLISION_PLAYER)
player:SetPosition(0,0,-2)
player:SetShadows(true)

--Create a visible model for the player
local model = CreateCylinder(world, 0.5, 2)
model:SetPosition(0,1,-2)
model:SetParent(player)
model:SetCollider(nil)
model:SetCollisionType(COLLISION_NONE)
model:SetColor(0,0,1)

local coins = {}
for n = 1, 20 do
	local coin = CreateCylinder(world, 0.5, 0.1)
	coin:SetColor(1,1,0)
	coin:SetPosition(Random(-8,8), 0.5, Random(-5,10))	
	coin:SetRotation(0, Random(0, 360), 0)
	coin:Turn(90,0,0)
	coin:SetCollisionType(COLLISION_TRIGGER)
	coin.iscoin = true
	table.insert(coins, coin)
end

-- Global variable for the score
score = 0

--Create some text to display the score
local font = LoadFont("Fonts/arial.ttf")
scoretile = CreateTile(world, font, "Score: 0", 32)

-- Load a sound to play
sound = LoadSound("https://github.com/Leadwerks/Documentation/raw/refs/heads/master/Assets/Sound/coin.wav")

function player:Collide(entity, position, normal, speed)

	-- Check to see if the entity is a coin
	if entity.iscoin then
		
		-- Check if hidden
		if not entity:GetHidden() then
			
			-- Hide the coin
			entity:SetHidden(true)
			
			--I ncrease the score by one
			score = score + 1
			
			-- Update the score display
			if score == #coins then
				scoretile:SetText("You win!")
			else
				scoretile:SetText("Score: " .. tostring(score))
			end
			
			-- Play a sound
			if sound~= nil then
				sound:Play()
			end
		end
	end
end

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do
	
	for n = 1, #coins do
		coins[n]:Turn(0,0,1)
	end
	
	local speed = 5
	local move = 0
	local strafe = 0
	
    -- Control the player with the arrow keys
    if window:KeyDown(KEY_DOWN) then move = move - speed end
	if window:KeyDown(KEY_UP) then move = move + speed end
    if window:KeyDown(KEY_LEFT) then strafe = strafe - speed end
	if window:KeyDown(KEY_RIGHT) then strafe = strafe + speed end
	player:SetInput(0, move, strafe)
	
    -- Update the world
    world:Update()

    -- Render the world
    world:Render(framebuffer)

end
```
