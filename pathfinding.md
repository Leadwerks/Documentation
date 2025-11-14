# Pathfinding

The Leadwerks pathfinding analyzes the level geometry and tells characters in your game where they are allowed to walk, and how to get from one point to another. The Leadwerks pathfinding system is fully dynamic, meaning that if an object moves in your game, the pathfinding data will adjust and characters may choose another route to reach their destination.

Pathfinding is accomplished with a navigation mesh. The [NavMesh](NavMesh.md) class defines an area the navigation mesh, and handles building and updating of the mesh data. In order to visualize the navigation mesh data, you can use the [NavMesh:SetDebugging](NavMesh_SetDebugging.md) command.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/navmesh.jpg?raw=true)

Each navigation mesh can have one or more [NavAgent](NavAgent.md) objects. A navigation agent represents a character that can move about the scene. Navigation agents will follow the contours of the navigation mesh, and will also move to avoid one another in a crowd.

Here is a simple example that demonstrates how to create a navigation mesh, add a single agent, and make the agent navigate to a destination the user clicks the mouse on.

```lua
local displays = GetDisplays();

--Create a window
local window = CreateWindow("Leadwerks", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

--Create a framebuffer
local framebuffer = CreateFramebuffer(window)

--Create a world
local world = CreateWorld()

--Create a camera
local camera = CreateCamera(world)
camera:SetFov(70)
camera:SetClearColor(0.125)
camera:SetPosition(Vec3(0, 3, -6))
camera:SetRotation(Vec3(35, 0, 0))

--Create light
local light = CreateBoxLight(world)
light:SetRange(-20, 20)
light:SetArea(20, 20)
light:SetRotation(35, 35, 0)
light:SetColor(3, 3, 3)

--Create scene
local ground = CreateBox(world, 10, 1, 10)
ground:SetPosition(Vec3(0, -0.5, 0))
ground:SetColor(0, 1, 0)
local wall = CreateBox(world, 1, 2, 4)

--Create navmesh
local navmesh = CreateNavMesh(world, 5, 4, 4)
navmesh:Build()

--Create player
local player = CreateCylinder(world, 0.4, 1.8)
player:SetNavObstacle(false)
player:SetColor(0, 0, 1)
local agent = CreateNavAgent(navmesh)
player:Attach(agent)
agent:SetPosition(-2,1,0)

--Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do

    --Visualize the navmesh if the space key is pressed
    navmesh:SetDebugging(window:KeyDown(KEY_SPACE))

    --Click to control where the agent moves to
    if window:MouseHit(MOUSE_LEFT) then
        local mousepos = window:GetMousePosition()
        local pickinfo = camera:Pick(framebuffer, mousepos.x, mousepos.y)
        if pickinfo.entity then
            agent:Navigate(pickinfo.position)
        end
    end

    --Update the world
    world:Update()

    --Render the world
    world:Render(framebuffer)

end
```

Note that the navigation system is independent from the physics system. You can have characters that are completely controlled by the navigation system alone, or you can combine the navigation mesh with the physics collision, by repositioning the navigation agent if there is a discreprency with the physics object's position.

## Getting the Navmesh from a Scene

The scene object includes a member that lists all navmeshes found in the scene. In most cases, there will only be a single navmesh per scene. The _Monster.lua_ entity script makes use of this feature in its **Load** function.

```lua
self.navmesh = scene.navmeshes[self.navmeshindex]-- navmeshindex is 1 by default
```

It then makes use of the navmesh in its **Start** function to create a navigation agent and attach itself to the agent.

```lua
if self.navmesh then
    self.agent = CreateNavAgent(self.navmesh, 0.5, 1.8)
    self.agent:SetPosition(self:GetPosition(true))
    self.agent:SetRotation(self:GetRotation(true).y)
    self:SetPosition(0, 0, 0)
    self:SetRotation(0, 180, 0)
    self:Attach(self.agent)
end
```

## Dynamic Navmesh Rebuilding

We can demonstrate this by adding some code in the main loop of our previous example, that allows us to move the wall in the scene with the up and down arrow keys. Hold the space key as you do this to see how the navigation mesh rebuilds.

```lua
--Move the block with the arrow keys
if window:KeyDown(KEY_UP) then wall:Move(0,0,0.1) end
if window:KeyDown(KEY_DOWN) then wall:Move(0,0,-0.1) end
```

## Crowds

The pathfinding system is capable of handling large numbers of characters with realistic crowding behavior. This is perfect for making hordes of zombies, or other enemies. Here is our example modified to handle multiple characters:

