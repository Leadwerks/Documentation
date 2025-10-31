# 4x4 Matrices

What is the matrix? In Leadwerks, a 4x4 matrix is a mathematical structure used to represent an object’s position, rotation, and scale in 3D space. Think of it as a compact way to encode all the spatial information about an entity. The matrix contains 16 values arranged in four rows and four columns, which together define how the object is oriented in the world.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/4x4matrix1.png?raw=true)

The [Mat4](Mat4.md) class has four [Vec4](Vec4.md) that can be accessed either with i, j, k, and t, or by index:

```lua
m = Mat4(1)

Print(m[0])
Print(m[1])
Print(m[2])
Print(m[3])
```
The code above will print out the following:

```
1, 0, 0, 0
0, 1, 0, 0
0, 0, 1, 0
0, 0, 0, 1
```

What do these funny numbers mean?

### Matrix Orientation

- The first three values in the first row represents the direction of the object's X axis in global space. For example, on a 3D model of an airplane this row would be a vector indicating the direction the right wing is pointing.

- The first three values in the second row represents the direction of the object's Y axis in global space. For example, on a 3D model of an airplane this row would be a vector indicating the up direction relative to the aircraft.

- The first three values in the third row represents the direction of the object's Z axis in global space. For example, on a 3D model of an airplane this row would be a vector indicating the forward direction relative to the aircraft.

### Matrix Translation

The first three values in the last row contains the position of the entity in world space. These are the X, Y, and Z coordinates where the object is located.

### Matrix Scale

- The length of the first row vector is the object's scale on the X axis, in world space.

- The length of the second row vector is the object's scale on the Y axis, in world space.

- The length of the third row vector is the object's scale on the Z axis, in world space.

The last value in each row is unused, so the right column is always set to (0, 0, 0, 1). This just makes the math work out nicely when we do fancy things with matrices.

Let's take another look at the matrix, with the X, Y, and Z axes highlighted in red, green, and blue, and the translation highlighted in yellow:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/4x4matrix.png?raw=true)

Let's take another look at our matrix values, now that we know what they represent:

```
1, 0, 0, 0
0, 1, 0, 0
0, 0, 1, 0
0, 0, 0, 1
```

This particular type of matrix is called an _identity matrix_ and instantly tells us a few things:
- The object is at position (0,0,0).
- The object is not rotated.
- The object has a scale of 1.0 on all three axes.

4x4 matrices in Leadwerks are always orthogonal, which means the three axes always form a left-handed coordinate system and are oriented 90 degrees apart from one another.

## Using Entity Matrices

Since we know the third row of the matrix encodes the entity's forward direction, this provides an easy way to retrieve it without calling any other functions:

```lua
forward = entity.matrix[2].xyz
```

If the entity could be scaled, you make want to normalize the returned vector:

```lua
forward = forward:Normalize()
```

You can do the same for the entity's right or up directions:

```lua
right = entity.matrix[0].xyz:Normalize()
up = entity.matrix[1].xyz:Normalize()
forward = entity.matrix[2].xyz:Normalize()
```

And of course the entity's position in world space is easily accessily like so:

```lua
position = entity.matrix[3].xyz
```

Since the entity matrix encodes the position, rotation, and scale, this gives us an easy way to exactly copy one entity's orientation to another in one simple command:

```lua
b:SetMatrix(a.matrix)
```

This example shows all of these techniques in action:

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
camera:Turn(35,0,0)
camera:Move(0,0,-4)

--Load a model
local ship = LoadModel(world, "https://github.com/Leadwerks/Documentation/raw/refs/heads/master/Assets/Models/Spaceship/spaceship.mdl")
ship:SetPosition(2,0,0)

--Make an instanced copy of the model
local ship2 = ship:Instantiate(world)
ship2:SetColor(2,0,0,1, true)
ship2:SetPosition(-2,0,0)

--Text tiles for displaying info
local font = LoadFont("Fonts/arial.ttf")

local tile1 = CreateTile(world, font, "")
tile1:SetPosition(4,4)

local tile2 = CreateTile(world, font, "")
tile2:SetPosition(4,24)

local tile3 = CreateTile(world, font, "")
tile3:SetPosition(4,44)

local tile4 = CreateTile(world, font, "")
tile4:SetPosition(4,64)

--Main loop
while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do

    --Key controls move and rotate ship
    if window:KeyDown(KEY_RIGHT) then ship:Move(0.1,0,0) end
    if window:KeyDown(KEY_LEFT) then ship:Move(-0.1,0,0) end
    if window:KeyDown(KEY_UP) then ship:Turn(-1,0,0) end
    if window:KeyDown(KEY_DOWN) then ship:Turn(1,0,0) end

	--Space key copies one entity's orientation to the other
	if window:KeyHit(KEY_SPACE) then ship2:SetMatrix(ship.matrix) end

	--Update the display text
	m = ship.matrix
	tile1:SetText("Left: " .. tostring(m[0][0]) .. ", " .. tostring(m[0][1]) .. ", " .. tostring(m[0][2]) )
	tile2:SetText("Up: " .. tostring(m[1][0]) .. ", " .. tostring(m[1][1]) .. ", " .. tostring(m[1][2]) )
	tile3:SetText("Forward: " .. tostring(m[2][0]) .. ", " .. tostring(m[2][1]) .. ", " .. tostring(m[2][2]) )
	tile4:SetText("Translation: " .. tostring(m[3][0]) .. ", " .. tostring(m[3][1]) .. ", " .. tostring(m[3][2]) )
	
    --Update the world
    world:Update()

    --Render the world
    world:Render(framebuffer)
end
```

## Matrix Transformations

The [transformation commands](3dtransform.md) we previously learned about will accept two 4x4 matrices as the source and destination parameters, in addition to using entities.
