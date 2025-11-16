# Entity Spawning and Management

This lesson will discuss the concept of "spawning" and ownership of entities. There's no special commands here to review, but rather it's a way of thinking about object relationships.

Many games dynamically create entities that exist temporarily in the game. Bullets, particle effects, and hordes of enemies are examples. These objects can either have a temporary lifespan based on time, or they can expire based on specific conditions, like a bullet hitting a wall.

Dynamically spawned entities must be managed:

- Entities must be stored in a table of some type, so that they don't go out of scope and get deleted automatically.
- Some entities must be continually updated each frame.
- There must be some method of deleting the entities after a limited amount of time has passed, or based on actions in the game.

## Projectiles

This example shows how projectiles can be spawned when the player holds the left mouse button, and how they can be managed until it is time to delete them.

```lua
-- Get the displays
local displays = GetDisplays()

-- Create window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create world
local world = CreateWorld()

-- Create a light
local light = CreateBoxLight(world)
light:SetRotation(45,45,0)
light:SetRange(-20,20)
light:SetArea(60,60)
light:SetShadowmapSize(1024)

-- Create the ground
local ground = CreateBox(world, 50, 1, 50)
ground:SetPosition(0,-0.5,0)
ground:SetColor(0.5)

-- Create a camera
camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetRotation(15,0,0)
camera:Move(0,2,-4)
camera:Listen()

-- Load turret model
local turret = LoadModel(world, "https://github.com/Leadwerks/Documentation/raw/refs/heads/master/Assets/Models/Turret/Turret01.mdl")
turret.lastfiretime = 0
turret:SetPickMode(PICK_NONE)
turret.bullets = {}-- table for storing bullets
turret.angle = 0
turret.smoothangle = 0
--Gun Sound 3 by TheNikonProductions -- https://freesound.org/s/337698/ -- License: Attribution 3.0
turret.sound_shoot = LoadSound("https://github.com/Leadwerks/Documentation/raw/refs/heads/master/Assets/Sound/shoot.wav")

--Player update function, gets called once per loop
function turret:Update()
	
    local now = self.world:GetTime()
	
    -- Update bullets
    for n = #self.bullets, 1, -1 do
		
        local dir = TransformNormal(0,0,1,self.bullets[n],nil)
		
        -- Perform a raycast to see if the bullet will hit anything
        local pick = world:Pick(self.bullets[n].position, self.bullets[n].position + dir, 0, true)
        if pick.entity then
            -- Object hit; Apply some force and hide the bullet
            pick.entity:AddPointForce(dir * 5, pick.position, true)
            self.bullets[n]:SetHidden(true)
        else
            -- Nothing hit, so move bullet forward
            self.bullets[n]:Move(0, 0, 0.25)
        end
		
        -- Hide the bullet if it times out
        if now - self.bullets[n].spawntime > 2000 then
            self.bullets[n]:SetHidden(true)
        end
		
        -- If the bullet was hidden for any reason, remove it from the list
        if self.bullets[n]:GetHidden() then
            self.bullets[n]:SetHidden(true)
            table.remove(self.bullets, n)
        end

    end
	
    local window = ActiveWindow()
    if window == nil then return end
	
	-- Get the articulated child for the gun
	local gun = self.kids[1]
	
	local p = Plane(0,1,0,0)
	local mousepos = window:GetMousePosition()
	local projpoint = camera:ScreenToWorld(Vec3(mousepos.x, mousepos.y, 1000), window.framebuffer)
	local intersection = Vec3(0)
	if p:IntersectsLine(camera.position, projpoint, intersection) then
		self.angle = 90 - Angle(intersection.x - self.position.x, intersection.z - self.position.z)
	end
	
	self.smoothangle = MixAngle(self.smoothangle, self.angle, 0.25)
	gun:SetRotation(90, self.smoothangle, 0)
	
    if window:MouseDown(MOUSE_LEFT) then       
        if now - self.lastfiretime > 100 then
            self.lastfiretime = now
			
			if self.sound_shoot then self.sound_shoot:Play() end
			
            local bullet = CreateSphere(world, 0.1)
            bullet:SetPosition(gun.position + Vec3(0,0.4,0))
            bullet:SetRotation(0, self.smoothangle, 0)
            bullet:SetPickMode(PICK_NONE)
            bullet:SetColor(0.25)
            bullet.spawntime = now

            table.insert(self.bullets, bullet)

        end
    end
	
end

-- Make a stack of boxes to shoot
local z = 8
local boxes = {}
for row = 0, 4 do
    local count = 5 - row           -- Decreasing number of boxes each row
    local y = 0.75 + row * 1.5          -- Increment y position for each row
    for n = 1, count do
        local box = CreateBox(world, 1.5)
        local x = (n - (count + 1) / 2) * 1.5  -- Center the boxes horizontally
        box:SetPosition(x, y, z)
        box:SetMass(1)
        box:SetColor(0, Random(1), Random(1))
        table.insert(boxes, box)
    end
end

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do

    -- Garbage collection step
    collectgarbage()

    -- Update the world
    world:Update()

    -- Render the world
    world:Render(framebuffer)

end
```

