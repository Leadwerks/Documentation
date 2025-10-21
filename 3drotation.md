# 3D Rotation

We already saw rotation in 2D space, as a single angle. In 3D space we have a type of rotation called Euler angles, which consists of three separate rotations that go around the X, Y, and Z axis. These are commonly referred to as pitch (X), yaw (Y), and roll (Z).



## Gimbal Lock

Unfortunately, Euler angles do not give us a complete definition of rotation that works in all situations. As an object pitches up or down approaching +/- 90 degrees, yaw and roll start rotating around the same axis. When we get near this pitch, our math stops working.

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

local font = LoadFont("Fonts/arial.ttf")
local label = CreateTile(camera, font, "Rotation:")

--Main loop
while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do

	if window:KeyDown(KEY_RIGHT) then ship:SetRotation(ship.rotation.x, ship.rotation.y + 1, ship.rotation.z) end
	if window:KeyDown(KEY_LEFT) then ship:SetRotation(ship.rotation.x, ship.rotation.y - 1, ship.rotation.z) end
		
	if window:KeyDown(KEY_UP) then ship:SetRotation(ship.rotation.x - 1, ship.rotation.y, ship.rotation.z) end
	if window:KeyDown(KEY_DOWN) then ship:SetRotation(ship.rotation.x + 1, ship.rotation.y, ship.rotation.z) end
		
	if window:KeyDown(KEY_Q) then ship:SetRotation(ship.rotation.x, ship.rotation.y, ship.rotation.z + 1) end
	if window:KeyDown(KEY_A) then ship:SetRotation(ship.rotation.x, ship.rotation.y, ship.rotation.z - 1) end
	
	--Recalculate the Euler rotation from the quaternion to force reset rotation
	local r = ship:GetQuaternion()
	r = r:ToEuler()
	ship:SetRotation(r)
	
	label:SetText("Rotation: "..tostring(r.x)..", "..tostring(r.y)..", "..tostring(r.z))

    --Update the world
    world:Update()
	
    --Render the world
    world:Render(framebuffer)
end
```

## Quaternions

Quaternions are a more advanced definition of rotation that don't have the ambiguity of Euler angles. Quaternions use four numbers, x, y, z, and w, to define a rotation. They aren't very human-friendly, but you don't need to understand what the actual numbers mean.

Any time you set an entity's rotation using Euler angles, Leadwerks will calculate and store the correponding quaternion rotation.

### Spherical Linear Interpolation

The major advantage of quaternions is they can be used to smoothly interpolate between any two rotations, always using the shortest distance. This provides fluid natural looking rotation that looks great in games.

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
