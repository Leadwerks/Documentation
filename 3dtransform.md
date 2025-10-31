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

## Transforming a Point






One of the most powerful techniques in 3D games is the ability to transform points, vectors, and other data from one entity's space to another.

You can think of space transformations as data relative to another entity. For example, if an entity is positioned at (10,0,0), and its not rotated, what would the position (11,0,0) be relative to that entity? The answer is (1,0,0).

If the entity was positioned at (10,0,0) and its rotation was (0,180,0), the position (11,0,0) relative to the entity would be (-1,0,0), since the entity is spun around 180 degrees.


## Transforming a Normal


## Transforming a Vector


## Transforming a Rotation


## Transforming a Plane


## Transforming an Axis-aligned Bounding Box


## Parenting Entities

