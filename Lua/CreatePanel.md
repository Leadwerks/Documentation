# CreatePanel

This function creates a Panel widget. The Panel widget is a rectangular area for framing child widgets.

## Syntax

- [Widget](Widget.md) **CreatePanel**(number x, number y, number width, number height, [Widget](Widget.md) parent)
- [Widget](Widget.md) **CreatePanel**(number x, number y, number width, number height, [Widget](Widget.md) parent, number style = PANEL_DEFAULT)

| Parameter | Description |
|---|---|
| x | initial x position of the widget |
| y | initial y position of the widget |
| width | initial width of the widget |
| height | initial height of the widget |
| parent | parent of the widget |
| style | optional widget style, can be PANEL_DEFAULT, PANEL_BORDER, or PANEL_GROUP |

## Returns

Returns a new panel widget.

## Example

![CreatePanel Example](https://github.com/Leadwerks/Documentation/raw/master/Images/CreatePanel.png)

```lua
-- Get the displays
local displays = GetDisplays()

-- Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR | WINDOW_RESIZABLE)

-- Create User Interface
local ui = CreateInterface(window)
local sz = ui.background:ClientSize()

-- Create widget
local panel = CreatePanel(50, 50, sz.x - 100, sz.y - 100, ui.background)
panel:SetColor(0, 0, 0, 1)
panel:SetLayout(1, 1, 1, 1)

while true do
    local ev = WaitEvent()
    if ev.id == EVENT_WINDOWCLOSE then
        return 0
    end
end
```
