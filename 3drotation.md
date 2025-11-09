# 3D Rotation

We already saw rotation in 2D space, as a single angle. In 3D space we have a type of rotation called Euler angles, which consists of three separate rotations that go around the X, Y, and Z axis. These are commonly referred to as pitch (X), yaw (Y), and roll (Z).

www.youtube.com/watch?v=_4MFKVUmg9A

## Left-handed Rotation Rule

To determine the positive direction of rotation for each axis, we can use our left hand again. If you point your thumb in the positive direction of each axis like below, your fingers will curl around in the positive direction of rotation:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/lefthandrotation.jpg?raw=true)

Since this image shows the thumb pointing up, in the positive direction of the Y axis, that means that increasing the rotation on the Y axis will make objects turn to the right.

If you point your thumb in the positive direction of the X axis (left) your fingers curl downwards. The means increasing the X rotation will make an object that is facing forward turn downwards.

If you point your thumb in the positive direction of the Z axis (forward) your fingers will curl up and to the left. That means increase the Z rotation of an object that is facing forward will make it tilt to the left.

If you're ever confused about which direction of rotation is which, just use the left-hand rule.

## Order of Rotation

When a Euler rotation is specified, the angle for each axis is applied in the order of yaw first, then pitch, then roll. This is like spinning around to face one direction, turning your head up, and then tilting your head to the side.

## Gimbal Lock

One key issue occurs when an object pitches up or down close to ±90 degrees. At these points, the yaw and roll rotations can become indistinguishable because they start to rotate around the same axis. This causes what's known as "gimbal lock," where the math that calculates and interprets these angles breaks down or produces ambiguous results.

In essence, although Euler angles always mathematically represent some rotation, converting from a rotation matrix or quaternion back to Euler angles can yield multiple valid solutions. It's kind of like how you can turn a cow into a hamburger (by cutting it up), but you can't reverse the process to get the cow back from the hamburger—once it's broken down, you can't reconstruct the original.

If other parts of the game like the physics system change the entity's orientation, the system recalculates the Euler angles based on the new orientation. Because of the ambiguities and potential for gimbal lock, this can sometimes lead to unexpected or inconsistent rotations. Here's an example that demonstrates the problem:

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
	
    --Get the quaternion rotation and convert to a Euler
    local r = ship:GetRotation()
	
    --Key controls rotate the ship
    if window:KeyDown(KEY_RIGHT) then r.y = r.y + 1 end
    if window:KeyDown(KEY_LEFT) then r.y = r.y - 1 end
	
    if window:KeyDown(KEY_W) then r.x = r.x - 1 end
	if window:KeyDown(KEY_S) then r.x = r.x + 1 end

    if window:KeyDown(KEY_A) then r.z = r.z + 1 end
    if window:KeyDown(KEY_D) then r.z = r.z - 1 end

    --Set the rotation
    ship:SetRotation(r)

	--This causes a new Euler rotation value to be calculated from the internal orientation
	ship:Turn(1,0,0)
	ship:Turn(-1,0,0)
	
    --Display the rotation
    label:SetText("Rotation: "..tostring(r.x)..", "..tostring(r.y)..", "..tostring(r.z))

    --Update the world
    world:Update()

    --Render the world
    world:Render(framebuffer)
end
```

## Quaternions

Quaternions are a more advanced definition of rotation that don't have the ambiguity of Euler angles. Quaternions use four numbers, x, y, z, and w, to define a rotation. They aren't very human-friendly, but you don't need to understand what the actual numbers mean.

Any time you set an entity's rotation using Euler angles, Leadwerks will calculate and store the correponding quaternion rotation. You can retrieve the entity rotation as a quaternion using the [Entity:GetQuaternion](Entity_GetQuaternion.md) method.

The [Entity:Turn](Entity_Turn.md) method will use the interally stored quaternion to apply rotation to the entity's current rotation, always producing a correct result:

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
	
	--Key controls rotate the ship
	if window:KeyDown(KEY_RIGHT) then ship:Turn(0,1,0) end
	if window:KeyDown(KEY_LEFT) then ship:Turn(0,-1,0) end
		
	if window:KeyDown(KEY_W) then ship:Turn(-1,0,0) end
	if window:KeyDown(KEY_S) then ship:Turn(1,0,0) end
		
	if window:KeyDown(KEY_A) then ship:Turn(0,0,1) end
	if window:KeyDown(KEY_D) then ship:Turn(0,0,-1) end
	
	--Display the rotation
	r = ship.rotation
	label:SetText("Rotation: "..tostring(r.x)..", "..tostring(r.y)..", "..tostring(r.z))

    --Update the world
    world:Update()
	
    --Render the world
    world:Render(framebuffer)
end
```

### Spherical Linear Interpolation

