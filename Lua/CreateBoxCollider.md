# CreateBoxCollider

This function creates a collider box shape for physics interactions.

## Syntax

- [Collider](Collider.md) **CreateBoxCollider**([Vec3](Vec3.md) size, [Vec3](Vec3.md) offset = 0, [Vec3](Vec3.md) rotation = 0)
- [Collider](Collider.md) **CreateBoxCollider**(number width, number height, number depth, number x = 0, number y = 0, number z = 0, number pitch = 0, number yaw = 0, number roll = 0)

| Parameter | Description |
|---|----|
|width|width of box|
|height|height of box|
|depth|depth of box|
|x|x component of box offset|
|y|y component of box offset|
|z|z component of box offset|
|pitch|pitch of box rotation|
|yaw|yaw of box rotation|
|roll|roll of box rotation|
|size|size of box|
|offset|offset of box|
|rotation|rotation of box|

#### Returns

Returns a new collider object.

#### Example

```lua
--Get the displays 
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

--Create a framebuffer
local framebuffer = CreateFramebuffer(window)

--Create a world
local world = CreateWorld()

--Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:Move(0, 1, -3)
camera:SetFov(70)

--Create light
local light = CreateDirectionalLight(world)
light:SetRotation(45, 35, 0)

--Create ground
local ground = CreateBox(world, 10, 1, 10)
ground:SetPosition(0, -0.5, 0)
ground:SetColor(0, 1, 0)

--Load model
local model = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Containers/crate01.glb")
model:SetPosition(0, 5, 0)
model:SetRotation(0, 0, 15)
model:SetMass(1)

--Create collider
local bounds = model:GetBounds(BOUNDS_LOCAL)
local collider = CreateBoxCollider(bounds.size, bounds.center)
model:SetCollider(collider)

while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do
    world:Update()
    world:Render(framebuffer)
end
```
