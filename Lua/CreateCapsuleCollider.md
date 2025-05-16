# CreateCapsuleCollider

This function creates a collision cylinder shape for physics interactions.

## Syntax

- [Collider](Collider.md) **CreateCapsuleCollider**(number radius, number height, [xVec3](xVec3.md) offset = 0, [xVec3](xVec3.md) rotation = 0)
- [Collider](Collider.md) **CreateCapsuleCollider**(number radius, number height, number x = 0, number y = 0, number z = 0, number pitch = 0, number yaw = 0, number roll = 0)

Parameter | Description
---|---
offset, (x, y, z) | offset of shape
rotation, (pitch, yaw, roll) | rotation of shape

## Returns

Returns a new collider object.

## Example

```lua
local displays = GetDisplays()

-- Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_TITLEBAR | WINDOW_CENTER)

-- Create framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create world
local world = CreateWorld()

-- Create camera
local camera = CreateCamera(world)
camera:SetFov(70)
camera:Turn(15, 0, 0)
camera:Move(0, 2, -8)
camera:SetClearColor(0.125)

-- Create light
local light = CreateDirectionalLight(world)
light:SetRotation(45, 35, 0)
light:SetColor(2)

-- Create ground
local ground = CreateBox(world, 10, 1, 10)
ground:SetPosition(0, -0.5, 0)
ground:SetColor(0, 1, 0)

-- Create model
local model = CreateCylinder(world, 0.5, 4)
model:SetPosition(0, 5, 0)
model:Turn(90, 10, 0)
model:SetColor(0, 0, 1)
model:SetMass(1)
model:AddForce(100, 0, 0)

-- Create collider
local collider = CreateCapsuleCollider(0.5, 4)
model:SetCollider(collider)

while window:Closed() == false and window:KeyHit(KEY_ESCAPE) == false do
    world:Update()
    world:Render(framebuffer)
end
```

Note: This example assumes that the necessary libraries have already been imported to Lua and that the required functions and variables are available.
