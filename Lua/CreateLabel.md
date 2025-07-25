# CreateLabel

The label widget displays a read-only block of text.

## Syntax

- [Widget](Widget.md) **CreateLabel**([string](https://www.lua.org/manual/5.4/manual.html#6.4) text, number x, number y, number width, number height, [Widget](Widget.md) parent)
- [Widget](Widget.md) **CreateLabel**([string](https://www.lua.org/manual/5.4/manual.html#6.4) text, number x, number y, number width, number height, [Widget](Widget.md) parent, number style)

| Parameter | Description |
|---|---|
| text | widget text |
| x | widget x position |
| y | widget y position |
| width | widget width |
| height | widget height |
| parent | parent widget |
| style | optional button style, can be any combination of LABEL_LEFT, LABEL_RIGHT, LABEL_CENTER, LABEL_TOP, LABEL_MIDDLE, LABEL_BOTTOM, and LABEL_BORDER |

## Example

![](https://github.com/Leadwerks/Documentation/raw/master/Images/CreateLabel.png)

```lua
-- Get the displays
local displays = GetDisplays()

-- Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create User Interface
local ui = CreateInterface(window)

-- Create widget
local label1 = CreateLabel("Label", 20, 20, 120, 30, ui.background)
local label2 = CreateLabel("Border Label", 20, 50, 120, 30, ui.background, LABEL_BORDER | LABEL_CENTER | LABEL_MIDDLE)

while not window:Closed() do
    WaitEvent()
end
```
