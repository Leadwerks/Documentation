# Entity:AddPointForce

This method applies a force, measured in Newtons, to an entity at a specified point. This can result in both movement and rotation of the entity.

## Syntax

- void **AddPointForce**(number fx, number fy, number fz, number x, number y, number z, boolean global = true)
- void **AddPointForce**([xVec3](xVec3.md) force, [xVec3](xVec3.md) position, boolean global = true)

| Parameter | Description |
| --- | --- |
| force, (fx, fy, fz) | force to add |
| position, (x, y, z) | point where the force is applied |

## Example

```lua
--Get the displays
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

--Create a framebuffer
local framebuffer = CreateFramebuffer(window)

--Create a world
local world = CreateWorld()

--Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetPosition(0, 0, -2)

--Create a light
local light = CreateBoxLight(world)
light:SetRotation(45, 35, 0)
light:SetColor(2)
light:SetRange(-5, 5)

--Create a model
local box = CreateBox(world)
box:SetMass(1)
box:SetColor(0, 0, 1)
box:SetGravityMode(false)
box:SetDamping(0.9, 0.9)

while window:KeyDown(KEY_ESCAPE) == false and window:Closed() == false do

    --Click the mouse to apply a force
    if window:MouseHit(MOUSE_LEFT) then
        local mousepos = window:GetMousePosition()
        local pick = camera:Pick(framebuffer, mousepos.x, mousepos.y)
        if pick.success then
            box:AddPointForce(Vec3(0, 0, 1), pick.position)
        end
    end

	--Update the world
	world:Update()

	--Render the world to the framebuffer
	world:Render(framebuffer)

end
```
