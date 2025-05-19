# Model:Animate

This method causes an animation sequence to play.

## Syntax
- **Animate**(number sequence = 0, number speed = 1.0f, number blendtime = 250, number mode = ANIMATION_LOOP, number frame = 0, number track = 0)
- **Animate**([string](https://www.lua.org/manual/5.4/manual.html#6.4) sequence, number speed = 1.0f, number blendtime = 250, number mode = ANIMATION_LOOP, number frame = 0, number track = 0)

| Parameter | Description |
| ---- | ----------- |
| sequence | animation sequence index or name. Sequence names are not case-sensitive |
| speed | animation speed. Default value is 1.0 |
| blendtime | animation transition time, in milliseconds. Default value is 250 |
| mode | animation playback mode. This can be ANIMATION_LOOP, ANIMATION_ONCE, or ANIMATION_STOP |
| frame | starting animation frame to use. Default value is 0 |
| track | animation track, for playing multiple animations at once. Default value is 0 |

## Example

This example loads and displays an animated model.

![](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/model_animate.jpg)

```lua
--Get the displays
local displays = GetDisplays()

-- Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create a framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create a world
local world = CreateWorld()

-- Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetFov(70)
camera:Move(0, 2, -8)

-- Create light
local light = CreateBoxLight(world)
light:SetRotation(45, 35, 0)
light:SetRange(-10, 10)
light:SetArea(20, 20)

-- Create ground
local ground = CreateBox(world, 10, 1, 10)
ground:SetColor(0, 1, 0)
ground:SetPosition(0, -0.5, 0)

-- Load a model
local model = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Characters/Fox.glb")
model:SetScale(0.05)
model:SetRotation(0, -90, 0)
model:Animate(1)

-- Main loop
while window:Closed() == false and window:KeyDown(KEY_ESCAPE) == false do
    world:Update()
    world:Render(framebuffer)
end
```
