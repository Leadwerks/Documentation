# LoadPixmap

This function loads a pixmap from a file path or stream.

## Syntax

- [Pixmap](Pixmap.md) **LoadPixmap**([string](https://www.lua.org/manual/5.4/manual.html#6.4) path)
- [Pixmap](Pixmap.md) **LoadPixmap**([string](https://www.lua.org/manual/5.4/manual.html#6.4) path, number flags)
- [Pixmap](Pixmap.md) **LoadPixmap**([Stream](Stream.md))
- [Pixmap](Pixmap.md) **LoadPixmap**([Stream](Stream.md), number flags)

| Parameter | Description |
|---|---|
| path | file path to load the pixmap from |
| stream | stream to load the pixmap from |
| flags | optional load flags |

## Returns

Returns the loaded pixmap, or NULL if no pixmap was loaded.

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
