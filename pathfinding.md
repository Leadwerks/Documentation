# Pathfinding

The Leadwerks pathfinding system analyzes your level's geometry and tells characters in your game where they are allowed to walk, and how to get from one point to another. The Leadwerks pathfinding system is fully dynamic, meaning that if an object moves in your game, the pathfinding data will adjust and characters may choose another route to reach their destination.

Pathfinding is accomplished with a navigation mesh. The [NavMesh](NavMesh.md) class defines an area the navigation mesh, and handles building and updating of the mesh data. In order to visualize the navigation mesh data, you can use the [NavMesh:SetDebugging](NavMesh_SetDebugging.md) command.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/navmesh.jpg?raw=true)

Each navigation mesh can have one or more [NavAgent](NavAgent.md) objects. A navigation agent represents a character that can move about the scene. Navigation agents will follow the contours of the navigation mesh, and will also move to avoid one another in a crowd.

Here is a simple example that demonstrates how to create a navigation mesh, add a single agent, and make the agent navigate to a destination the user clicks the mouse on.

```lua
local displays = GetDisplays();

--Create a window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

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
light:SetRange(-10, 10)
light:SetArea(15, 15)
light:SetRotation(35, 35, 0)

--Create scene
local ground = CreateBox(world, 10, 1, 10)
ground:SetPosition(Vec3(0, -0.5, 0))
ground:SetColor(0.5)
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

When you click the left mouse button, the character will move to the position you select.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/navigation.gif?raw=true)

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

![](https://github.com/UltraEngine/Documentation/blob/master/Images/dynamicnavigation.gif?raw=true)

## Crowds

The pathfinding system is capable of handling large numbers of characters with realistic crowding behavior. This is perfect for making hordes of zombies, or other enemies. Here is our example modified to handle multiple characters:

```lua
local displays = GetDisplays();

--Create a window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

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

## Using Multiple Navmeshes

Each navigation mesh is built using the parameters you specify in the [CreateNavMesh](CreateNavMesh.md) function. If you have characters with vastly different sizes, you can create multiple navigation meshes to handle each size. To make the agents from different navigation meshes interact, create a proxy agent that you manually reposition. You will probably want to make a proxy for larger objects on a smaller navigation mesh, so that the smaller characters avoid the larger one.

```lua
local displays = GetDisplays();

--Create a window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

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

Let's take everything we have learned about game mechanics and put it all together in one example. This example will use raycasting, collision, entity filters, proximity testing, entity spawning, and pathfinding to provide a simple playable game:

```lua
local displays = GetDisplays();

--Create a window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

--Create a framebuffer
 framebuffer = CreateFramebuffer(window)

--Create a world
local world = CreateWorld()

--Create light
local light = CreateBoxLight(world)
light:SetRange(-20, 20)
light:SetArea(80, 80)
light:SetRotation(65, 45, 0)
light:SetShadowmapSize(1024)

--Create scene
local ground = CreateBox(world, 60, 1, 60)
ground:SetPosition(Vec3(0, -0.5, 0))
ground:SetColor(0.5)
local wall1 = CreateBox(world, 8, 2, 2)
wall1:SetColor(0.25)
wall1:SetPosition(0,1,-5)
local wall2 = CreateBox(world, 8, 2, 2)
wall2:SetColor(0.25)
wall2:SetPosition(-2,1,5)
local wall3 = CreateBox(world, 2, 2, 8)
wall3:SetColor(0.25)
wall3:SetPosition(8,1,0)
local wall4 = CreateBox(world, 12, 2, 2)
wall4:SetColor(0.25)
wall4:SetPosition(0,1,10)
local wall5 = CreateBox(world, 2, 2, 12)
wall5:SetColor(0.25)
wall5:SetPosition(-10,1,2)
local wall5 = CreateBox(world, 20, 2, 2)
wall5:SetColor(0.25)
wall5:SetPosition(10,1,15)
local wall6 = CreateBox(world, 2, 2, 12)
wall6:SetColor(0.25)
wall6:SetPosition(16,1,2)

--Define Teams
TEAM_GOOD = 1
TEAM_BAD = 2

-- Load a font for text rendering
local font = LoadFont("Fonts/arial.ttf")

