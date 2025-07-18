# Interface:ProcessEvent

This method sends an event to an interface to be evaluated.

## Syntax

- **ProcessEvent**([Event](Event.md) event)

| Parameter | Description |
|---|---|
| event | event to be evaluated |

## Remarks

When an interface is created directly on a window it will automatically receive events from the window. However, when an interface is created to appear in a 3D rendering viewport, events must be manually sent to the interfaces. This allows the user to make changes to events. For example, the coordinates of a mouse event can be transform from 3D space to coordinates on a panel in the 3D world.

## Example

```lua
--Get the displays
local displays = GetDisplays()

--Create window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1])

--Create framebuffer
local framebuffer = CreateFramebuffer(window)

--Create world
local world = CreateWorld()

--Load a font
local font = LoadFont("Fonts/arial.ttf")

--Create user interface
local ui = CreateInterface(world, font, framebuffer.size)

--Create widget
local sz = ui.background:ClientSize()
local button = CreateButton("Button", sz.x / 2 - 75, sz.y / 2 - 15, 150, 30, ui.background)

--Create camera
local camera = CreateCamera(world, PROJECTION_ORTHOGRAPHIC)
camera:SetPosition(framebuffer.size.x * 0.5, framebuffer.size.y * 0.5, 0)

while not window:KeyDown(KEY_ESCAPE) do
    while (PeekEvent()) do
        local ev = WaitEvent()
        if (ev.id == EVENT_WINDOWCLOSE and ev.source == window) then
            return 0
        else
            ui:ProcessEvent(ev)
        end
    end

    world:Update()
    world:Render(framebuffer)
end
```
