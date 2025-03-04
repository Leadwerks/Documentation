# CreateSpotLight

This function creates a new spot light.

## Syntax

- [SpotLight](SpotLight.md) **CreateSpotLight**(world)

## Parameters

| Parameter | Description |
|---|---|
| world | world to create the light in |

## Returns

Returns a new light.

## Example

```lua
--Get the displays
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

--Create a framebuffer
local framebuffer = CreateFramebuffer(window)

--Create a world
local world = CreateWorld()

--Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetFOV(70)
camera:Move(0, 2, -2)

--Create light
local light = CreateSpotLight(world)
light:SetPosition(0,1,0)
light:SetColor(2)

--Create ground
local ground = CreateBox(world, 20, 1, 20)
ground:SetPosition(0, -0.5, 0)
ground:SetColor(0, 1, 0)

--Main loop
while window:Closed() == false and window:KeyHit(KEY_ESCAPE) == false do
    world:Update()
    world:Render(framebuffer)
end
```
