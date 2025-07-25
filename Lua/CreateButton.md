# CreateButton

The button widget can be used to create push buttons, checkboxes, radio buttons, and toolbar items. Buttons emit a WIDGETACTION event when pushed. Some styles use the widget state to indicate whether they are selected.

## Syntax

- [Widget](Widget.md) **CreateButton**([string](https://www.lua.org/manual/5.4/manual.html#6.4) text, number x, number y, number width, number height, [Widget](Widget.md) parent)
- [Widget](Widget.md) **CreateButton**([string](https://www.lua.org/manual/5.4/manual.html#6.4) text, number x, number y, number width, number height, [Widget](Widget.md) parent, number style)

| Parameter | Description |
| --- | --- |
| text | widget text |
| x | widget x position |
| y | widget y position |
| width | widget width |
| height | widget height |
| parent | parent widget |
| style | optional button style, can be any combination of BUTTON_CANCEL, BUTTON_CHECKBOX, BUTTON_RADIO, BUTTON_OK, BUTTON_TOGGLE, and BUTTON_TOOLBAR. |

## Returns

Returns a new button object.

## Example

![](https://github.com/Leadwerks/Documentation/raw/master/Images/CreateButton.png)

```lua
--Get the displays
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[1], WINDOW_TITLEBAR | WINDOW_CENTER)

--Create User Interface
local ui = CreateInterface(window)

--Create buttons
local sz = window:ClientSize()
local x = (sz.x - 120) / 2
local y = 50
local sep = 40

local button = CreateButton("Button", x, y, 120, 30, ui.background)
y = y + sep

local toggle = CreateButton("Toggle", x, y, 120, 30, ui.background, BUTTON_TOGGLE)
y = y + sep

local toolbar = CreateButton("Toolbar", x, y, 120, 30, ui.background, BUTTON_TOOLBAR)
y = y + sep

local checkbox = CreateButton("Checkbox", x, y, 120, 30, ui.background, BUTTON_CHECKBOX)
y = y + sep

local radio1 = CreateButton("Option 1", x, y, 120, 30, ui.background, BUTTON_RADIO)
radio1:SetState(true)

y = y + sep
local radio2 = CreateButton("Option 2", x, y, 120, 30, ui.background, BUTTON_RADIO)

while true do
    local ev = WaitEvent()
    if ev.id == EVENT_WIDGETACTION then
        Print(Widget(ev.source).text)
    elseif ev.id == EVENT_WINDOWCLOSE then
        return 0
    end
end
```
