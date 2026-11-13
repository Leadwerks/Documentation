# Bone:SetScale

This method can be used to manually scale a bone. You can control skinned models enirely in code or apply your own movements on top of animation.

## Syntax

- **SetScale**(number scale)

| Parameter | Description |
|---|---|
| scale | uniform scale to set |

## Remarks

To combine programmatic movement with animation, this method should be called after [World::Update](World_Update.md) and before [World::Render](World_Render.md).

## Example

This example will load and display an animated model, but we will add code to give the character a supersized noggin.

![](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/bone_setscale.jpg)

```lua
-- Get the displays
local displays = GetDisplays()

-- Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_CENTER + WINDOW_TITLEBAR)

-- Create a framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create a world
local world = CreateWorld()

-- Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetFOV(70)
camera:Move(0, 2, -8)

-- Create light
local light = CreateBoxLight(world)
light:SetRotation(45, 35, 0)
light:SetRange(-10, 10)

-- Model by PixelMannen
-- https://opengameart.org/content/fox-and-shiba
local model = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Characters/Fox.glb")
model:SetScale(0.05)
model:Animate(1)
model:SetRotation(0, -90, 0)

local neck = model.skeleton:FindBone("b_Neck_04")
local rotation = Vec3(0)

-- Main loop
while (window:Closed() == false)
do
    world:Update()

    rotation.y = Cos(Millisecs() / 10.0) * 65.0
    neck:SetRotation(rotation)
    neck:SetScale(2)

    world:Render(framebuffer)
end
```
