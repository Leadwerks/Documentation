# Proximity Testing

Proximity testing is an important technique that allows us to detect nearby objects, and their relative position to an entity of interest. This is usually accomplished by a rough test performed with the [World:GetEntitiesInArea](World_GetEntitiesInArea.md) command. Entities returned by this command can be further discarded based on a variety of finer tests.

## Box Test

```lua
-- Get the displays
local displays = GetDisplays()

-- Create window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create world
local world = CreateWorld()
world:SetAmbientLight(1)

-- Create the ground
local ground = CreateBox(world, 50, 1, 50)
ground:SetPosition(0,-0.5,0)
ground:SetColor(0.5)

-- Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetRotation(35,0,0)
camera:Move(0,0,-10)

local boxes = {}

for x = -5, 5 do
	for y = -5, 5 do
		local box = CreateBox(world)
		box:SetPosition(x * 2, 0.5, y * 2)
		box:SetPickMode(PICK_NONE)
		box:SetMass(1)
		box:SetColor(1,0,0)
		table.insert(boxes, box)
	end
end

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do
	
	if window:MouseDown(MOUSE_LEFT) then
		
		-- Perform a camera raycast
		local mousepos = window:GetMousePosition()
		local pick = camera:Pick(framebuffer, mousepos.x, mousepos.y, 0, true)
		
		if pick.entity then
			
			-- If anything was picked, get all entities in a box around the picked position
			local range = 3
			local entities = world:GetEntitiesInArea(pick.position - range, pick.position + range)
			
			-- Restore all entity colors
			for n = 1, #boxes do
				boxes[n]:SetColor(1,0,0)
			end
			
			-- Iterate through the returned entities
			for n = 1, #entities do
				if entities[n] ~= ground then
					entities[n]:SetColor(0,1,0)
				end
			end
		end
		
	end
	
    -- Update the world
    world:Update()
	
    -- Render the world
    world:Render(framebuffer)
	
end
```

## Sphere Test

```lua
-- Get the displays
local displays = GetDisplays()

-- Create window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create world
local world = CreateWorld()
world:SetAmbientLight(1)

-- Create the ground
local ground = CreateBox(world, 50, 1, 50)
ground:SetPosition(0,-0.5,0)
ground:SetColor(0.5)

-- Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetRotation(35,0,0)
camera:Move(0,0,-10)

local boxes = {}

for x = -5, 5 do
	for y = -5, 5 do
		local box = CreateBox(world)
		box:SetPosition(x * 2, 0.5, y * 2)
		box:SetPickMode(PICK_NONE)
		box:SetMass(1)
		box:SetColor(Random(), Random(), Random())
		table.insert(boxes, box)
	end
end

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do
	
	if window:MouseHit(MOUSE_LEFT) then
		
		-- Perform a camera raycast
		local mousepos = window:GetMousePosition()
		local pick = camera:Pick(framebuffer, mousepos.x, mousepos.y, 0, true)
		
		if pick.entity then
			
			-- If anything was picked, get all entities in a box around the picked position
			local range = 5
			local entities = world:GetEntitiesInArea(pick.position - range, pick.position + range)
			
			-- Iterate through the returned entities
			for n = 1, #entities do
				
				-- Get the vector between the entity position and the picked position
				local dir = entities[n].position - pick.position
				
				-- Get the distance from the entity to the picked position
				local dist = dir:Length()
				
				-- Apply force only if the distance is less than the blast radius
				if dist < range then
					force = dir:Normalize()
					force = force * (range - dist) * 100
					entities[n]:AddForce(force)
				end
			end
		end
		
	end
	
    -- Update the world
    world:Update()
	
    -- Render the world
    world:Render(framebuffer)
	
end
```

## Rotated Box Test

```lua
-- Get the displays
local displays = GetDisplays()

-- Create window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create world
local world = CreateWorld()
world:SetAmbientLight(1)

-- Create the ground
local ground = CreateBox(world, 50, 1, 50)
ground:SetPosition(0,-0.5,0)
ground:SetColor(0.5)

-- Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetRotation(35,0,0)
camera:Move(0,0,-10)

-- Create a box to test
local volume = CreateBox(world)
volume:SetPosition(0,0.5,0)
volume:SetScale(20,0.9,3)
volume:SetCollider(nil)

-- Create a field of objects
local boxes = {}
for x = -5, 5 do
	for y = -5, 5 do
		local box = CreateBox(world)
		box:SetPosition(x * 2, 0.5, y * 2)
		box:SetPickMode(PICK_NONE)
		box:SetMass(1)
		box:SetColor(1,0,0)
		table.insert(boxes, box)
	end
end

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do

	-- Rotate the volume
	volume:Turn(0,1,0)

	-- Iterate through all the objects
	for n = 1, #boxes do
		
		boxes[n]:SetColor(1,0,0)
		
		-- Transform the object position from world space to the volume's local space
		local p = TransformPoint(boxes[n].position, nil, volume)
		
		-- If the transformed position is within the volume, change the color
		if Abs(p.x) < 0.5 and Abs(p.y) < 0.5 and Abs(p.z) < 0.5 then
			boxes[n]:SetColor(0,1,0)
		end
		
	end
	
    -- Update the world
    world:Update()
	
    -- Render the world
    world:Render(framebuffer)
	
end
```

