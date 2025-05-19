# Bone:Turn

This method smoothly adds rotation to the current rotation.

## Syntax

- **Turn**(number pitch, number yaw, number roll, boolean global = false)
- **Turn**([Vec3](#vec3) rotation, boolean global = false)

| Parameter | Description |
|---|---|
| rotation, (pitch, yaw, roll) | rotation to apply |
| global | if set to true rotation is relative to the skeleton, otherwise it is relative to the bone's parent |

## Remarks

To combine programmatic movement with animation, this method should be called after [World:Update](worldupdate) and before [World:Render](worldrender).

## Example

This example will load and display an animated model, but we will add code to turn the character's head back and forth as they walk.

![bone_setrotation.jpg](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/bone_setrotation.jpg)

```lua
--Get the displays
local displays = UltraEngine.GetDisplays()

--Create a window
local window = UltraEngine.CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[0], WINDOW_CENTER | WINDOW_TITLEBAR)

--Create a framebuffer
local framebuffer = UltraEngine.CreateFramebuffer(window)

--Create a world
local world = UltraEngine.CreateWorld()

--Create a camera
local camera = UltraEngine.CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetFOV(70)
camera:Move(0, 2, -8)

--Create light
local light = UltraEngine.CreateBoxLight(world)
light:SetRotation(45, 35, 0)
light:SetRange(-10, 10)

--Model by PixelMannen
--https://opengameart.org/content/fox-and-shiba
local model = UltraEngine.LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Characters/Fox.glb")
model:SetScale(0.05)
model:Animate(1)
model:SetRotation(0, -90, 0)

local neck = model.skeleton:FindBone("b_Neck_04")
local rotation = UltraEngine.Vec3()

--Main loop
while window:Closed() == false do
    world:Update()

    rotation.y = math.cos(UltraEngine.Millisecs() / 10.0) * 65.0
    neck:Turn(rotation, true)

    world:Render(framebuffer)
end
```
