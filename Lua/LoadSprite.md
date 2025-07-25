# LoadSprite

This function loads a texture, creates a sprite with the dimensions of the texture image, and applies the texture to the sprite material.

## Syntax

- [Sprite](Sprite.md) **LoadSprite**([World](World.md) world, [WString](WString.md) path)
- [Sprite](Sprite.md) **LoadSprite**([World](World.md) world, [WString](WString.md) path, number flags)
- [Sprite](Sprite.md) **LoadSprite**([World](World.md) world, [Stream](Stream.md) stream)
- [Sprite](Sprite.md) **LoadSprite**([World](World.md) world, [Stream](Stream.md) stream, number flags)

| Parameter | Description |
|---|---|
| world | |
| path | | 
| stream | |
| flags | |

## Returns

If the texture is successfully loaded a new sprite is returned, otherwise NULL is returned.

## Example

```lua
-- Get the displays
local displays = GetDisplays()

-- Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create world
local world = CreateWorld()

-- Create camera
local camera = CreateCamera(world, PROJECTION_ORTHOGRAPHIC)
camera:SetClearColor(0.125)

-- Create sprite
local sprite = LoadSprite(world, "https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets/Materials/Sprites/nightraider.dds")
sprite:SetPosition(-sprite.size.x * 0.5, -sprite.size.y * 0.5, 0)
sprite.mesh.material:SetAlphaMask(true)

-- Main loop
while (not window:Closed()) and (not window:KeyHit(KEY_ESCAPE)) do
    world:Update()
    world:Render(framebuffer)
end
```