Notice that the bullets are all stored in a table that is attached to the turret entity. The turret has _ownership_ of the bullets, and is responsible for managing and cleaning them up.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/turret1.gif?raw=true)

## Dynamic Array Removal

If you want the ability to remove items from an array-style table in Lua while we are iterating through the table, you must iterate backwards like so:

```lua
for n = #enemies, 1, -1 do
	if enemies[n].health <= 0 then
		table.remove(enemies, n)
	end
end
```

This will prevent items from being skipped in the loop, or overrunning the length of the array.

Alternatively, you could also store objects as keys in a table, and assign any value to the key other than nil:

```lua
enemies[enemy] = true
```

When you iterate through the loop, use [pairs](Tables.md) instead of an array index:

```
local k, v
for k, v in pairs(enemies) do
	if k.health <= 0 then
		enemies[k] = nil-- removes the key from the table
	end
end
```

## Enemy Hordes

In this example we have added a horde of enemies that stays at the same size. When one enemy is killed, another will spawn to replace it.

There are many other ways you could time the enemies:
- Enemies come in waves, with a fixed number of enemies each wave.
- Enemies are spawned at a constant rate, regardless of how many already exist.
- An enemy wave attack is triggered by an invisible collision object the player activates.

This example simply spawns a new enemy far from the origin. You could spawn enemies in specific locations, or check some pre-defined spots to see which are not visible to the player.

