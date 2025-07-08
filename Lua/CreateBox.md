# CreateBox

This function creates a new box model with a physics collider.

## Syntax

- [Model](Model.md) CreateBox([World](World.md) world, number size = 1)
- [Model](Model.md) CreateBox([World](World.md) world, number width, number height, number depth, number xsegs = 1, number ysegs = 1, number zsegs = 1, number type = MESH_TRIANGLES)

| Parameter | Description |
|---|---|
| world | world to create the model in |
| size, (width, height, depth) | uniform size or dimensions of the box |
| xsegs, ysegs, zsegs | number of segments on each axis |
| type | can be MESH_TRIANGLES or MESH_QUADS |

## Remarks

For materials that use tessellation, set the *quad* parameter to true.

## Returns

Returns a new model.

## Example

```lua
--Get the displays
local displays = GetDisplays()

-- Create a window
local window = CreateWindow("Leadwerks", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create a world
local world = CreateWorld()

-- Create a framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetPosition(0, 0, -4)

-- Create a light
local light = CreateBoxLight(world)
light:SetRotation(45, 35, 0)
light:SetRange(-10, 10)
light:SetColor(2)

-- Create a model
local model = CreateBox(world)
model:SetColor(0, 0, 1)

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do
    model:Turn(0, 1, 0)
    world:Update()
    world:Render(framebuffer)
end
```