## Volume Intersection Test

```lua
-- Get the displays
local displays = GetDisplays()

-- Create window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create world
local world = CreateWorld()
world:SetAmbientLight(1)

-- Create the ground
local ground = CreateBox(world, 50, 1, 50)
ground:SetPosition(0,-0.5,0)
ground:SetColor(0.5)

-- Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetRotation(35,0,0)
camera:Move(0,0,-10)

-- Create a wedge brush to test
local volume = CreateBrush(world)
volume:SetPosition(0,0.4,0)
volume:SetScale(10,1,10)
volume:SetCollisionType(COLLISION_NONE)

volume:AddVertex(0.5, 0.5, 0.5)
volume:AddVertex(-0.5, 0.5, 0.5)
volume:AddVertex(-0.5, 0.5, -0.5)
volume:AddVertex(0.5, -0.5, 0.5)
volume:AddVertex(-0.5, -0.5, 0.5)
volume:AddVertex(-0.5, -0.5, -0.5)

-- Note that indices are one-based in Lua. If you convert this code to C++, subtract one from each indice

-- Top
local face = volume:AddFace()
face:AddIndice(1)
face:AddIndice(2)
face:AddIndice(3)

-- Bottom
face = volume:AddFace()
face:AddIndice(4)
face:AddIndice(5)
face:AddIndice(6)

--Side 1
face = volume:AddFace()
face:AddIndice(1)
face:AddIndice(2)
face:AddIndice(5)
face:AddIndice(4)

--Side 2
face = volume:AddFace()
face:AddIndice(2)
face:AddIndice(3)
face:AddIndice(6)
face:AddIndice(5)

--Side 3
face = volume:AddFace()
face:AddIndice(3)
face:AddIndice(1)
face:AddIndice(4)
face:AddIndice(6)

volume:Build()

-- Create a field of objects
local boxes = {}
for x = -5, 5 do
	for y = -5, 5 do
		local box = CreateBox(world)
		box:SetPosition(x * 2, 0.5, y * 2)
		box:SetPickMode(PICK_NONE)
		box:SetMass(1)
		box:SetColor(1,0,0)
		table.insert(boxes, box)
	end
end

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do

	-- Rotate the volume
	volume:Turn(0,1,0)

	-- Iterate through all the objects
	for n = 1, #boxes do
		
		boxes[n]:SetColor(1,0,0)
		
		-- If the transformed position is within the volume, change the color
		if volume:IntersectsPoint(boxes[n].position) then
			boxes[n]:SetColor(0,1,0)
		end
		
	end
	
    -- Update the world
    world:Update()
	
    -- Render the world
    world:Render(framebuffer)
	
end
```

## Entity Visibility Test

