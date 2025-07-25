# World:RecordStats

This method is used to enable or disable statistics recording. Statistics recording is disabled by default, so you need to enable it if you are displaying statistical information.

## Syntax

- **RecordStats**(boolean record)

| Parameter | Description |
|---|---|
| record | if set to true, statistics recording is enabled. Otherwise, it is disabled |

## Remarks

When statistics recording is enabled, the world [RenderStats](RenderStats.md), [AnimationStats](AnimationStats.md), and [PhysicsStats](PhysicsStats.md) information will be available.

## Example

```lua
-- Get the displays
local displays = GetDisplays()

-- Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1])

-- Create a framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create a world
local world = CreateWorld()

-- Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:Move(0, 0, -4)

-- Create light
local light = CreateBoxLight(world)
light:SetRange(-20, 20)
light:SetArea(20, 20)
light:SetRotation(45, 35, 0)

-- Create model
local box = CreateBox(world)

-- Enable stats recording
world:RecordStats(true)

-- Setup 2D display
local cam2d = CreateCamera(world, PROJECTION_ORTHOGRAPHIC)
cam2d:SetRenderLayers(128)
cam2d:SetClearMode(CLEAR_DEPTH)
cam2d:SetPosition(framebuffer.size.x * 0.5, framebuffer.size.y * 0.5, 0)

local font = LoadFont("Fonts/arial.ttf")
local sprite = CreateSprite(world, font, "", 18)
sprite:SetRenderLayers(128)
sprite:SetPosition(2, framebuffer.size.y - font:GetHeight(18) - 2, 0)

-- Main loop
while window:Closed() == false and window:KeyDown(KEY_ESCAPE) == false do

    box:Turn(0,1,0)

    -- Display the framerate
    sprite:SetText("FPS: " .. tostring(world.renderstats.framerate))

    world:Update()
    world:Render(framebuffer)
end
```
