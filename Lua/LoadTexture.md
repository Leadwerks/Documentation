# LoadTexture

This function loads a texture from a file or open stream.

## Syntax

- **LoadTexture**([string](https://www.lua.org/manual/5.4/manual.html#6.4) path)
- **LoadTexture**([string](https://www.lua.org/manual/5.4/manual.html#6.4) path, number flags)
- **LoadTexture**([Stream](Stream.md))
- **LoadTexture**([Stream](Stream.md), number flags)

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
local window = CreateWindow("Ultra Engine", 0, 0, 1280,720, displays[1], WINDOW_TITLEBAR | WINDOW_CENTER)

--Create a rendering framebuffer
local framebuffer = CreateFramebuffer(window);

--Create a world
local world = CreateWorld()
world:SetAmbientLight(1)

--Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:Move(0,0,-1)

--Display material
local model = CreateBox(world)
local mtl = CreateMaterial()
model:SetMaterial(mtl)

--Load texture
local tex = LoadTexture("https://www.github.com/Leadwerks/Documentation/raw/master/Assets/brickwall01.dds")
mtl:SetTexture(tex, TEXTURE_BASE)

--Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do
	world:Update()
	world:Render(framebuffer)
end
```
