# CreateSlider

The slider widget adjusts an integer value within a defined range. Three different styles are available. The slider can also be set to scroll horizontally or vertically with an additional style flag.

## Syntax

- [Widget](Widget.md) **CreateSlider**(number x, number y, number width, number height, [Widget](Widget.md) parent)
- [Widget](Widget.md) **CreateSlider**(number x, number y, number width, number height, [Widget](Widget.md) parent, number style = SLIDER_DEFAULT)

| Parameter | Description |
| --- | --- |
| x | widget X position |
| y | widget Y position |
| width | widget width |
| height | widget height |
| parent | parent widget |
| style | slider style, can be any combination of SLIDER_SCROLLBAR, SLIDER_STEPPER, SLIDER_TRACKBAR, SLIDER_HORIZONTAL, and SLIDER_VERTICAL |

## Returns

Returns a new slider widget.

## Example

![CreateSlider](https://github.com/Leadwerks/Documentation/raw/master/Images/CreateSlider.png)

```lua
-- Get the displays
local displays = GetDisplays()

-- Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create User Interface
local ui = CreateInterface(window)

-- Create widget
local sz = ui.background:ClientSize()
local slider1 = CreateSlider(10, 10, 200, 30, ui.background, SLIDER_SCROLLBAR)
local slider2 = CreateSlider(10, 10 + 50, 200, 30, ui.background, SLIDER_TRACKBAR)
local slider3 = CreateSlider(10, 10 + 50 * 2, 30, 30, ui.background, SLIDER_STEPPER | SLIDER_VERTICAL)

while true do
    local ev = WaitEvent()
    if ev.id == EVENT_WIDGETACTION then
        Print("Widget action: " .. tostring(ev.data))
    elseif ev.id == EVENT_WINDOWCLOSE then
        return 0
    end
end
```
