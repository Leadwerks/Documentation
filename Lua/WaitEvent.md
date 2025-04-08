## WaitEvent

This function waits until an event is available in the event queue and returns the oldest event.

## Syntax

[Event](Event) **WaitEvent**()

## Returns

Returns the oldest event in the queue.

## Remarks

Use [PeekEvent](PeekEvent.md) to check if any events are available before calling this function, if you don't want the application to pause.

## Example

```lua
--Get the displays
local displays = GetDisplays()

--Create window
local window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[1])

--Create user interface
local ui = CreateInterface(window)

while true do
    local ev = WaitEvent()
    if ev.id == EVENT_WINDOWCLOSE then
        if ev.source == window then
            return 0
        end
    end
end
```
