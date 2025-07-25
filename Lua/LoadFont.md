# LoadFont

This function loads a font from a file path or stream.

## Syntax

- [Font](Font.md) **LoadFont**([string]([WString.md](https://www.lua.org/manual/5.4/manual.html#6.4)) path)
- [Font](Font.md) **LoadFont**([string]([WString.md](https://www.lua.org/manual/5.4/manual.html#6.4)) path, number flags)
- [Font](Font.md) **LoadFont**([Stream](Stream.md) stream)
- [Font](Font.md) **LoadFont**([Stream](Stream.md) stream, number flags)

| Parameter | Description |
|---|---|
| path | file path to load |
| stream | stream to read from |
| flags | loading options, can be LOAD_DEFAULT or LOAD_NO_CACHE |

## Returns

Returns the loaded font, or NULL of the font could not be loaded.

## Example

```lua
-- Get the displays
local displays = GetDisplays()

-- Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_TITLEBAR + WINDOW_CENTER)

-- Create a framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create a world
local world = CreateWorld()

-- Create a camera
local camera = CreateCamera(world, PROJECTION_ORTHOGRAPHIC)
camera:SetClearColor(0.125)
camera:SetPosition(framebuffer.size.x * 0.5, framebuffer.size.y * 0.5, 0)

-- Create sprite
local fontsize = 36
local font = LoadFont("Fonts/arial.ttf")
local sprite = CreateSprite(world, font, "Hello, World!", fontsize)
local rect = CreateSprite(world, font:GetTextWidth("Hello, World!", fontsize), font:GetHeight(fontsize), true)

--sprite:SetPosition(0,0,0)
rect:SetPosition((framebuffer.size.x - rect.size.x) * 0.5, (framebuffer.size.y - rect.size.y) * 0.5, 0)
sprite:SetPosition((framebuffer.size.x - rect.size.x) * 0.5, (framebuffer.size.y - rect.size.y) * 0.5, 0)

-- Main loop
while (not window:Closed()) and (not window:KeyHit(KEY_ESCAPE)) do
    -- Update world
    world:Update()

    -- Render world
    world:Render(framebuffer, true)
end
```
