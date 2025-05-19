# CreateMeshCollider

This function creates a collider from a mesh or model.

## Syntax

- [Collider](Collider.md) __CreateMeshCollider__([Mesh](Mesh.md) geometry, boolean optimize = true)
- [Collider](Collider.md) __CreateMeshCollider__([Mesh](Model.md) geometry, boolean optimize = true)

| Parameter | Description |
|---|---|
| geometry | mesh or model to build the collision from |
| optimize | if set to true, the creation routine will attempt to merge coplanar faces |

## Remarks

An entity that uses a mesh collider will remain stationary and will not react to physics forces, although other objects will collide with it.

## Example

```lua
--Get display list
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_TITLEBAR | WINDOW_CENTER)

--Create framebuffer
local framebuffer = CreateFramebuffer(window)

--Create world
local world = CreateWorld()

--Create camera
local camera = CreateCamera(world)
camera:SetFov(70)
camera:Turn(15, 0, 0)
camera:Move(0, 0, -12)
camera:SetClearColor(0.125)

--Create light
local light = CreateDirectionalLight(world)
light:SetColor(2)
light:SetRotation(45, 35, 0)

--Load model
local model = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Structures/wooden%20bridge.glb")
model:SetRotation(0, 90, 0)

--Create collision
local collider = CreateMeshCollider(model)
model:SetCollider(collider)
model:SetCollisionType(COLLISION_SCENE)

--Add some objects to show collision
local boxes = {}
for n = 1, 3 do
    local box = CreateBox(world)
    box:SetScale(2)
    box:SetPosition(Random(-2, 2), 16 + 3 * n, Random(-2, 2))
    box:SetMass(1)
    table.insert(boxes, box)
end

while window:Closed() == false and window:KeyHit(KEY_ESCAPE) == false do
    world:Update()
    world:Render(framebuffer)
end
```
