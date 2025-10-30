# 3D Vectors

If we draw a line from any point in 3D space to the origin (0, 0, 0), we get a vector. A vector is a line with a direction and a length.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/3dvector.png?raw=true)

We have a special class in Leadwerks for handling 3D vectors called [Vec3](Vec3.md). A 3D vector can be created like this:

```lua
v = Vec3(2, 4, 0)
```

We can then access the x, y, and z values individually:

```lua
Print(v.x)
Print(v.y)
Print(v.z)
```

You can think of a Vec3 as either a point in space, or a line from the origin to a point in space.

## Vector Length

The length of a vector is easy to calculate. We just take the X, Y, and Z lengths, square each one, add them together, and take the square root:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/vectorlength.svg?raw=true)

This is a formula you should know by heart, and be able to draw out on paper with the help of a calculator. In code, it would look like this:

```lua
v = Vec3(3, 4, 0)
l = Sqrt(v.x * v.x + v.y * v.y + v.z * v.z)
Print(l)
```

The Vec3 class includes a method that tells uses this forumula to get the length of any 3D vector:

```lua
v = Vec3(3, 4, 0)
l = v:Length()
Print(l)
```

This tells us that the length of this vector is exactly 5 units.

## Normalizing Vectors

Sometimes we want to keep the same direction, but rescale a vector so that its length is exactly one. In mathematics, a vector with a length of one is called is called a _unit vector_. In computer graphics, a unit vector is also called a _normal_, and they have many uses. For example, mesh vertex normals tell the lighting system which direction the surface faces at each vertex and are used for lighting.



The Vec3 class has a method that will returned a normalized version of any vector:

```lua
v = Vec3(-2, 4, 0)
n = v:Normalize()
Print(n.x)
Print(n.y)
Print(n.z)
l = n:Length()
Print(l)
```

This code will print out the following:

```txt
-0.447214
0.894427
0
1
```

Notice that the X and Y values both got smaller, Z stayed the same, and the length of the new vector is exactly one.

The result is a vector that points in the same direction as the first, but instead of being 4.47 units long, its now just one unit in length:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/3dvectorN.png?raw=true)

## Vector Addition and Subtraction

You can add two vectors simply by adding each member together. This shows how to add vectors A and B to make a new vector called C:

```txt
C.x = A.x + B.x
C.y = A.y + B.y
C.z = A.z + B.z
```

With code, the operation looks like this:

```lua
A = Vec3(1, 2, 3)
B = Vec3(2, 3, 1)

C = A + B

Print(C.x)
Print(C.y)
Print(C.z)
```

I don't usually think in numbers. Instead, I like to think in pictures. Adding vectors together visually is easy. All you have to do is connect one vector to the end of the other. Where you end up is the new vector:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/vectoraddition.png?raw=true)

## Vector Multiplication

Just like addition, vector multiplication can be performed by multiplying each vector component together:

```txt
C.x = A.x * B.x
C.y = A.y * B.y
C.z = A.z * B.z
```

We can perform this in one line of code like this:

```lua
C = A * B
```

We can also multiply a vector by a single number:

```lua
A = B * 2
```

This is the exact same thing as multiplying a vector by another vector that has the same value for X, Y, and Z:

```lua
A = B * Vec3(2)
```

Vector multiplication is not as intuitive to visualize, but fortunately usually only use it for a couple of simple situations:

### Scaling a Vector

We can make a vector longer or short by multiplying it by some scaling value:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/vectormultiplication2.png?raw=true)

### Inverting a Vector

If we multiply a vector by negative one, the resulting vector points in the opposite direction, while retaining the same length:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/vectormultiplication.png?raw=true)

## Dot Product

The Vec3 class has a special method called [Dpt](Vec3_Dot.md), which gives the dot product of two vectors. The dot product is a measure of how "alike" the direction of two vectors is.

If the two vectors point in the same exact direction, their dot product will be one.

If the two vectors point in the exact opposite directions, their dot product will be negative one.

If the two vector are perpindicular (they form a 90 degree angle), their dot product will be zero.


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
camera:SetRotation(35,0,0)
camera:Move(0,0,-40)

local ship = LoadModel(world, "https://github.com/Leadwerks/Documentation/raw/refs/heads/master/Assets/Models/Spaceship/spaceship.mdl")

local viewcone = CreateCone(world, 100, 100)
viewcone:SetRotation(-90,0,0)
viewcone:SetPosition(0,0,50)
viewcone:SetParent(ship)
viewcone:SetColor(2,2,0,0.5)
viewcone:SetScale(1,1,0.01)

