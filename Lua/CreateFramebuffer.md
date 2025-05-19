# CreateFramebuffer

This function creates a new framebuffer object for 2D and 3D rendering.

## Syntax
- [Framebuffer](Framebuffer.md) **CreateFramebuffer**([Window](Window.md) window)

| Parameter | Description |
| --- | --- |
| window | window to create the framebuffer on |

## Returns

Returns a new framebuffer object if one is successfully created, otherwise NULL is returned.

## Remarks

A framebuffer cannot be created on a window that uses the WINDOW_RESIZABLE window style.

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
    for _, pixmap in pairs(world.framecaptures) do
        local path = GetPath(PATH_DESKTOP) .. "/screenshot" .. tostring(e.data + 1) .. ".jpg"
        pixmap:Save(path)
        RunFile(path)
    end

    --Update world
    world:Update()

    --Render world
    world:Render(framebuffer, true)
end
```