--Create player
player = CreateCylinder(world, 0.4, 1.8)
player.lods[1].meshes[1]:Translate(0, 0.9, 0)
player:UpdateBounds()
player:SetNavObstacle(false)
player:SetPhysicsMode(PHYSICS_PLAYER)
player:SetColor(0,0,1)
player:SetCollisionType(COLLISION_PLAYER)
player:SetMass(10)
player.camera = CreateCamera(player.world)
player.camera:Listen()
player.bullets = {}
player.health = 100
player.team = TEAM_GOOD
player.score = 0
player.healthtile = CreateTile(world, font, "Health: 100", 48)
player.scoretile = CreateTile(world, font, "Score: 0", 48, TEXT_RIGHT)
player.scoretile:SetPosition(framebuffer.size.x, 0)
player.gametile = CreateTile(world, font, "Wave 1", 48, TEXT_CENTER)
player.gametile:SetPosition(framebuffer.size.x / 2, 0)

--Gun Sound 3 by TheNikonProductions -- https://freesound.org/s/337698/ -- License: Attribution 3.0
player.sound_shoot = LoadSound("https://github.com/Leadwerks/Documentation/raw/refs/heads/master/Assets/Sound/shoot.wav")

function player:TakeDamage(damage)
	
	--Add a refractory period during which the player cannot be hurt
	if self.lasthurttime == nil then self.lasthurttime = 0 end
	local now = self.world:GetTime()
	if now - self.lasthurttime < 1000 then return end
	self.lasthurttime = now
	
	self.health = self.health - damage
	self.healthtile:SetText("Health: "..tostring(self.health))
	if self.health <= 0 then
		self:SetColor(0,0,0)
		self:SetInput(0,0,0)
		self.gametile:SetText("You Died!")
	end
end

function player:Update()
	
	-- Get the current game time
	local now = self.world:GetTime()
	
	-- Update bullets
	local n
	for n = #self.bullets, 1, -1 do
		if now - self.bullets[n].spawntime > 2000 then
			self.bullets[n]:SetHidden(true)
			table.remove(self.bullets, n)
		else
			local bulletspeed = 1
			local p0 = self.bullets[n].position
			local p1 = TransformPoint(0, 0, bulletspeed, self.bullets[n], nil)		
			local pickinfo = self.world:Pick(p0, p1, 0.25, true)
			if pickinfo.entity then
				if isfunction(pickinfo.entity.TakeDamage) then
					pickinfo.entity:TakeDamage(10, self)
				end
				self.bullets[n]:SetHidden(true)
				table.remove(self.bullets, n)
				if isnumber(pickinfo.entity.health) then
					if pickinfo.entity.health <= 0 then
						self.score = self.score + 1
						self.scoretile:SetText("Score: "..tostring(self.score))
					end
				end
			else
				self.bullets[n]:Move(0,0,bulletspeed)
			end
		end
	end
	
	-- Update the camera
	self.camera:SetPosition(self.position)
	self.camera:SetRotation(45,0,0)
	self.camera:Move(0,0,-8)
		
	-- Get the active window
	local window = ActiveWindow()
	if window == nil then return end
	
	-- Player movement
	if self.health <= 0 then return end
	local speed = 4
	local move = Vec2(0)
	if window:KeyDown(KEY_D) then move.x = move.x + 1 end
	if window:KeyDown(KEY_A) then move.x = move.x - 1 end
	if window:KeyDown(KEY_W) then move.y = move.y + 1 end
	if window:KeyDown(KEY_S) then move.y = move.y - 1 end
	if move.x ~= 0 or move.y ~= 0 then move = move:Normalize() * speed end
	self:SetInput(0, move.y, move.x)
	
	-- Shooting
	if window:MouseDown(MOUSE_LEFT) then		
		if self.lastfiretime == nil or now - self.lastfiretime > 100 then
			if self.sound_shoot then self.sound_shoot:Play() end
			self.lastfiretime = now
			local p = Plane(0,1,0,0)
			local cx = window.framebuffer.size.x / 2
			local cy = window.framebuffer.size.y / 2
			local mousepos = window:GetMousePosition()
			local coord = Vec3(mousepos.x, mousepos.y, 0)
			coord.z = self.camera:GetRange().y
			farpoint = self.camera:ScreenToWorld(coord, framebuffer)
			local r = Vec3(0)
			if p:IntersectsLine(self.camera.position, farpoint, r) then
				local dir = r - self.position
				dir.y = 0
				dir = dir:Normalize()
				local bullet = CreateSphere(world, 0.25)
				bullet:SetPickMode(PICK_NONE)
				bullet.spawntime = now
				bullet:SetNavObstacle(false)
				bullet:SetPosition(self.position + Vec3(0,1,0))
				bullet:AlignToVector(dir)
				bullet:Move(0, 0, 0.5)
				bullet:SetCollisionType(COLLISION_TRIGGER)
				table.insert(self.bullets, bullet)
			end
		end
	end

