# LoadIcon

This functions loads a vector image from a file path or stream.

## Syntax

- [Icon](Icon.md) **LoadIcon**([string](https://www.lua.org/manual/5.4/manual.html#6.4) path)
- [Icon](Icon.md) **LoadIcon**([string](https://www.lua.org/manual/5.4/manual.html#6.4) path, number flags)
- [Icon](Icon.md) **LoadIcon**([Stream](Stream.md) stream)
- [Icon](Icon.md) **LoadIcon**([Stream](Stream.md) stream, number flags)

| Parameter | Description |
|---|---|
| path | file path to load the icon from |
| stream | stream to load the icon from |
| flags | optional loading flags |

## Returns

Returns the loaded icon object if successful, otherwise NULL is returned.

## Example

```lua
--Get the displays
local displays = GetDisplays()

--Create window
local window = CreateWindow("Ultra Engine", 0, 0, 800, 800, displays[1])

--Create user interface
local ui = CreateInterface(window)

--Create a pixmap
local icon = LoadIcon("https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets/Materials/Logos/23.svg")

--Show the icon
ui.background:SetIcon(icon)

while true do
    local ev = WaitEvent()
    if ev.id == EVENT_WINDOWCLOSE then
        break
    end
end
```