```lua
local displays = GetDisplays();

--Create a window
local window = CreateWindow("Leadwerks", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

--Create a framebuffer
local framebuffer = CreateFramebuffer(window)

--Create a world
local world = CreateWorld()

--Create a camera
local camera = CreateCamera(world)
camera:SetFov(70)
camera:SetClearColor(0.125)
camera:SetPosition(Vec3(0, 3, -6))
camera:SetRotation(Vec3(35, 0, 0))

--Create light
local light = CreateBoxLight(world)
light:SetRange(-20, 20)
light:SetArea(20, 20)
light:SetRotation(35, 35, 0)
light:SetColor(3, 3, 3)

--Create scene
local ground = CreateBox(world, 10, 1, 10)
ground:SetPosition(Vec3(0, -0.5, 0))
ground:SetColor(0, 1, 0)
local wall = CreateBox(world, 1, 2, 4)

--Create navmesh
local navmesh = CreateNavMesh(world, 5, 4, 4)
navmesh:Build()

local agents = {}
local entities = {}

for n = 1, 10 do
	
	--Create player
	local player = CreateCylinder(world, 0.4, 1.8)
	player:SetNavObstacle(false)
	player:SetColor(0, 0, 1)
	local agent = CreateNavAgent(navmesh)
	player:Attach(agent)
	agent:SetPosition(navmesh:RandomPoint())
	table.insert(agents, agent)
	table.insert(entities, player)
	
end

--Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do

    --Visualize the navmesh if the space key is pressed
    navmesh:SetDebugging(window:KeyDown(KEY_SPACE))

    --Click to control where the agent moves to
    if window:MouseHit(MOUSE_LEFT) then
        local mousepos = window:GetMousePosition()
        local pickinfo = camera:Pick(framebuffer, mousepos.x, mousepos.y)
        if pickinfo.entity then
			for n = 1, #agents do
				agents[n]:Navigate(pickinfo.position)
			end
        end
    end

	--Move the block with the arrow keys
	if window:KeyDown(KEY_UP) then wall:Move(0,0,0.1) end
	if window:KeyDown(KEY_DOWN) then wall:Move(0,0,-0.1) end

    --Update the world
    world:Update()

    --Render the world
    world:Render(framebuffer)

end
```

## Using Multiple Navigation Meshes

Each navigation mesh is built using the parameters you specify in the [CreateNavMesh](CreateNavMesh.md) function. If you have characters with vastly different sizes, you can create multiple navigation meshes to handle each size. To make the agents from different navigation meshes interact, create a proxy agent that you manually reposition. You will probably want to make a proxy for larger objects on a smaller navigation mesh, so that the smaller characters avoid the larger one.

```lua
local displays = GetDisplays();

--Create a window
local window = CreateWindow("Leadwerks", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

--Create a framebuffer
local framebuffer = CreateFramebuffer(window)

--Create a world
local world = CreateWorld()

--Create a camera
local camera = CreateCamera(world)
camera:SetFov(70)
camera:SetClearColor(0.125)
camera:SetRotation(Vec3(35, 0, 0))
camera:Move(0,0,-10)

--Create light
local light = CreateBoxLight(world)
light:SetRange(-20, 20)
light:SetArea(30, 30)
light:SetRotation(35, 35, 0)

--Create scene
local ground = CreateBox(world, 20, 1, 20)
ground:SetPosition(Vec3(0, -0.5, 0))
ground:SetColor(0.5)
local wall1 = CreateBox(world, 1, 2, 3)
wall1:SetPosition(0,0,2)

local wall2 = CreateBox(world, 1, 2, 3)
wall2:SetPosition(0,0,-3)

--Create navmesh for small objects
local navmesh1 = CreateNavMesh(world, 5, 4, 4)
navmesh1:Build()

local agents = {}
local entities = {}

for n = 1, 10 do
	
	--Create player
	local player = CreateCylinder(world, 0.4, 1.8)
	player:SetNavObstacle(false)
	player:SetColor(0, 0, 1)
	local agent = CreateNavAgent(navmesh1)
	player:Attach(agent)
	agent:SetPosition(navmesh1:RandomPoint())
	table.insert(agents, agent)
	table.insert(entities, player)
	
end

--Create navmesh for big objects, specifying 1.0 for the agent radius
local navmesh2 = CreateNavMesh(world, 5, 4, 4, 32, 0.25, 1)
navmesh2:Build()

--Create big guy
local player = CreateCylinder(world, 1, 4)
player:SetNavObstacle(false)
player:SetColor(0, 1, 0)
local bigagent = CreateNavAgent(navmesh2)
player:Attach(bigagent)
bigagent:SetPosition(navmesh2:RandomPoint())
table.insert(agents, bigagent)
table.insert(entities, player)

--Create a navagent for the big guy, on the first navmesh
bigagentproxy = CreateNavAgent(navmesh1, 1, 2)

--Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do

    --Visualize the navmesh if the space key is pressed
    navmesh2:SetDebugging(window:KeyDown(KEY_SPACE))

	bigagentproxy:SetPosition(bigagent:GetPosition())

    --Click to control where the agent moves to
    if window:MouseHit(MOUSE_LEFT) then
        local mousepos = window:GetMousePosition()
        local pickinfo = camera:Pick(framebuffer, mousepos.x, mousepos.y)
        if pickinfo.entity then
			for n = 1, #agents do
				agents[n]:Navigate(pickinfo.position)
			end
        end
    end

	--Move the block with the arrow keys
	if window:KeyDown(KEY_UP) then wall:Move(0,0,0.1) end
	if window:KeyDown(KEY_DOWN) then wall:Move(0,0,-0.1) end

    --Update the world
    world:Update()

    --Render the world
    world:Render(framebuffer)

end
```

## Top-Down Shooter Example

Let's take everything we have learned about game mechanics and put it all together in one example. This example will use raytracing, collision, entity filters, proximity testing, entity spawning, and pathfinding to provide a simple playable game:

```lua
```

