# Camera Projection

Camera projection and unprojection allows us to transform screen coordinates to world coordinates and back.

www.youtube.com/watch?v=AU_Wwa3IR9c

## Camera Projection

Camera projection is performed using the [Camera:WorldToScreen](Camera_WorldToScreen.md) command. This method accepts a position in world space and transforms it into a screen coordinate. The example below will display some text onscreen above a movable 3D model:

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

--Load a model
local ship = LoadModel(world, "https://github.com/Leadwerks/Documentation/raw/refs/heads/master/Assets/Models/Spaceship/spaceship.mdl")
ship:SetPosition(0,0,4)

--Load a font
local font = LoadFont("Fonts/arial.ttf")

--Create a text tile to display a label over the ship
local tile = CreateTile(world, font, "Spaceship", 32, TEXT_CENTER | TEXT_BOTTOM)

--Main loop
while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do
	
    --Key controls move and rotate ship
    if window:KeyDown(KEY_RIGHT) then ship:Move(0.1,0,0) end
    if window:KeyDown(KEY_LEFT) then ship:Move(-0.1,0,0) end
    if window:KeyDown(KEY_UP) then ship:Move(0,0.1,0) end
    if window:KeyDown(KEY_DOWN) then ship:Move(0,-0.1,0) end
	
	--Get the ship bounding box, including any children it may have
	local bounds = ship:GetBounds(BOUNDS_RECURSIVE)
	
	--Create the point where the text should appear
	local pos = Vec3(0)
	pos.x = bounds.center.x
	pos.y = bounds.max.y
	pos.z = bounds.center.z
	
	--Project the point from the world to the screen
	local screencoord = camera:WorldToScreen(pos, framebuffer)
	tile:SetPosition(screencoord.x, screencoord.y)
	
    --Update the world
    world:Update()

    --Render the world
    world:Render(framebuffer)
	
end
```

## Camera Unprojection

The reverse operation can be accomplished using the [Camera:ScreenToWorld](Camera_ScreenToWorld.md) command. This accepts a 2D screen coordinate, along with a Z value for distance in front of the camera, and transforms it into a position in world space. You can use this to precisely position an object so that it follows the mouse.

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

--Load a model
local ship = LoadModel(world, "https://github.com/Leadwerks/Documentation/raw/refs/heads/master/Assets/Models/Spaceship/spaceship.mdl")
ship:SetPosition(0,0,4)

--Main loop
while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do
	
	--Un-Project the point from the screen to the world
	local mousepos = window:GetMousePosition()
	local z = 4
	local pos = camera:ScreenToWorld(mousepos.x, mousepos.y, z, framebuffer)
	
	--Set the ship position
	ship:SetPosition(pos)
	
    --Update the world
    world:Update()

    --Render the world
    world:Render(framebuffer)
	
end
```
