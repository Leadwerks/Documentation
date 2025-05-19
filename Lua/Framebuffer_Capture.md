# Framebuffer:Capture

This method can be used to capture a screenshot.

## Syntax

- **Capture**()

## Remarks

This method will cause the contents of the framebuffer to be copied to a [Pixmap](Pixmap.md) when the first frame is rendered after the next call to [World::Render](World_Render.md). The captured image will be available in the array returned by [Framebuffer:GetCaptures](Framebuffer_GetCaptures.md). One frame will be captured for each call to this method.

## Example

```lua
--Get the displays
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_TITLEBAR | WINDOW_CENTER)

--Create a framebuffer
local framebuffer = CreateFramebuffer(window)

--Create a world
local world = CreateWorld()

--Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetPosition(0, 0, -2)

--Create a light
local light = CreateBoxLight(world)
light:SetRotation(45, 35, 0)
light:SetRange(-10, 10)
light:SetColor(2)

--Create a model
local box = CreateBox(world)
box:SetColor(0, 0, 1)

--Main loop
while not window:Closed() and not window:KeyHit(KEY_ESCAPE) do
    --Rotate the model
    box:Turn(0, 1, 0)

    --Press the space key to queue a screenshot
    if window:KeyHit(KEY_SPACE) then
        framebuffer:Capture()
    end

    --Look for captured frames
    local caps = framebuffer:GetCaptures()
    for _, pixmap in pairs(caps) do
        local path = GetPath(PATH_DESKTOP) .. "/screenshot.jpg"
        pixmap:Save(path)
        RunFile(path)
    end

    --Update world
    world:Update()

    --Render world
    world:Render(framebuffer, true)
end
```
