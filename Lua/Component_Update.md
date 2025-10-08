# Entity:Update

This function is called once per call to [World:Update](World_Update.md).

## Syntax

- **Update**()

## Example

```lua
--Get the displays
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Leadwerks", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

--Create a framebuffer
local framebuffer = CreateFramebuffer(window)

--Create a world
local world = CreateWorld()

--Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetPosition(0, 0, -2)

--Create a light
local light = CreateBoxLight(world)
light:SetRotation(45, 35, 0)
light:SetColor(2)
light:SetRange(-5, 5)

--Create the ground
local ground = CreateBox(world, 10, 0.25, 10)
ground.name = "Ground"
ground:SetPosition(0,-1,0)

--Create a model
local box = CreateBox(world)
box:SetColor(0,0,1)

function box:Update()
	self:Turn(0,1,0)
end

while window:KeyDown(KEY_ESCAPE) == false and window:Closed() == false do

    --Update the world
    world:Update()

    --Render the world to the framebuffer
    world:Render(framebuffer)

end
```
