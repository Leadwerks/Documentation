# Widget:GetSize

This method returns the dimensions of the widget. To retrieve the area inside the widget excluding any padding, use the [ClientSize](Widget_ClientSize.md) method.

## Syntax

- [iVec2](iVec2) **GetSize**()

## Returns

Returns the widget size.

## Example

```lua
--Get the displays
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[1], WINDOW_TITLEBAR | WINDOW_RESIZABLE)

--Create User Interface
local ui = CreateInterface(window)
local sz = ui.background:ClientSize()

--Create widget
local panel = CreatePanel(50, 50, sz.x - 100, sz.y - 100, ui.background, PANEL_BORDER)
panel:SetLayout(1, 1, 1, 1)

sz = panel:ClientSize()
local label = CreateLabel(sz.x .. " x " .. sz.y, 0, 0, sz.x, sz.y, panel, LABEL_CENTER | LABEL_MIDDLE)
label:SetLayout(1, 1, 1, 1)

while true do
    local ev = WaitEvent()
    if ev.id == EVENT_WINDOWCLOSE then
        return 0
    elseif ev.id == EVENT_WINDOWSIZE then
        sz = panel:GetSize()
        label:SetText(sz.x .. " x " .. sz.y)
    end
end
```
