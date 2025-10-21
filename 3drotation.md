# 3D Rotation

We already saw rotation in 2D space, as a single angle. In 3D space we have a type of rotation called Euler angles, which consists of three separate rotations that go around the X, Y, and Z axis. These are commonly referred to as pitch (X), yaw (Y), and roll (Z).



## Gimbal Lock

Unfortunately, Euler angles do not give us a complete definition of rotation that works in all situations. As an object pitches up or down approaching +/- 90 degrees, yaw and roll start rotating around the same axis. When we get near this pitch, our math stops working.



## Quaternions



### Spherical Linear Interpolation

```lua
--Get the displays
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_TITLEBAR | WINDOW_CENTER)

--Create a framebuffer
local framebuffer = CreateFramebuffer(window)

--Create a world
local world = CreateWorld()
world:SetAmbientLight(1)

--Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:Move(0,0,-2)

local ship = LoadModel(world, "https://github.com/Leadwerks/Documentation/raw/refs/heads/master/Assets/Models/Spaceship/spaceship.mdl")

local target = {}
target[1] = Vec3(90,270,45)
target[2] = Vec3(-90,-270,45)

local n = 1

--Main loop
while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do
	
	if window:KeyHit(KEY_SPACE) then
		n = n + 1
		if n > 2 then n = 1 end
	end
	
	--Interpolating each axis rotation does not provide the shortest rotation
	--ship:SetRotation(MixAngle(ship.rotation.x, target[n].x, 0.05), MixAngle(ship.rotation.y, target[n].y, 0.05), MixAngle(ship.rotation.z, target[n].z, 0.05))
	
	--Spherical linear interpolation provides the shortest rotation
	ship:SetRotation(ship:GetQuaternion():Slerp(Quat(target[n]), 0.05))
	
    --Update the world
    world:Update()
	
    --Render the world
    world:Render(framebuffer)
end
```