end

-- Create navmesh
local navmesh = CreateNavMesh(world, 5, 8, 8)
navmesh:Build()

-- The scene object will act as a container to store zombies in
local scene = CreateScene()

function SpawnWave(count, scene)
	
	-- Create zombies
	for n = 1, count do
		local zombie = CreateCylinder(world, 0.4, 1.8)
		zombie.lods[1].meshes[1]:Translate(0, 0.9, 0)
		zombie:UpdateBounds()
		zombie:SetPickMode(PICK_MESH)-- use mesh picking, since we shifted the mesh vertically
		zombie:SetNavObstacle(false)-- don't affect the navmesh building
		zombie:SetColor(1, 0, 0)
		zombie.health = 30
		zombie.team = TEAM_BAD
		zombie.agent = CreateNavAgent(navmesh)
		zombie:Attach(zombie.agent)
		zombie:SetRotation(0,Random(360),0)
		zombie.agent:SetPosition(TransformPoint(0,0,30, zombie, nil))
		zombie.scene = scene
		--Zombie Roar by gneube -- https://freesound.org/s/315846/ -- License: Attribution 4.0
		zombie.sound_death = LoadSound("https://github.com/Leadwerks/Documentation/raw/refs/heads/master/Assets/Sound/zombie-roar.wav")
		scene:AddEntity(zombie)
		
		-- The player bullets will call this function when they hit a zombie
		function zombie:TakeDamage(damage)
			self.health = self.health - damage
			if self.health <= 0 then
				if self.sound_death then self:EmitSound(self.sound_death) end
				self.agent:Stop()
				self.agent = nil
				self.dietime = self.world:GetTime()
				self:SetColor(0,0,0)
				self:SetPickMode(PICK_NONE)
				self:SetCollisionType(COLLISION_NONE)
			end
		end
		
		-- Zombie update function will be called every frame
		function zombie:Update()
			
			--Handle dead zombies
			if self.health <= 0 then
				self:Move(0,-0.01,0)
				local now = self.world:GetTime()
				if now - self.dietime > 5000 then
					self:SetHidden(true)
					self.Update = nil
					self.scene:RemoveEntity(self)
				end
				return
			end
			
			if self.target and self.target.health <= 0 then
				self.target = nil
				self.agent:Stop()
			end
			
			-- Find a target to attack
			if self.target == nil then
				local entities = self.world:GetEntities("health", ">", 0, "team", "~=", self.team)
				if #entities > 0 then self.target = entities[1] end
			end
			
			-- If we have a target, go towards it
			if self.target ~= nil then
				self.agent:Navigate(self.target.position)
				if self.target:GetDistance(self) < 1 then
					if isfunction(self.target.TakeDamage) then
						self.target:TakeDamage(10, self)
					end
					-- Pushes the player away
					local dir = self.target.position - self.position
					dir = dir:Normalize() * 2
					self.target:SetVelocity(self.target:GetVelocity() + dir)
				end
			end
			
		end		
	end
end

local wave = 1
local zombiecount = 5
SpawnWave(zombiecount, scene)

--Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do

	--Spawn another wave when all zombies are dead
	if #scene.entities == 0 then
		wave = wave + 1
		player:SetPosition(0,0,0)
		player.gametile:SetText("Wave "..tostring(wave))
		zombiecount = zombiecount * 2
		SpawnWave(zombiecount, scene)
	end
	
	--Run GC sweep
	collectgarbage()
	
    --Update the world
    world:Update()

    --Render the world
    world:Render(framebuffer)

end
```

This example produces a simple but fun playable game in less than 300 lines of code.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/topdownshooter.gif?raw=true)
