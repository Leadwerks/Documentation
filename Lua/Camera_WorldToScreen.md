# Camera:WorldToScreen

This method projects a 3D position onto 2D screen space.

## Syntax

- [Vec3](Vec3.md) **WorldToScreen**([Vec3](Vec3.md) point, [Framebuffer](Framebuffer.md) framebuffer)

| Parameter | Description |
|---|---|
| point | position in global space |
| framebuffer | framebuffer to test with |

## Returns

Returns a screen coordinate with the distance in front of the camera stored in the Z component.

## Example

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
