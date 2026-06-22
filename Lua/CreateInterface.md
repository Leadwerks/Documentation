# CreateInterface

This function creates a new graphical user interface for desktop applications or in-game interfaces.

## Syntax

- [Interface](Interface.md) **CreateInterface**([Window](Window.md) window)
- [Interface](Interface.md) **CreateInterface**([Camera](Camera.md) camera, [Font](Font.md) font, [iVec2](iVec2.md) size)
- [Interface](Interface.md) **CreateInterface**([World](World.md) camera, [Font](Font.md) font, [iVec2](iVec2.md) size)

| Parameter | Description |
| --- | --- |
| window | window to create the user interface on |
| world | world to create the interface in, for 3D graphics |
| camera | camera to create the interface on, for 3D graphics |
| font | font to use, for 3D graphics |
| size | interface dimensions, for 3D graphics |

## Returns

Returns a new interface object.

## Remarks

If the interface is created on a camera or world, it will be rendered using [Tile](Tile.md) objects. If the interface is created on a camera it will be drawn after the camera is rendered. If the interface is created on a world, it will be drawn after all cameras are rendered.

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
The next example will display an interface inside the 3D world. This can be used to display an interface on a panel in the game, or a menu floating in the air in VR.
```lua
-- Get displays
local displays = GetDisplays()

-- Create window
local window = CreateWindow("Leadwerks", 0, 0, 1280, 720, displays[1])

-- Create framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create world
local world = CreateWorld()

-- Load font
local font = LoadFont("Fonts/arial.ttf")

-- Create camera
local camera = CreateCamera(world)
camera:SetPosition(0, 0, -2)
camera:SetZoom(2)
camera:SetClearColor(0.125)

-- Create a box model
local box = CreateBox(world)
box:SetRotation(0, 45, 0)
box:SetPickMode(PICK_MESH)

-- Create a light
local light = CreateBoxLight(world)
light:SetRotation(45, 35, 0)
light:SetRange(-10, 10)
light:SetColor(2)

-- Create orthographic camera for UI
local uicamera = CreateCamera(world, PROJECTION_ORTHOGRAPHIC)
uicamera:SetRealtime(false)
uicamera:SetLighting(false)

-- Create texture buffer for render target
local texbuffer = CreateTextureBuffer(TEXTURE_RGBA, 256, 256)
uicamera:SetRenderTarget(texbuffer)

-- Create material and assign texture
local mtl = CreateMaterial()
mtl:SetTexture(texbuffer:GetColorAttachment(0))
box:SetMaterial(mtl)

-- Create UI
local ui = CreateInterface(uicamera, font, texbuffer.size)

-- Create button
local sz = ui.background:ClientSize()
local button = CreateButton("Button", sz.x / 2 - 75, sz.y / 2 - 15, 150, 30, ui.background)

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do
    -- Handle events
    while PeekEvent() do
        local ev = WaitEvent()
        if ev.id == EVENT_MOUSEDOWN or ev.id == EVENT_MOUSEUP or ev.id == EVENT_MOUSEMOVE then
            local pick = camera:Pick(framebuffer, ev.position.x, ev.position.y, 0, true)
            if pick.entity == box then
                ev.position.x = Round(pick.texcoords[1].x * 256)
                ev.position.y = Round(pick.texcoords[1].y * 256)
                ProcessEvent(ev)
                uicamera:Render()
            end
        end
    end

    -- Update world
    world:Update()

    -- Render scene to framebuffer
    world:Render(framebuffer)
end
```
