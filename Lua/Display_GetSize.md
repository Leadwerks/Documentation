# Display:GetSize

This method retrieves the display size.

## Syntax

- [iVec2](iVec2.md) **GetSize**()

## Returns

Returns the display's size, in screen pixels.

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