If we try to interpolate Euler rotations using the [MixAngle](MixAngle.md) function for each axis, the resulting motion will look strange. Pitch, yaw, and roll are being interpolated independently, resulting in a lot of excess motion that doesn't take the shortest route between the current and target rotations.

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
    ship:SetRotation(MixAngle(ship.rotation.x, target[n].x, 0.05), MixAngle(ship.rotation.y, target[n].y, 0.05), MixAngle(ship.rotation.z, target[n].z, 0.05))

    --Update the world
    world:Update()

    --Render the world
    world:Render(framebuffer)
end
```
Quaternions support a special type of interpolation called _spherical linear interapoltion_, or [Slerp](Quat_Slerp.md) for short. This can be used to smoothly interpolate between any two rotations, always using the shortest distance.

Replace the rotation code at line 36 with this line of code that uses spherical linear interapoltion:

```lua
local qcurrent = ship:GetQuaternion()
local qtarget = Quat(target[n])
ship:SetRotation(qcurrent:Slerp(qtarget, 0.05))
```

This provides fluid natural looking rotation that looks great in games.

```lua
-- Get the displays
local displays = GetDisplays()

-- Create window
local window = CreateWindow("Leadwerks", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create world
local world = CreateWorld()
world:SetAmbientLight(0.1)

local light = CreateDirectionalLight(world)
light:SetRotation(45,25,0)
light:SetShadowCascadeDistance(10,20,40,80)

-- Create the ground
local ground = CreateBox(world, 50, 1, 50)
ground:SetPosition(0,-0.5,0)
ground:SetColor(0.5)

-- Create a simple arch
local col1 = CreateBox(world, 1, 3, 1)
col1:SetPosition(3,1.5,0)
col1:SetColor(0,1,0)

local col2 = CreateBox(world, 1, 3, 1)
col2:SetPosition(-3,1.5,0)
col2:SetColor(0,1,0)

local box = CreateBox(world, 7, 1, 1)
box:SetPosition(0,3.5,0)
box:SetColor(0,1,0)

-- Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)

--Create the player
local player = CreatePivot(world)
player:SetMass(10)
player:SetPhysicsMode(PHYSICS_PLAYER)
player:SetCollisionType(COLLISION_PLAYER)
player:SetPosition(0,0,-2)
player:SetShadows(true)

--Create a visible model for the player
local model = CreateCylinder(world, 0.5, 2)
model:SetPosition(0,1,-2)
model:SetParent(player)
model:SetCollider(nil)
model:SetCollisionType(COLLISION_NONE)
model:SetColor(0,0,1)

--Some variables we will use
local maxcameradistance = 5
local cameradistance = maxcameradistance
local cx = Round(framebuffer.size.x / 2)
local cy = Round(framebuffer.size.y / 2)
local camerarotation = Vec3(35,0,0)
local mousespeed = 0.1
local movespeed = 5

--Prepare window stuff
window:SetCursor(CURSOR_NONE)
window:SetMousePosition(cx, cy)

while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do

	--Get the mouse move distance
	local mousepos = window:GetMousePosition()
	local dx = mousepos.x - cx
	local dy = mousepos.y - cy
	window:SetMousePosition(cx, cy)
		
	--Calculate the new camera rotation
	camerarotation.x = camerarotation.x + dy * mousespeed
	camerarotation.y = camerarotation.y + dx * mousespeed
	camerarotation.x = Clamp(camerarotation.x, 0, 90)

	--Handle player movement
	local angle = 0
	local move = 0
	local strafe = 0
	
	if window:KeyDown(KEY_W) then move = move + movespeed end
	if window:KeyDown(KEY_S) then move = move - movespeed end
	if window:KeyDown(KEY_D) then strafe = strafe + movespeed end
	if window:KeyDown(KEY_A) then strafe = strafe - movespeed end
	
	player:SetInput(camerarotation.y, move, strafe)
	
    -- Update the world
    world:Update()

	-- Update the camera orientation
	camera:SetRotation(camerarotation)
	camera:SetPosition(player.position + Vec3(0,1.8,0))
	
	--Perform a raycast from the player's head, in the direction of the camera vector, to the maximum camera range
	local pickinfo = world:Pick(camera.position, TransformPoint(0,0,-maxcameradistance, camera, nil), 0.25, true)
	
	if pickinfo.entity then
		--If anything was hit, use the pick position as the camera position
		cameradistance = pickinfo.position:DistanceToPoint(camera.position)
	else
		--If nothing was hit then adjust the camera distance to move smoothly to the max distance
		cameradistance = Mix(cameradistance, maxcameradistance, 0.1)
	end
	
	--Move the camera away from the player
	camera:Move(0,0,-cameradistance)
		
    -- Render the world
    world:Render(framebuffer)
end
```
