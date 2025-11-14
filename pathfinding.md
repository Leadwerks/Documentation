# Pathfinding

The Leadwerks pathfinding analyzes the level geometry and tells characters in your game where they are allowed to walk, and how to get from one point to another. The Leadwerks pathfinding system is fully dynamic, meaning that if an object moves in your game, the pathfinding data will adjust and characters may choose another route to reach their destination.

Pathfinding is accomplished with a navigation mesh. The [NavMesh](NavMesh.md) class defines an area the navigation mesh, and handles building and updating of the mesh data.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/navmesh.jpg?raw=true)

Each navigation mesh can have one or more [NavAgent](NavAgent.md) objects. A navigation agent represents a character that can move about the scene. Navigation agents will follow the contours of the navigation mesh, and will also move to avoid one another in a crowd.

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

    navmesh:SetDebugging(window:KeyDown(KEY_D))

    if window:MouseHit(MOUSE_LEFT) then
        local mousepos = window:GetMousePosition()
        local rayinfo = camera:Pick(framebuffer, mousepos.x, mousepos.y)
        if rayinfo.success then
            agent:Navigate(rayinfo.position)
        end
    end
    if window:KeyHit(KEY_SPACE) then
        agent:Stop()
    end

    world:Update()
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



## Top-Down Shooter Example

Let's take everything we have learned about game mechanics and put it all together in one example. This example will use raytracing, collision, entity filters, proximity testing, entity spawning, and pathfinding to provide a simple playable game:

```lua
```

