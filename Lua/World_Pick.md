# World:Pick

This method performs a line segment intersection test on all the entities in the world.

## Syntax

- [PickInfo](PickInfo.md) **Pick**([xVec3](xVec3.md) p0, [xVec3](xVec3.md) p1)
- [PickInfo](PickInfo.md) **Pick**([xVec3](xVec3.md) p0, [xVec3](xVec3.md) p1, number radius = 0.0)
- [PickInfo](PickInfo.md) **Pick**([xVec3](xVec3.md) p0, [xVec3](xVec3.md) p1, number radius = 0.0, boolean closest = false)
- [PickInfo](PickInfo.md) **Pick**([xVec3](xVec3.md) p0, [xVec3](xVec3.md) p1, number radius = 0.0, boolean closest = false, function filter = nil)
- [PickInfo](PickInfo.md) **Pick**([xVec3](xVec3.md) p0, [xVec3](xVec3.md) p1, number radius = 0.0, boolean closest = false, function filter = nil, extra = nil)

| Parameter | Description |
| --- | --- |
| p0 | line start position |
| p1 | line end position |
| radius | if greater than zero a swept sphere intersection test will be performed |
| closest | if set to true the closest intersected point will be found, otherwise the routine will return on the first hit |
| filter | optional callback to filter objects |
| extra | optional extra value to pass to filter |

## Returns

If the line segment intersects the entity, the resulting PickInfo's *success* member will be set to true, otherwise it will be false.

If a filter callback is provided it will be called for each entity that is evaluated. If the callback returns true the entity will be tested, otherwise it will be skipped.

If defined, the filter function should accept an entity and an extra value, and return true if the entity should be tested:

```lua
function filter(entity, extra)
    return true
end
```

## Example

![](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/World_Pick.gif)

```lua
-- Get the displays
local displays = GetDisplays()

-- Create window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

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
light:SetColor(5)

-- Set up the scene
local floor = CreatePlane(world, 100, 100)
floor:Move(0, -1, 0)

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

local spin_speed = 0.5
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do
    pivot:Turn(0.0, spin_speed, 0.0)

    local target_pos = Vec3(0.0, 0.0, rod_scale)

    local m = pivot:GetMatrix(true)
    m = m:Inverse()
    local identity = Mat4(1)

    target_pos = TransformPoint(target_pos, identity, m)

    -- Perform a ray cast
    local pick_info = world:Pick(pivot:GetPosition(true), target_pos, 0.25, true)
    if pick_info.entity then
        sphere:SetPosition(pick_info.position, true)
    else
        sphere:SetPosition(target_pos, true)
    end

    -- Update the world
    world:Update()

    -- Render the world
    world:Render(framebuffer)
end
```
