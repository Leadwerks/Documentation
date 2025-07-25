# LoadMaterial

This function loads a material from a file or open stream.

## Syntax

- [Material](Material.md) **LoadMaterial**([string](https://www.lua.org/manual/5.4/manual.html#6.4) path)
- [Material](Material.md) **LoadMaterial**([string](https://www.lua.org/manual/5.4/manual.html#6.4) path, number flags)
- [Material](Material.md) **LoadMaterial**([Stream](Stream.md) stream)
- [Material](Material.md) **LoadMaterial**([Stream](Stream.md) stream, number flags)

| Parameter | Description |
| ------ | ------ |
| path | path or URL to the file to be loaded |
| stream | an open file stream to load the asset from |
| flags | LoadFlags parameter to use |

## Remarks
Any of the values below may be combined in the flags parameter:
- LOAD_DEFAULT: Default load behavior.
- LOAD_UNMANAGED: Does not store or load cached object.
- LOAD_QUIET: Does not print loading messages.
- LOAD_DUMP_INFO: Prints extra file information for debugging.
- LOAD_NO_OVERRIDE: Does not use workflows to redirect files.
- LOAD_NO_CACHE: Ignores cached copies of downloaded files.
 
## Example

```lua
--Get the primary display
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_TITLEBAR)

--Create a rendering framebuffer
local framebuffer = CreateFramebuffer(window);

--Create a world
local world = CreateWorld()
world:SetAmbientLight(1)

--Create a camera
local camera = CreateCamera(world)
camera:Move(0,0,-1)

--Display material
local model = CreateBox(world)

--Load material
local mtl = LoadMaterial("https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets/brickwall01.mtl")
if mtl ~= nil then model:SetMaterial(mtl) end

--Main loop
while window:Closed() == false do
    world:Update()
    world:Render(framebuffer)
end
```
