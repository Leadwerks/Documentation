# CreateTextField

The textfield widget is an editable input box. It will emit a WIDGETACTION event if the text changes and the widget loses the focus or the enter key is pressed. If the READONLY style is used the widget text will not be editable. If the PASSWORD style is used the widget text will appear as a series of dots.

## Syntax

- [Widget](Widget.md) **CreateTextField**(number x, number y, number width, number height, [Widget](Widget.md) parent)
- [Widget](Widget.md) **CreateTextField**(number x, number y, number width, number height, [Widget](Widget.md) parent, number style)

| Parameter | Description |
| --- | --- |
| x | widget X position |
| y | widget Y position |
| width | widget width |
| height | widget height |
| parent | parent widget |
| style | textfield style, can be any combination of TEXTFIELD_DEFAULT, TEXTFIELD_READONLY, TEXTFIELD_PASSWORD, TEXTFIELD_TEXTCHANGEACTIONEVENT, TEXTFIELD_LOSEFOCUSACTIONEVENT, and TEXTFIELD_ENTERKEYACTIONEVENT |

## Remarks

The TEXTFIELD_DEFAULT style flag is equal to TEXTFIELD_LOSEFOCUSACTIONEVENT | TEXTFIELD_ENTERKEYACTIONEVENT.

## Example

![CreateTextField](https://github.com/Leadwerks/Documentation/raw/master/Images/CreateTextField.png)

```lua
--Get the displays
local displays = GetDisplays()

-- Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[1], WINDOW_TITLEBAR | WINDOW_CENTER)

-- Create User Interface
local ui = CreateInterface(window)

-- Create widget
local sz = ui.background:ClientSize()
local textfield = CreateTextField(20, 20, 300, 32, ui.background)
textfield:SetText("Here is some text!")
textfield:SelectText(0, string.len(textfield.text))

while true do
    local ev = WaitEvent()
    if ev.id == EVENT_WIDGETACTION then
        if ev.source == textfield then
            Print(tostring(ev.extra))
        end
    elseif ev.id == EVENT_WINDOWCLOSE then
        return 0
    end
end
```
