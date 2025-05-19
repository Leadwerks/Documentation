# LoadCollider

This function loads a collision shape from a JSON file. Collision objects can be saved to a file by calling the [Save](Asset_Save.md) method.

## Syntax

- [Collider](Collider.md) __LoadCollider__([string](https://www.lua.org/manual/5.4/manual.html#6.4), number flags = LOAD_DEFAULT)

| Parameter | Description |
| --- | --- |
| path | file path to open |
| flags | optional load flags |

## Returns

Returns the loaded collider object if it was successfully loaded, otherwise nil is returned.

## Example

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
light:SetColor(2)
light:SetRotation(45, 35, 0)

--Create ground
local ground = CreateBox(world, 10, 1, 10)
ground:SetColor(0, 1, 0)
ground:SetPosition(0, -0.5, 0)

--Load model
local model = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Containers/crate01.glb")
model:SetPosition(0, 5, 0)
model:SetRotation(0, 0, 15)
model:SetMass(1)

--Load collision
local collider = LoadCollider("https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Containers/crate01.phy")
model:SetCollider(collider)

while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do
    world:Update()
    world:Render(framebuffer)
end
```