local mtl = CreateMaterial()
mtl:SetTransparent(true)
viewcone:SetMaterial(mtl)

local enemy = CreateBox(world)
enemy:SetPosition(0,0,10)

local angleindicator1 = CreateBox(world)
local angleindicator2 = CreateBox(world)
angleindicator1:SetColor(1,1,0)
angleindicator2:SetColor(1,1,0)

local font = LoadFont("Fonts/arial.ttf")
local label1 = CreateTile(camera, font, "")
local label2 = CreateTile(camera, font, "")
label2:SetPosition(0,20)

--Main loop
while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do
	
	--Simple movement controls
	if window:KeyDown(KEY_RIGHT) then ship:Turn(0,1,0) end
	if window:KeyDown(KEY_LEFT) then ship:Turn(0,-1,0) end
	if window:KeyDown(KEY_UP) then ship:Move(0,0,0.1) end
	if window:KeyDown(KEY_DOWN) then ship:Move(0,0,-0.1) end
	
	--Make the camera follow the ship
	--camera:SetPosition(ship.position)
	--camera:SetRotation(0, MixAngle(camera.rotation.y, ship.rotation.y, 0.05), 0)
	camera:SetPosition(0,0,0)
	camera:SetRotation(0,0,0)
	camera:Turn(90,0,0)
	camera:Move(0,0,-15)
	
	--Get the vector between the ship and box positions
	local deltaposition = enemy.position - ship.position
	
	angleindicator1:SetPosition((ship.position + enemy.position) * 0.5)
	angleindicator1:SetScale(0.1, 0.1, deltaposition:Length())
	angleindicator1:AlignToVector(deltaposition)

	deltaposition = deltaposition:Normalize()
	
	--Get the ship forward direction
	local dir = TransformNormal(0, 0, 1, ship, nil)
	
	angleindicator2:SetPosition(ship.position + dir * 5)
	angleindicator2:SetScale(0.1, 0.1, 10)
	angleindicator2:AlignToVector(dir)
	
	--Get the dot product of these two vectors
	local d = dir:Dot(deltaposition)
	
	--Convert the dot product into an angle
	local a = ACos(d)
	
	--Compare the angle to the max viewing angle of 45 degrees
	if a < 45 then
		enemy:SetColor(0,1,0)
	else
		enemy:SetColor(1,0,0)		
	end
	
	label1:SetText("Dot product: "..tostring(d))
	label2:SetText("Angle: "..tostring(Round(a)))
	
    --Update the world
    world:Update()
	
    --Render the world
    world:Render(framebuffer)
end
```

Note that a dot product can be converted into an angle value using the [ACos](ACos.md) function:

```lua
angle = ACos(A:Dot(B))
```

## Reflection

The Vec3 class has another method called [Reflect](Vec3_Reflect.md). This gives a reflection angle, given a trajectory and the normal of a face it is bouncing off of.

This example shows how to make a laser that bounces off a wall.

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
camera:SetRotation(15,0,0)
camera:Move(0,0,-5)

--Create the ground
ground = CreateBox(world, 10, 1, 10)
ground:SetPosition(0, -0.5, 0)
ground:SetColor(0.5)

--Laser will start here and point at the origin (0,0,0)
laserposition = Vec3(3,3,0)

--Create a "laser beam"
beam1 = CreateBox(world) 
beam1:SetColor(1,0,0)

beam2 = CreateBox(world) 
beam2:SetColor(0,1,0)

--Main loop
while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do

	--Display the last beam
	local dir = Vec3(0) - laserposition;
	beam1:SetPosition((Vec3(0) + laserposition) * 0.5)
	beam1:AlignToVector(dir, 2)
	beam1:SetScale(0.1, 0.1, dir:Length())

	--Calculate the reflection vector
	local endpoint = dir:Reflect(Vec3(0,1,0))
	
	--Display the bounced laser
	dir = Vec3(0) - endpoint;
	beam2:SetPosition((Vec3(0) + endpoint) * 0.5)
	beam2:AlignToVector(dir, 2)
	beam2:SetScale(0.1, 0.1, dir:Length())
	
	--Move the laser position around with the arrow keys
	if window:KeyDown(KEY_RIGHT) then laserposition.x = laserposition.x + 0.1 end
	if window:KeyDown(KEY_LEFT) then laserposition.x = laserposition.x - 0.1 end
	if window:KeyDown(KEY_UP) then laserposition.z = laserposition.z + 0.1 end
	if window:KeyDown(KEY_DOWN) then laserposition.z = laserposition.z - 0.1 end
	
    --Update the world
    world:Update()

    --Render the world
    world:Render(framebuffer)
end
```
