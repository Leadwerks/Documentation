# LoadScene

This command loads a scene from a file path or stream.

## Syntax

- [Scene](Scene.md) **LoadScene**([World](World.md) world, [string](https://www.lua.org/manual/5.4/manual.html#6.4) path)
- [Scene](Scene.md) **LoadScene**([World](World.md) world, [string](https://www.lua.org/manual/5.4/manual.html#6.4) path, number flags = LOAD_DEFAULT)
- [Scene](Scene.md) **LoadScene**([World](World.md) world, [string](https://www.lua.org/manual/5.4/manual.html#6.4) path, number flags = LOAD_DEFAULT, extra = nil)
- [Scene](Scene.md) **LoadScene**([World](World.md) world, [Stream](Stream.md) stream, [Stream](Stream.md) binstream)
- [Scene](Scene.md) **LoadScene**([World](World.md) world, [Stream](Stream.md) stream, [Stream](Stream.md) binstream, number flags = LOAD_DEFAULT)
- [Scene](Scene.md) **LoadScene**([World](World.md) world, [Stream](Stream.md) stream, [Stream](Stream.md) binstream, number flags = LOAD_DEFAULT, extra = nil)

## Returns

If the scene is successfully loaded a new map is returned, otherwise NULL is returned.

## Remarks

This feature is in continued development and its behavior may change somewhat in future updates.

## Example

This example saves the starting map and reloads it when the space key is pressed.

```lua
-- Get the displays
local displays = GetDisplays()

-- Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_CENTER + WINDOW_TITLEBAR)

-- Create a world
local world = CreateWorld()

-- Create a framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetPosition(0, 1, -4)

-- Create light
local light = CreateBoxLight(world)
light:SetRange(-10, 10)
light:SetArea(15, 15)
light:SetRotation(45, 35, 0)
light:SetColor(2)

-- Create the ground
local ground = CreateBox(world, 10, 1, 10)
ground:SetPosition(0, -0.5, 0)
ground:SetColor(0, 1, 0)

-- Create a scene
local scene = CreateScene()
scene.entities:push_back(ground)
scene.entities:push_back(light)
ground = nil
light = nil

-- Add some boxes
for n = 1, 10 do
    local box = CreateBox(world)
    box:SetColor(0, 0, 1)
    box:SetPosition(Random(-5, 5), Random(5, 10), Random(-5, 5))
    box:SetMass(1)
    scene.entities:push_back(box)
end

-- Save the starting scene to memory
local stream = CreateBufferStream()
local binstream = CreateBufferStream()
scene:Save(stream, binstream)

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do
    -- Reload the starting scene when space key is pressed
    if window:KeyHit(KEY_SPACE) then
        stream:Seek(0)
        binstream:Seek(0)
        scene = LoadScene(world, stream, binstream)
    end

    world:Update()
    world:Render(framebuffer)
end

return 0
```
