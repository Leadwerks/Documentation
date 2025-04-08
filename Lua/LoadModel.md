# LoadModel

This function loads a model from a file.

## Syntax

- [Model](Model.md) **LoadModel**([string](https://www.lua.org/manual/5.4/manual.html#6.4) path, number flags = LOAD_DEFAULT)
- [Model](Model.md) **LoadModel**([Stream](Stream.md) stream, number flags = LOAD_DEFAULT)

### Parameters

| Parameter | Description |
|---|---|
| path | file path to read from |
| stream | stream to read from |

## Returns

Returns the loaded model if successful, otherwise nil is returned.

## Remarks

Ultra Engine natively supports glTF, OBJ, and Leadwerks MDL files. MDL files with DDS textures will provide the fastest loading.

## Example

![](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/loadplugin.jpg)

```lua
--Get the displays
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

--Create a world
local world = CreateWorld()
world:SetAmbientLight(0)

--Create a framebuffer
local framebuffer = CreateFramebuffer(window)

--Load FreeImage plugin
local plg = LoadPlugin("Plugins/FITextureLoader")

--Load model
--Cyber Samurai by Khoa Minh: https://sketchfab.com/3d-models/cyber-samurai-26ccafaddb2745ceb56ae5cfc65bfed5
local model = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Characters/cyber_samurai.glb")
model:Turn(0, 180, 0, true)

--Environment maps
local specmap = LoadTexture("https://github.com/UltraEngine/Assets/raw/main/Materials/Environment/footprint_court/specular.dds")
local diffmap = LoadTexture("https://github.com/UltraEngine/Assets/raw/main/Materials/Environment/footprint_court/diffuse.dds")
world:SetEnvironmentMap(diffmap, ENVIRONMENTMAP_BACKGROUND)
world:SetEnvironmentMap(specmap, ENVIRONMENTMAP_SPECULAR)
world:SetEnvironmentMap(diffmap, ENVIRONMENTMAP_DIFFUSE)

--Create a camera    
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetPosition(0, 1.4, -1)
camera:SetFov(70)

--Add camera controls
camera:AddComponent(CameraControls)

--Create light
local light = CreateBoxLight(world)
light:SetRange(-10, 10)
light:SetArea(15, 15)
light:SetRotation(45, 35, 0)
light:SetColor(1.2)

--Main loop
while window:Closed() == false and window:KeyDown(KEY_ESCAPE) == false do
    world:Update()
    world:Render(framebuffer)
end
```
