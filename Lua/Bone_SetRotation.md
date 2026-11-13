# Bone:SetRotation

This method can be used to manually rotate a bone. You can control skinned models enirely in code or apply your own movements on top of animation.

## Syntax

- **SetRotation**(number pitch, number yaw, number roll, boolean = false)
- **SetRotation**([Vec3](Vec3.md) rotation, boolean global = false)
- **SetRotation**([Quat](Quat.md) rotation, boolean global = false)

| Parameter | Description |
|---|---|
| rotation, (pitch, yaw, roll) | rotation to set |
| global | if set to true rotation is relative to the skeleton, otherwise it is relative to the bone's parent |

## Remarks

To combine programmatic movement with animation, this method should be called after [World::Update](World_Update.md) and before [World::Render](World_Render.md).

## Example

This example will load and display an animated model, but we will add code to turn the character's head back and forth as they walk.

![](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/bone_setrotation.jpg)

```lua
-- Get the displays
local displays = GetDisplays()

-- Create a window
local window = CreateWindow("Leadwerks", 0, 0, 1280, 720, displays[1], WINDOW_CENTER + WINDOW_TITLEBAR)

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

-- Model by PixelMannen
-- https://opengameart.org/content/fox-and-shiba
local model = LoadModel(world, "https://github.com/Leadwerks/Documentation/raw/master/Assets/Models/Characters/Fox.glb")
model:SetScale(0.05)
model:Animate(1)
model:SetRotation(0, -90, 0)

local neck = model.skeleton:FindBone("b_Neck_04")
local rotation = Vec3(0, 0, 0)

-- Main loop
while not window:Closed() do
    world:Update()
    rotation.y = math.cos(Millisecs() / 10.0) * 65.0
    neck:SetRotation(rotation)
    world:Render(framebuffer)
end
```
