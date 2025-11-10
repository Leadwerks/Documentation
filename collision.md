# Collision

Collision is an important feature in that acts on both game physics and as an interaction method. In this lessons we will be focusing on collision as a method of initializing interactions between objects.

## Entity Collision Detection

Collision is most commonly handled in the [Collide](https://www.leadwerks.com/learn/Entity_Collide?lang=lua&nocpp=1) function in an entity script. For the same of this example, we can simply declare a function called Collide and add it to the entity object. This has the exact same result as placing an object in a scene and selecting an entity script in its properties.

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

Alternatively, we can enable collisions recording on the box model and iterate through all collisions that occur in the world. This will only contain collisions in which at least one of the colliding entities has collision recording enabled:

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

## Collisiion Types

Each entity has a collision type. The types are just constant values with no intrinsic meaning, but they can be set to react based on the collision type of the other colliding entity. You can specify the collision response for every pair of collision types.

There are three possible responded.

- **COLLISION_COLLIDE** will register a collision and cause the physics to react to the interpenetration of objects.
- **COLLISION_DETECT** will register a collision you can detect, but physics will be unaffected.
- **COLLISION_NONE** will not register any collision or affect physics.

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
