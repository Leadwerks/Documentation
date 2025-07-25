# Entity:AlignToVector

This method will align one axis of an entity along a specified vector in global space.

## Syntax

- **AlignToVector**(number x, number y, number z)
- **AlignToVector**(number x, number y, number z, number axis = 2)
- **AlignToVector**(number x, number y, number z, number axis = 2, number rate = 1.0)
- **AlignToVector**(number x, number y, number z, number axis = 2, number rate = 1.0, number roll = 0.0)
- **AlignToVector**([xVec3](xVec3.md) v)
- **AlignToVector**([xVec3](xVec3.md) v, number axis = 2)
- **AlignToVector**([xVec3](xVec3.md) v, number axis = 2, number rate = 1.0)
- **AlignToVector**([xVec3](xVec3.md) v, number axis = 2, number rate = 1.0, number roll = 0.0)

| Parameter | Description |
| --- | --- |
| v, (x, y, z) | alignment vector  |
| axis | entity axis to align to the vector (0, 1, or 2) |
| rate | can be used to gradually align vector |
| roll | rotation around axis |

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

--Main loop
while window:KeyDown(KEY_ESCAPE) == false and window:Closed() == false do

	--Move the mouse to point the box
	local mousepos = window:GetMousePosition()
	local dir = Vec3(0)
	dir.x = mousepos.x - framebuffer.size.x / 2
	dir.y = -(mousepos.y - framebuffer.size.y / 2)
	box:AlignToVector(dir, 1, 0.1)

	--Update the world
	world:Update()

	--Render the world to the framebuffer
	world:Render(framebuffer)

end
```