```lua
-- Get the displays
local displays = GetDisplays()

-- Create window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create world
local world = CreateWorld()

-- Create a light
local light = CreateBoxLight(world)
light:SetRotation(45,45,0)
light:SetRange(-20,20)
light:SetArea(60,60)
light:SetShadowmapSize(1024)

-- Create the ground
local ground = CreateBox(world, 50, 1, 50)
ground:SetPosition(0,-0.5,0)
ground:SetColor(0.5)

-- Create a camera
camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetRotation(45,0,0)
camera:Move(0,0,-6)
camera:Listen()

-- Load turret model
local turret = LoadModel(world, "https://github.com/Leadwerks/Documentation/raw/refs/heads/master/Assets/Models/Turret/Turret01.mdl")
turret.lastfiretime = 0
turret:SetPickMode(PICK_NONE)
turret.bullets = {}-- table for storing bullets
turret.angle = 0
turret.smoothangle = 0
turret.health = 100
turret.score = 0
--Gun Sound 3 by TheNikonProductions -- https://freesound.org/s/337698/ -- License: Attribution 3.0
turret.sound_shoot = LoadSound("https://github.com/Leadwerks/Documentation/raw/refs/heads/master/Assets/Sound/shoot.wav")

--Player update function, gets called once per loop
function turret:Update()
	
    local now = self.world:GetTime()
	
    -- Update bullets
    for n = #self.bullets, 1, -1 do
		
        local dir = TransformNormal(0,0,1,self.bullets[n],nil)
		
        -- Perform a raycast to see if the bullet will hit anything
        local pick = world:Pick(self.bullets[n].position, self.bullets[n].position + dir, 0, true)
        if pick.entity then
            -- Object hit; Apply some force, subtract some health, and hide the bullet
            pick.entity:AddPointForce(dir * 5, pick.position, true)
			if isnumber(pick.entity.health) then pick.entity.health = pick.entity.health - 10 end
            self.bullets[n]:SetHidden(true)
        else
            -- Nothing hit, so move bullet forward
            self.bullets[n]:Move(0, 0, 0.25)
        end
		
        -- Hide the bullet if it times out
        if now - self.bullets[n].spawntime > 2000 then
            self.bullets[n]:SetHidden(true)
        end
		
        -- If the bullet was hidden for any reason, remove it from the list
        if self.bullets[n]:GetHidden() then
            self.bullets[n]:SetHidden(true)
            table.remove(self.bullets, n)
        end

    end
	
	if self.health <= 0 then return end
	
    local window = ActiveWindow()
    if window == nil then return end
	
	-- Get the articulated child for the gun
	local gun = self.kids[1]
	
	local p = Plane(0,1,0,0)
	local mousepos = window:GetMousePosition()
	local projpoint = camera:ScreenToWorld(Vec3(mousepos.x, mousepos.y, 1000), window.framebuffer)
	local intersection = Vec3(0)
	if p:IntersectsLine(camera.position, projpoint, intersection) then
		self.angle = 90 - Angle(intersection.x - self.position.x, intersection.z - self.position.z)
	end
	
	self.smoothangle = MixAngle(self.smoothangle, self.angle, 0.25)
	gun:SetRotation(90, self.smoothangle, 0)
	
    if window:MouseDown(MOUSE_LEFT) then       
        if now - self.lastfiretime > 100 then
            self.lastfiretime = now
			
			if self.sound_shoot then self.sound_shoot:Play() end
			
            local bullet = CreateSphere(world, 0.1)
            bullet:SetPosition(gun.position + Vec3(0,0.4,0))
            bullet:SetRotation(0, self.smoothangle, 0)
            bullet:SetPickMode(PICK_NONE)
            bullet:SetColor(0.25)
            bullet.spawntime = now

            table.insert(self.bullets, bullet)

        end
    end
	
end

-- Text to display play health
local font = LoadFont("Fonts/arial.ttf")
local healthtile = CreateTile(world, font, "Health: 100", 24)
local scoretile = CreateTile(world, font, "Score: 0", 24, TEXT_RIGHT)
scoretile:SetPosition(framebuffer.size.x, 0)

-- Table to store enemies in
local enemies = {}
local enemyspeed = 0.025

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do

	-- Remove entities from the table if their health reaches zero	
	for n = #enemies, 1, -1 do
		if enemies[n].health <= 0 then
			enemies[n].Update = nil
			if enemies[n].sound_death then enemies[n].sound_death:Play() end
			enemies[n]:SetHidden(true)
			table.remove(enemies, n)
			turret.score = turret.score + 1
			scoretile:SetText("Score: "..tostring(turret.score))
		end
	end
	
	-- Spawn another enemy if there aren't enough
	if #enemies < 10 then
		local enemy = CreateCylinder(world, 0.5, 2)
		enemy:SetPosition(0,1,0)
		enemy:SetRotation(0,Random(360),0)
		enemy:Move(0,0,20)
		enemy:SetColor(1,0,0)
		enemy.health = 10
		enemy.speed = enemyspeed
		enemyspeed = enemyspeed * 1.02-- continuously increase the difficulty!
		
		--Zombie Roar by gneube -- https://freesound.org/s/315846/ -- License: Attribution 4.0
        enemy.sound_death = LoadSound("https://github.com/Leadwerks/Documentation/raw/refs/heads/master/Assets/Sound/zombie-roar.wav")
		
		function enemy:Update()

			if turret.health <= 0 then return end
			
			local dir = turret.position - self.position
			dir.y = 0
			
			if dir:Length() < 0.5 then
				turret.health = turret.health - 10
				if turret.health > 0 then
					healthtile:SetText("Health: " .. tostring(turret.health))
				else
					healthtile:SetText("Game Over!")
				end
				self.health = 0
			end
			
			dir = dir:Normalize() * self.speed
			self:Translate(dir)
		end
		
		table.insert(enemies, enemy)
	end

    -- Garbage collection step
    collectgarbage()

    -- Update the world
    world:Update()

    -- Render the world
    world:Render(framebuffer)

end
```

When you run the code, you can use the mouse to aim the turret and kill the attackers. What is your highest score?

![](https://github.com/UltraEngine/Documentation/blob/master/Images/turret2.gif?raw=true)
