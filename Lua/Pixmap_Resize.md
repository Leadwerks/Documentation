# Pixmap:Resize

This method resizes a pixmap to make it larger or smaller.

## Syntax

- **Resize**(number width, number height)

| Parameter | Description |
| width, height | The dimensions for resizing the pixmap |

## Returns

If successful a new pixmap is returned, otherwise nil is retuend. Pixmaps that use compressed pixel formats cannot be resized directly, and must be converted to a format like RGBA or RGBA16 before resizing.

## Example

```lua
--Get the displays
local displays = GetDisplays()

--Create window
local window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

--Create user interface
local ui = CreateInterface(window)

--Create a pixmap
local pixmap = LoadPixmap("https://github.com/UltraEngine/Documentation/raw/master/Assets/Materials/Ground/dirt01.dds")

--Resize the pixmap
pixmap = pixmap:Resize(128, 128)

--Show the pixmap
ui.background:SetPixmap(pixmap)

while true do
    local ev = WaitEvent()
    if ev.id == EVENT_WINDOWCLOSE then
        return 0
    end
end
```
