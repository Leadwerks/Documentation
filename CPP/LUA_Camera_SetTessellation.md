# Camera.SetTessellation #

## Syntax
- void **SetTessellation**(number polygonsize)

| Parameter | Description |
| --- | --- |
| polygonsize | desired polygon edge length, in screen pixels |

## Example

TODO

```lua
--Get the primary display
local displaylist = GetDisplays()
local display = displaylist[1];
if display == nil then RuntimeError("Primary display not found.") end
local displayscale = display:GetScale()

--Create a window
local window = CreateWindow(display, "Tessellation", 0, 0, 1280, 720, WINDOW_CENTER + WINDOW_TITLEBAR)

--Create a rendering framebuffer
local framebuffer = CreateFramebuffer(window);

--Create a world
local world = CreateWorld()
world:SetSkybox("https://github.com/Leadwerks/Documentation/raw/master/Assets/Materials/Sky/sunset.basis")
world:SetAmbientLight(0)

--Create a camera
local camera = CreateCamera(world)
camera:Move(0,0,-0.75)
camera:SetClearColor(0.25)
camera:SetTessellation(8) --Tessellated primitives are n pixels wide (zero or less disables tessellation)

--Create a light
local light = CreateLight(world,LIGHT_DIRECTIONAL)
light:SetRotation(35,-55,0)
light:SetColor(2,2,2)

--Display material
local model = CreateQuadSphere(world, 0.5, 8, true)
local mtl = LoadMaterial("https://raw.githubusercontent.com/Leadwerks/Documentation/master/Assets/Materials/Ground/rocky_soil.mtl")
model:SetMaterial(mtl)

--Main loop
while window:Closed() == false do

    model:Turn(0,0.1,0,true)

    world:Update()
    world:Render(framebuffer)

end
```
