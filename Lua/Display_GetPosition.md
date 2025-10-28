# Display:GetPosition

This method retrieves the display position on the virtual display.

## Syntax

- [iVec2](iVec2.md) **GetPosition**()

## Returns

Returns the display's position on the bounding virtual display.

## Example

```lua
local displays = GetDisplays()

for k = 1, #displays do
    Print("Display " .. tostring(k) .. ":")
    Print(" Position: " .. tostring(displays[k]:GetPosition().x) .. " x " .. tostring(displays[k]:GetSize().y))
    Print(" Size: " .. tostring(displays[k]:GetSize().x) .. " x " .. tostring(displays[k]:GetSize().y))
    Print(" Scale: " .. tostring(displays[k]:GetScale()))
    Print(" Graphics Modes:")
    local gfxmodes = displays[k].graphicsmodes
    for n = 1, #gfxmodes do
        Print("     " .. tostring(n) .. ": " .. tostring(gfxmodes[n].x) .. ", " .. tostring(gfxmodes[n].y) )
    end
end
```
