# EmitEvent

This function adds an event to the event queue and triggers any callbacks added with the [ListenEvent](ListenEvent.md) function.

## Syntax

- boolean **EmitEvent**([Event](Event.md))
- boolean **EmitEvent**(number id, [Object](Object.md) source, number data)
- boolean **EmitEvent**(number id, [Object](Object.md) source, number data, number x, number y, number width, number height)
- boolean **EmitEvent**(number id, [Object](Object.md) source, number data, number x, number y, number width, number height, [Object](Object.md) extra)
- boolean **EmitEvent**(number id, [Object](Object.md) source, number data, number x, number y, number width, number height, [Object](Object.md) extra, [string](https://www.lua.org/manual/5.4/manual.html#6.4) text)

| Parameter | Description |
| --- | --- |
| event | event to emit |
| id | event ID |
| source | event source |
| data | event data |
| x | X component of event position |
| y | Y component of event position |
| width | X compononent of event size | 
| height | Y component of event size |
| extra | event extra data |
| text | event text |

## Returns

If any event listener callback triggered by this event returns `false`, the function will return `false`, otherwise `true` is returned.

## Remarks

If any event listener callback triggered by this event returns `false`, no further listener callbacks will be called and the event will not be added to the event queue.

## Example

```lua
--Get the displays
local displays = GetDisplays()

--Create window
local window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[1])

--Create user interface
local ui = CreateInterface(window)
local sz = ui.background:ClientSize()
local button = CreateButton("Close window", sz.x / 2 - 75, sz.y / 2 - 15, 150, 30, ui.background)

while true do
    local ev = WaitEvent()
    if ev.id == EVENT_WIDGETACTION then
        if ev.source == button then
            EmitEvent(EVENT_WINDOWCLOSE, window)
        end
    elseif ev.id == EVENT_WINDOWCLOSE then
        if ev.source == window then
            return 0
        end
    end
end
```
