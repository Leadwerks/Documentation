# CreateInterface

This function creates a new graphical user interface for desktop applications or in-game interfaces.

## Syntax

- [Interface](Interface.md) **CreateInterface**([Window](Window.md) window)
- [Interface](Interface.md) **CreateInterface**([Camera](Camera.md) camera, [Font](Font.md) font, [iVec2](iVec2.md) size)

| Parameter | Description |
| --- | --- |
| window | window to create the user interface on |
| camera | camera to create the interface in, for 3D graphics |
| font | font to use, for 3D graphics |
| size | interface dimensions, for 3D graphics |

## Returns

Returns a new interface object.

## Example

Several examples are shown below to demonstrate different types of programs you can create.

The first example shows how to create an interface directly on a window for an event-based desktop application.

```lua
--Get the displays
local displays = GetDisplays()

--Create window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1])

--Create user interface
local ui = CreateInterface(window)

--Create widget
local sz = ui.background:ClientSize()
local button = CreateButton("Button", sz.x / 2 - 75, sz.y / 2 - 15, 150, 30, ui.background)

while (true) do
    local ev = WaitEvent()
    if (ev.id == EVENT_WINDOWCLOSE and ev.source == window) then
        return 0
    end
end
```

The second example shows how to create an interface that appears in a 3D rendering viewport. Note that in this example you must send events to the interface with the `ProcessEvent` method.

```lua
--Get the displays
local displays = GetDisplays()

--Create window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1])

--Create framebuffer
local framebuffer = CreateFramebuffer(window)

--Create world
local world = CreateWorld()

--Create camera
local camera = CreateCamera(world, PROJECTION_ORTHOGRAPHIC)
camera:SetPosition(framebuffer.size.x * 0.5, framebuffer.size.y * 0.5, 0)

--Load a font
local font = LoadFont("Fonts/arial.ttf")

--Create user interface
local ui = CreateInterface(camera, font, framebuffer.size)

--Create widget
local sz = ui.background:ClientSize()
local button = CreateButton("Button", sz.x / 2 - 75, sz.y / 2 - 15, 150, 30, ui.background)

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

This example shows how to use two cameras to display a GUI on top of a 3D world.

```lua
--Get the displays
local displays = GetDisplays()

--Create window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1])

--Create framebuffer
local framebuffer = CreateFramebuffer(window)

--Create world
local world = CreateWorld()

--Create camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:Move(0,0,-4)

--Create a model
local box = CreateBox(world)

--Create a light
local light = CreateBoxLight(world);
light:SetRotation(45, 35, 0)
light:SetRange(-10,10)
light:SetArea(10,10)

--Load a font
local font = LoadFont("Fonts/arial.ttf")

--Create user interface
local ui = CreateInterface(camera, font, framebuffer.size)
ui:SetRenderLayers(2)
ui.background:SetColor(0,0,0,0.5)

--Create widget
local sz = ui.background:ClientSize()
local button = CreateButton("Button", sz.x / 2 - 75, sz.y / 2 - 15, 150, 30, ui.background)

--Create a camera for the UI
local uicam = CreateCamera(world, PROJECTION_ORTHOGRAPHIC)
uicam:SetPosition(framebuffer.size.x * 0.5, framebuffer.size.y * 0.5, 0)
uicam:SetClearMode(CLEAR_DEPTH)
uicam:SetRenderLayers(2)

while not window:KeyDown(KEY_ESCAPE) do
    while (PeekEvent()) do
        local ev = WaitEvent()
        if (ev.id == EVENT_WINDOWCLOSE and ev.source == window) then
            return 0
        else
            ui:ProcessEvent(ev)
        end
    end

    box:Turn(0,1,0)
    world:Update()
    world:Render(framebuffer)
end
```

