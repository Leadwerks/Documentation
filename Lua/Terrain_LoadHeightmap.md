# Terrain:LoadHeightmap

This method loads a heightmap onto the terrain.

## Syntax

- bool **LoadHeightmap**([string]() path, [Vec2](Vec2.md) range, number flags = LOAD_DEFAULT)

| Parameter | Description |
|---|---|
| path | file path to load |
| range | optional min and max elevation to rescale the heightmap |
| flags | optional load flags |

## Returns

Returns true if the heightmap is successfully loaded, otherwise false is returned.

## Example

```lua
-- Get the displays
local displays = GetDisplays()

-- Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR | WINDOW_CLIENTCOORDS)

-- Create a framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create a world
local world = CreateWorld()

-- Create a camera
local camera = CreateCamera(world)
camera:SetFov(70)
camera:SetClearColor(0.125)
camera:SetRotation(45, 0, 0)
camera:Move(0, 0, -500)

-- Create a light
local light = CreateDirectionalLight(world)
light:SetRotation(45, 45, 0)

-- Create terrain
local terrain = CreateTerrain(world, 1024)
terrain:LoadHeightmap("https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets/Terrain/1024.r16")
terrain:SetScale(1, 300, 1)
terrain:SetPosition(0, -100, 0)

-- Main loop
while window:Closed() == false and window:KeyDown(KEY_ESCAPE) == false do
    world:Update()
    world:Render(framebuffer)
end
```
