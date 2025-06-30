# World:SetEnvironmentMap

This method sets the world skybox or specular and diffuse reflection maps.

## Syntax 

- **World:SetEnvironmentMap**(texture, id)

| Parameter | Description |
|---|---|
| texture | cubemap to set |
| id | environment map ID, may be ENVIRONMENT_BACKGROUND, ENVIRONMENT_SPECULAR, or ENVIRONMENT_DIFFUSE

## Remarks

For best results, environment maps should be generated from HDR images using the [glTF IBL Sampler](https://github.com/KhronosGroup/glTF-IBL-Sampler) tool from Khronos.

You can access a collection of ready-to-use environment maps in the [downloads manager](downloadsmanager.md).

## Example

```lua
-- Get the displays
local displays = GetDisplays()

-- Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create a world
local world = CreateWorld()

-- Create a framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetPosition(0, 0, -2)

-- Set environment maps
local remotepath = "https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets"
local specmap = LoadTexture(remotepath .. "/Materials/Environment/Storm/specular.dds")
local diffmap = LoadTexture(remotepath .. "/Materials/Environment/Storm/diffuse.dds")
world:SetEnvironmentMap(specmap, ENVIRONMENTMAP_BACKGROUND)
world:SetEnvironmentMap(specmap, ENVIRONMENTMAP_SPECULAR)
world:SetEnvironmentMap(diffmap, ENVIRONMENTMAP_DIFFUSE)

local mtl = CreateMaterial()
mtl:SetRoughness(0.25)
mtl:SetMetalness(0.5)

local ball = CreateSphere(world)
ball:SetMaterial(mtl)

-- Main loop
while window:Closed() == false and window:KeyDown(KEY_ESCAPE) == false do
    world:Update()
    world:Render(framebuffer)
end
```
