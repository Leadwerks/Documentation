# Window:GetMousePosition

This method returns the mouse position relative to the window, in integer screen coordinates.

## Syntax

- [iVec3](iVec3.md) **GetMousePosition**()

## Returns

Returns the mouse screen position in the x and y components of the vector, and the mouse wheel position in the z component.

## Example

```lua
--Get the displays
local displays = GetDisplays()

--Create window
local window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[1])

--Create user interface
local ui = CreateInterface(window)

--Display window position
local sz = ui.background:ClientSize()
local label = CreateLabel("", 0, 0, sz.x, sz.y, ui.background, LABEL_CENTER | LABEL_MIDDLE)
label:SetLayout(1, 1, 1, 1)

local pos = window:GetMousePosition()
label:SetText("Mouse position: " .. tostring(pos.x) .. " x " .. tostring(pos.y))

while true do
    local ev = WaitEvent()
    if ev.id == EVENT_MOUSEMOVE then
        pos = window:GetMousePosition()
        label:SetText("Mouse position: " .. tostring(pos.x) .. " x " .. tostring(pos.y))
    elseif ev.id == EVENT_WINDOWCLOSE then
        break
    end
end
```
