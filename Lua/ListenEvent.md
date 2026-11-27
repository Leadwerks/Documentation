# ListenEvent

This function sets a callback function that will be executed when an event occurs.

## Syntax

- **ListenEvent**(number id, [Object](Object.md) source, function callback, [Object](Object.md) extra = nil)

| Parameter | Description |
|---|---|
| id | event ID to listen for, or EVENT_NONE to listen for all events |
| source | event source to listen for, or nil for events emitted from any source |
| callback | function to call when event is triggered |
| extra | extra object to pass to the callback function |

## Remarks

Internally, this function will store a weak pointer to the event source and a shared pointer to the extra field.

If the callback function returns false no more callbacks will be executed and no event will be added to the event queue.

## Example

The first example shows another way to quit the program when the window is closed:

```lua
-- Define the EventCallback function
local function EventCallback(ev, extra)
    os.exit(0)
end

-- Get the displays
local displays = GetDisplays()

-- Create window
local window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[1])

-- Create user interface
local ui = CreateInterface(window)

-- Listen for the window close event
ListenEvent(EVENT_WINDOWCLOSE, window, EventCallback)

while true do
    WaitEvent()
end
```

The example below demonstrates how an event listener can be used for custom resizing behavior:

```lua
function EventCallback(ev, extra)
    local panel = Widget(extra)
    local sz = panel:GetParent():ClientSize()
    panel:SetShape(50, 50, sz.x - 100, sz.y - 100)
    panel:SetText(tostring(sz.x) .. " x " .. tostring(sz.y))
    return true
end

--Get the displays
local displays = GetDisplays()

--Create window
local window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[1], WINDOW_TITLEBAR | WINDOW_RESIZABLE | WINDOW_CENTER)

--Create user interface
local ui = CreateInterface(window)

local sz = ui.background:ClientSize()
local panel = CreatePanel(50, 50, sz.x - 100, sz.y - 100, ui.background)
panel:SetColor(0, 0, 0)

--Comment this line out to see why it is needed. ;)
ListenEvent(EVENT_WINDOWSIZE, window, EventCallback, panel)

while true do
    local ev = WaitEvent()
    if ev.id == EVENT_WINDOWCLOSE then
        if ev.source == window then
            return 0
        end
    elseif ev.id == EVENT_WINDOWSIZE then
        sz = panel:GetParent():ClientSize()
        panel:SetShape(50, 50, sz.x - 100, sz.y - 100)
        panel:SetText(tostring(sz.x) .. " x " .. tostring(sz.y))
    end
end
```
