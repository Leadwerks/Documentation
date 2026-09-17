# GetHmd

This function returns the head-mounted display, for virtual reality rendering.

## Syntax

- [Hmd](Hmd.md) **GetHmd**(shared_ptr<[World](World.md)\> world = nil)

| Parameter | Description |
|---|---|
| world | world to display the VR controllers in |

## Returns

Returns an object representing the user's head-mounted display. If the world parameter is non-nil, this will always be returned, regardless of whether the headset is plugged in or active.

If the world parameter is nil or not defined, the function will only return an HMD object if the HMD has already been initialized. This can be used to check if an application is running in VR mode.

## Remarks

You must call [Hmd:Start](Hmd_Start.md) to start a new OpenXR session before the headset will be usable.

## Example

```lua
--Get the displays
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_CLIENTCOORDS | WINDOW_CENTER | WINDOW_TITLEBAR)

--Create a framebuffer
local framebuffer = CreateFramebuffer(window)

--Create a world
local world = CreateWorld()

--Get the VR headset
local hmd = GetHmd(world)
hmd:Start(framebuffer)

--Environment maps
local specmap = LoadTexture("https://github.com/Leadwerks/Documentation/raw/master/Assets/Materials/Environment/footprint_court/specular.dds")
local diffmap = LoadTexture("https://github.com/Leadwerks/Documentation/raw/master/Assets/Materials/Environment/footprint_court/diffuse.dds")
world:SetEnvironmentMap(specmap, ENVIRONMENTMAP_BACKGROUND)
world:SetEnvironmentMap(specmap, ENVIRONMENTMAP_SPECULAR)
world:SetEnvironmentMap(diffmap, ENVIRONMENTMAP_DIFFUSE)

--Create a light
local light = CreateBoxLight(world)
light:SetRotation(55, 35, 0)
light:SetRange(-10, 10)
light:SetColor(2)

--Add a floor
local floor = CreateBox(world, 5, 1, 5)
floor:SetPosition(0, -0.5, 0)
local mtl = CreateMaterial()
mtl:SetTexture(LoadTexture("https://github.com/UltraEngine/Documentation/raw/master/Assets/Materials/Developer/griid_gray.dds"))
floor:SetMaterial(mtl)

--Main loop
while window:Closed() == false and window:KeyDown(KEY_ESCAPE) == false do
    world:Update()
    world:Render(framebuffer)
end
```