```lua
-- Get the displays
local displays = GetDisplays()

-- Create window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create world
local world = CreateWorld()
world:SetAmbientLight(1)

-- Create the ground
local ground = CreateBox(world, 50, 1, 50)
ground:SetPosition(0,-0.5,0)
ground:SetColor(0.5)

-- Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetRotation(35,0,0)
camera:Move(0,0,-10)

local player = CreateCylinder(world, 0.5, 2)
player:SetCollider(nil)
player:SetPosition(0,1,0)
player:SetColor(0,0,1)

local viewrange = 20

local cone = CreateCone(world, 1, 1)
cone:SetCollider(nil)
cone:SetScale(viewrange, viewrange, viewrange)
local mtl = CreateMaterial()
mtl:SetTransparent(true)
mtl:SetColor(1,1,0,0.5)
mtl:SetBackFaceCullMode(false)
cone:SetMaterial(mtl)

local boxes = {}

for x = -5, 5 do
    for y = -5, 5 do
        local box = CreateBox(world)
        box:SetPosition(x * 2, 0.5, y * 2)
        box:SetPickMode(PICK_NONE)
        box:SetMass(1)
        box:SetColor(Random(), Random(), Random())
        table.insert(boxes, box)
    end
end

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do
	
	-- Control the player with the arrow keys
	if window:KeyDown(KEY_RIGHT) then player:Turn(0,1,0) end
	if window:KeyDown(KEY_LEFT) then player:Turn(0,-1,0) end
	if window:KeyDown(KEY_UP) then player:Move(0,0,0.1) end
	if window:KeyDown(KEY_DOWN) then player:Move(0,0,-0.1) end
	
	-- Position the visible cone
	local p = TransformPoint(0, 0, viewrange / 2, player, nil)
	cone:SetPosition(p)
	cone:SetRotation(player.rotation)
	cone:Turn(-90,0,0)
	
	-- Restore the color of all objects
	for n = 1, #boxes do
		boxes[n]:SetColor(1,0,0)
	end
	
	-- Get all entities that intersect the cone bounding box
	local bounds = cone:GetBounds(BOUNDS_GLOBAL)	
	local entities = world:GetEntitiesInArea(bounds.min, bounds.max)

	-- Iterate through the returned entities
	for n = 1, #entities do
		if entities[n] ~= ground and entities[n] ~= player and entities[n] ~= cone then
			
			-- Check to see if the entity position is inside the view cone
			p = TransformPoint(entities[n].position, nil, player)
			if p.z < viewrange then
				if p.z > p.xy:Length() then
					entities[n]:SetColor(0,1,0)
				end
			end
			
		end
	end
	
    -- Update the world
    world:Update()
	
    -- Render the world
    world:Render(framebuffer)

end
```

We can modify our example to include line-of-sight testing.

```lua
-- Get the displays
local displays = GetDisplays()

-- Create window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create world
local world = CreateWorld()
world:SetAmbientLight(1)

-- Create the ground
local ground = CreateBox(world, 50, 1, 50)
ground:SetPosition(0,-0.5,0)
ground:SetColor(0.5)

-- Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetRotation(35,0,0)
camera:Move(0,0,-10)

local player = CreateCylinder(world, 0.5, 2)
player:SetCollider(nil)
player:SetPosition(0,1,0)
player:SetColor(0,0,1)

local viewrange = 20

local cone = CreateCone(world, 1, 1)
cone:SetCollider(nil)
cone:SetScale(viewrange, viewrange, viewrange)
cone:SetPickMode(PICK_NONE)
local mtl = CreateMaterial()
mtl:SetTransparent(true)
mtl:SetColor(1,1,0,0.5)
mtl:SetBackFaceCullMode(false)
cone:SetMaterial(mtl)

local wall = CreateBox(world, 1,3,6)
wall:SetPosition(2,1.5,0)

local boxes = {}

for x = -5, 5 do
    for y = -5, 5 do
        local box = CreateBox(world)
        box:SetPosition(x * 2, 0.5, y * 2)
        box:SetPickMode(PICK_NONE)
        box:SetMass(1)
        box:SetColor(Random(), Random(), Random())
        table.insert(boxes, box)
    end
end

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do
	
	-- Control the player with the arrow keys
	if window:KeyDown(KEY_RIGHT) then player:Turn(0,1,0) end
	if window:KeyDown(KEY_LEFT) then player:Turn(0,-1,0) end
	if window:KeyDown(KEY_UP) then player:Move(0,0,0.1) end
	if window:KeyDown(KEY_DOWN) then player:Move(0,0,-0.1) end
	
	-- Position the visible cone
	local p = TransformPoint(0, 0, viewrange / 2, player, nil)
	cone:SetPosition(p)
	cone:SetRotation(player.rotation)
	cone:Turn(-90,0,0)
	
	-- Restore the color of all objects
	for n = 1, #boxes do
		boxes[n]:SetColor(1,0,0)
	end
	
	-- Get all entities that intersect the cone bounding box
	local bounds = cone:GetBounds(BOUNDS_GLOBAL)	
	local entities = world:GetEntitiesInArea(bounds.min, bounds.max)
	
	-- Iterate through the returned entities
	for n = 1, #entities do
		if entities[n] ~= ground and entities[n] ~= player and entities[n] ~= cone and entities[n] ~= wall then
			
			-- Check to see if the entity position is inside the view cone
			p = TransformPoint(entities[n].position, nil, player)
			if p.z < viewrange then
				if p.z > p.xy:Length() then
					if player:GetVisible(entities[n]) then
						entities[n]:SetColor(0,1,0)
					end
				end
			end
			
		end
	end
	
    -- Update the world
    world:Update()
	
    -- Render the world
    world:Render(framebuffer)

end
```




