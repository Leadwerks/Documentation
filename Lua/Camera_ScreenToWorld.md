# Camera:ScreenToWorld

This method projects 2D screen coordinate to a point in world space.

## Syntax

- [Vec3](Vec3.md) **ScreenToWorld**([Vec3](Vec3.md) coord, [Framebuffer](Framebuffer.md) framebuffer)

| Parameter | Description |
|---|---|
| coord | screen coordinate, plus distance in front of camera stored in the Z component |
| framebuffer | framebuffer to test with |

## Returns

Returns a 3D position in global space.

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
