# World:Render

This method sends all queued rendering instructions to the rendering thread and tells it to render and display the contents of this world.

## Syntax

- **Render**([Framebuffer](Framebuffer.md) framebuffer, boolean vsync = true, number maxframerate = 0)

| Parameter | Description |
|---|---|
| framebuffer | framebuffer to render to |
| vsync | if set to true vertical sync is enabled |
| maxframerate | maximum allowed framerate, or zero for unlimited |

## Remarks

If vertical sync is disabled the framerate will be uncapped and will usually be higher, but screen tearing artifacts can occur. Vertical sync should be disabled when benchmarking performance.

Rendering in Ultra Engine is asychronous, meaning it is executed on a separate thread from your game logic. Consequently, there is some delay between the first call to World::Render and the first appearance of visible graphics on the screen. Additionally, initialization of the renderer can fail if the hardware it is running on does not meet system requirements. You can evaluate the STARTRENDERER event to wait until the renderer has started drawing before you begin your game logic, to detect if the renderer has failed to initialize, and to retrieve the name of the graphics device the renderer is using. The event.data member will be set to 1 if the renderer was initialized successfully, otherwise it will be set to 0. The device name will be stored in the event.text member.

If your game spendsa significant amount of time initializing a scene, you can save a few seconds of loading time by calling this method immediately after creating a framebuffer so that initialization is performed at the same time your game is loading.

## Example

```lua
-- Get the displays
local displays = GetDisplays()

-- Create window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create world
local world = CreateWorld()

-- Create framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create a camera
local camera = CreateCamera(world, PROJECTION_ORTHOGRAPHIC)
camera:SetClearColor(0.125)

while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do
    while PeekEvent() do
        local e = WaitEvent()
        if e.id == EVENT_STARTRENDERER then
            if e.data == 1 then
                -- Display the graphics device name
                window:SetText(window.text .. " - " .. e.text)
            else
                -- Show error message
                Notify("Renderer failed to initialize.\n\n" .. e.text, "Error", true)
                return 0
            end
        elseif e.id == EVENT_QUIT then
            return 0
        end
    end

    world:Update()
    world:Render(framebuffer)
end
```
