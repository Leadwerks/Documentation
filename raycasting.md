# Raycasting

Raycasting is an important technique in game development, used for detecting objects and interactions within a 3D environment. It allows you to "cast" an invisible line, or ray, through the scene to determine what it intersects with.

Raycasting is widely used in game development for:

- **Object Interaction**: Checking what the player is looking at or pointing to, such as selecting objects or NPCs.
- **Shooting**: Detecting hits when firing projectiles or bullets.
- **Line-of-Sight Checks**: Verifying if an enemy can see the player.

## Commands

Leadwerks provides three commands for performing raycasting:

- [World:Pick](World_Pick.md): Casts a ray between two specific points in the world space.
- [Camera:Pick](Camera_Pick.md): Casts a ray from a screen coordinate into the 3D scene, useful for mouse picking or targeting.
- [Entity:GetVisible](Entity_GetVisible.md): Casts a ray between two entities and returns true if nothing is hit.

The first two commands both return a [PickInfo](PickInfo.md) structure containing information about the intersection:

| Property | Type | Description |
| ----- | ----- | ----- |
| entity | [Entity](Entity.md) | picked entity |
| face | [Face](Face.md) | picked face, for brushes |
| mesh | [Mesh](Mesh.md) | picked mesh, for models |
| meshlayer | integer | index of picked mesh layer |
| meshlayerinstance | [iVec2](iVec2.md) | picked mesh layer instance coordinate |
| normal | [xVec3](xVec3.md) | picked normal |
| polygon | integer | picked polygon, for models |
| position | [xVec3](xVec3.md) | picked position |
| texcoords | [table](https://www.lua.org/manual/5.4/manual.html#6.6) | array of picked texture coordinates, for brushes or models |

This example shows how to use the [World:Pick](World_Pick.md) command:

```lua
-- Get the displays
local displays = GetDisplays()

-- Create window
local window = CreateWindow("Leadwerks", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create world
local world = CreateWorld()

-- Create framebuffer
local framebuffer = CreateFramebuffer(window)

-- Set up camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetFov(70)
camera:SetPosition(0, 2, -3)
camera:SetRotation(25, 0, 0)

-- Add a light
local light = CreateDirectionalLight(world)
light:SetRotation(35, 45, 0)

-- Set up the scene
local floor = CreatePlane(world, 100, 100)
floor:Move(0, -1, 0)
floor:SetColor(0.5)

local b1 = CreateBox(world, 2.0)
b1:SetPosition(-3.0, 0.0, 0.0)
b1:SetColor(1, 0, 0)

local b2 = CreateBox(world, 2.0)
b2:SetColor(0.0, 0.0, 1.0)
b2:SetPosition(3.0, 0.0, 2.0)
b2:SetRotation(0.0, 45.0, 0.0)

local pivot = CreatePivot(world)

local rod_scale = 5.0
local rod = CreateCylinder(world, 0.05)
rod:SetCollider(nil)
rod:SetParent(pivot)
rod:SetRotation(90.0, 0.0, 0.0)
rod:SetPosition(0.0, 0.0, rod_scale / 2.0)
rod:SetScale(1.0, rod_scale, 1.0)

local sphere = CreateSphere(world, 0.25)
sphere:SetCollider(nil)
sphere:SetParent(pivot)
sphere:SetColor(0, 1, 0)
sphere:SetPosition(0.0, 0.0, rod_scale)

while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do
	
	--Rotate the assembly
    pivot:Turn(0.0, 0.5, 0.0)

	--Get the point at the maximum ray distance
    local target_pos = TransformPoint(0, 0, rod_scale, pivot, nil)

    -- Perform a ray cast
    local pickinfo = world:Pick(pivot:GetPosition(true), target_pos, 0.0, true)
	
	--Update the sphere based on the pick result
    if pickinfo.entity then
        sphere:SetPosition(pickinfo.position, true)
    else
        sphere:SetPosition(target_pos, true)
    end

    -- Update the world
    world:Update()

    -- Render the world
    world:Render(framebuffer)
end
```

## Sphere Casting

Raycasts can include an optional radius parameter. When a non-zero radius is specified, the raycast becomes a **sphere cast**, which checks for intersections within a spherical volume. This is especially useful for detecting wider objects or simulating a more forgiving collision area.

If we add the sphere radius into the pick command, the picked position will now correctly show the point at which the sphere would hit the scene:

```lua
local pick_info = world:Pick(pivot:GetPosition(true), target_pos, 0.25, true)
```

## Closest Intersection

The World and Camera Pick methods can perform a line-of-sight test, which will return from the function as soon as the first object is intersected, or they can perform a more thorough test that finds the closest picked object. Both these methods accept an optional _closest_ parameter that uses a boolean to indicate whether the more thorough (and slower) test should be performed.

When we are interested in the intersected object, the closest parameter should be set to true. For example, if we are selecting an object to interact with or shooting a bullet, the closest parameter should be set to true.

If we are not interested in the intersected object, and only want to know if there is an unbroken line of sight between two objects, then the closest parameter can be set to false.

## Raycast Filter

If a filter callback is provided it will be called for each entity that is evaluated. If the callback returns true the entity will be tested, otherwise it will be skipped.

```lua
function RayFilter(entity, extra)
	if entity.color.r < 1.0 then return false end
	return true
end
```

```lua
local pickinfo = world:Pick(pivot:GetPosition(true), target_pos, 0.0, true, RayFilter)
```
