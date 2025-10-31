# Hierarchies and Space Transformations

In Leadwerks, we can "parent" one entity to another. This establishes a hierarchical relationship between two entities. When the parent moves or rotates, all its child entities follow suit as if they are attached to it. Conversely, moving a child entity affects its position relative to the parent, but does not affect the parent entity.

Let's consider a simple example where we have a spaceship with a spinning propeller, that is mounted on a rotating arm:

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
camera:Move(0,0,-5)

--Create a beam
local arm = CreateBox(world,8,0.25,0.25)
arm:SetColor(0.25)

--Create a stand, just for visual clarity
local stand = CreateCylinder(world,0.25,1.25)
stand:SetColor(0.25)

--Load a model
local ship = LoadModel(world, "https://github.com/Leadwerks/Documentation/raw/refs/heads/master/Assets/Models/Spaceship/spaceship.mdl")
ship:SetPosition(4,0,0)
ship:SetParent(arm)

--Create a box
local propeller = CreateBox(world, 2, 0.25, 0.1)
propeller:SetPosition(0,0,1.25)
propeller:SetColor(1,0,0)
propeller:SetParent(ship, false)

--Main loop
while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do
	
	--Rotate the arm the ship is attached to around the Y axis
	arm:Turn(0,-1,0)
	
	--Rotate the propeller around its Z axis
	propeller:Turn(0,0,10)

    --Update the world
    world:Update()
	
    --Render the world
    world:Render(framebuffer)
end
```

In this setup:

- The ship is parented to the end of the arm, so when the arm rotates, the ship moves along with it.
- The propeller is parented to the ship, so it spins independently but moves with the ship as the ship moves and rotates.

Parenting allows us to create complex assemblies of objects that move in a natural way.

## Accessing Child Entities

Leadwerks provides a straightforward way to access all children of an entity via the _kids_ array:

```lua
for n = 1, #entity.kids do
	Print("Child "..tostring(n)..", name: "..entity.kids[n].name)
end
```

This is useful for iterating over parts of a composite object, especially when dynamically modifying objects in a hierarchy.

## Space Transformations

One of the most powerful aspects of entity hierarchies is the ability to transform points, normals, vectors, and other data between different coordinate spaces.

It's important to understand these concepts:

- _World_ or _Global_ Space: Coordinates relative to the world origin.
- _Local_ Space: Coordinates relative to an entity's own origin.
- _Parent_ Space: Coordinates relative to the parent entity, if any.

Suppose you have a point in world space and want to find its position relative to an entity, or vice versa. Leadwerks provides transformation functions to perform these conversions.

### Transforming a Point

The [TransformPoint](TransformPoint.md) function converts a point in 3D space from one entity's coordinate system to another.

In the example below, the box's position is transformed to the ship's local space. The box's position relative to the ship will be displayed onscreen.

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
camera:Move(0,0,-5)

--Load a model
local ship = LoadModel(world, "https://github.com/Leadwerks/Documentation/raw/refs/heads/master/Assets/Models/Spaceship/spaceship.mdl")

--Create a box
local box = CreateBox(world)
box:SetPosition(4,0,0)
box:SetColor(0,0,1)

--Display some text
local font = LoadFont("Fonts/arial.ttf")
local tile = CreateTile(world, font, "")

--Main loop
while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do
	
	if window:KeyDown(KEY_RIGHT) then ship:Turn(0,1,0) end
	if window:KeyDown(KEY_LEFT) then ship:Turn(0,-1,0) end

	--Transform the box's position to the ship's space
	p = TransformPoint(box.position, nil, ship)

	--Display the transformed position
	tile:SetText("Position: "..tostring(p.x)..", "..tostring(p.y)..", "..tostring(p.z))

    --Update the world
    world:Update()
	
    --Render the world
    world:Render(framebuffer)
end
```
### Transforming a Vector

The [TransformVector](TransformVector.md) function converts a 3D vector from one coordinate space to another.

This example transforms the forward vector (0, 0, 1) from world space to the ship's local space. Notice that because the ship is scaled to 2.0, the transsformed vector will have a length of just 0.5.

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
camera:Move(0,0,-5)

--Load a model
local ship = LoadModel(world, "https://github.com/Leadwerks/Documentation/raw/refs/heads/master/Assets/Models/Spaceship/spaceship.mdl")
ship:SetScale(2)

--Display some text
local font = LoadFont("Fonts/arial.ttf")
local tile = CreateTile(world, font, "")

--Main loop
while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do
	
	if window:KeyDown(KEY_RIGHT) then ship:Turn(0,1,0) end
	if window:KeyDown(KEY_LEFT) then ship:Turn(0,-1,0) end

	--Transform the forward vector from world space to the ship's space
	p = TransformVector(0, 0, 1, nil, ship)

	--Display the transformed vector
	tile:SetText("Vector: "..tostring(p.x)..", "..tostring(p.y)..", "..tostring(p.z))

    --Update the world
    world:Update()
	
    --Render the world
    world:Render(framebuffer)
end
```
### Transforming a Normal

The [TransformNormal](TransformNormal.md) function operates just like a vector, except that it normalizes the result, so the returned vector's length is always one.

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
camera:Move(0,0,-5)

--Load a model
local ship = LoadModel(world, "https://github.com/Leadwerks/Documentation/raw/refs/heads/master/Assets/Models/Spaceship/spaceship.mdl")
ship:SetScale(2)

--Display some text
local font = LoadFont("Fonts/arial.ttf")
local tile = CreateTile(world, font, "")

--Main loop
while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do
	
	if window:KeyDown(KEY_RIGHT) then ship:Turn(0,1,0) end
	if window:KeyDown(KEY_LEFT) then ship:Turn(0,-1,0) end

	--Transform the forward normal from world space to the ship's space
	p = TransformNormal(0, 0, 1, nil, ship)

	--Display the transformed normal
	tile:SetText("Vector: "..tostring(p.x)..", "..tostring(p.y)..", "..tostring(p.z))

    --Update the world
    world:Update()
	
    --Render the world
    world:Render(framebuffer)
end
```

### Other Transformations

Transforming points, vectors, and normals are the most common operations used in games. Additionally, we have a few extra commands that may be useful from time to time.

The [TransformRotation](TransformRotation.md) function transforms a rotation between coordinate systems. It's best to use quaternions with this, but Euler angles are also accepted.

The [TransformAabb](TransformAabb.md) function transforms an axis-aligned bounding box from one coordinate system to another.

The [TransformPlane](TransformPlane.md) function transforms a plane from one coordinate system to another.
