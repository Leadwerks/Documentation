# Entity:AddTorque

This method adds physical torque to the entity, measured in Newton metres.

## Syntax

- void **AddTorque**(number x, number y, number z)
- void **AddTorque**(number x, number y, number z, boolean global)
- void **AddTorque**([xVec3](xVec3.md) torque)
- void **AddTorque**([xVec3](xVec3.md) torque, boolean global)

| Parameter | Description |
| - | - |
| torque, (x, y, z) | torque to add |
| global | set to true to indicate a rotation in global space, otherwise the rotation will be in local space |

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

while window:KeyDown(KEY_ESCAPE) == false and window:Closed() == false do

	--Press the space key to apply a force
	if window:KeyHit(KEY_SPACE) then
		box:AddTorque(0, 0, 10)
	end

	--Update the world
	world:Update()

	--Render the world to the framebuffer
	world:Render(framebuffer)

end
```
