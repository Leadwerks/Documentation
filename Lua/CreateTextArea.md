# CreateTextArea

The text area widget is a read-only multiline text display. If the WORDWRAP style is used the text will be adjusted to fit in the horizontal space of the widget.

## Syntax

- [Widget](Widget.md) **CreateTextArea**(number x, number y, number width, number height, [Widget](Widget.md) parent)
- [Widget](Widget.md) **CreateTextArea**(number x, number y, number width, number height, [Widget](Widget.md) parent, number style)

| Parameter | Description |
| --- | --- |
| x | widget X position |
| y | widget Y position |
| width | widget width |
| height | widget height |
| parent | parent widget |
| style | textfield style, can be TEXTAREA_DEFAULT or TEXTAREA_WORDWRAP |

## Returns

Returns a new TextArea widget.

## Remarks

When the TEXTAREA_WORDWRAP style is used whitespace characters may be optimized for faster layout calculation.

## Example

![](https://github.com/Leadwerks/Documentation/raw/master/Images/CreateTextArea.png)

```lua
-- Get the displays
local displays = GetDisplays();

-- Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 640, 480, displays[1], WINDOW_TITLEBAR | WINDOW_RESIZABLE | WINDOW_CENTER);

-- Create User Interface
local ui = CreateInterface(window);

-- Create widget
local sz = ui.background:ClientSize();
local textarea = CreateTextArea(10, 10, sz.x - 20, sz.y - 20, ui.background, TEXTAREA_WORDWRAP);

local s = [[
Night was falling now, and as I recalled what Akeley had written me about those earlier nights \
I shuddered to think there would be no moon. Nor did I like the way the farmhouse nestled in the lee of that\
colossal forested slope leading up to the Dark Mountain’s unvisited crest. With Akeley’s permission I lighted a small oil lamp,\
turned it low, and set it on a distant bookcase beside the ghostly bust of Milton; but afterward I was sorry I had done so, for \
it made my host’s strained, immobile face and listless hands look damnably abnormal and corpselike. He seemed half-incapable of motion, \
though I saw him nod stiffly once in a while.]]

textarea:SetText(s);
textarea:SetLayout(1,1,1,1);

while true do
    local ev = WaitEvent();
    if ev.id == EVENT_WINDOWCLOSE then
        return 0;
    end
end
```
