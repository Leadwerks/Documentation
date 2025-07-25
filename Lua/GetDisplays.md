# GetDisplays

This function retrieves a list of hardware monitors that are currently in use.

## Syntax

- [Display](Display.md)[] **GetDisplays**()

## Returns

Returns a table of all displays currently in use, with the primary display at index 1.

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
        Print("     " .. tostring(n) .. ": " .. tostring(gfxmodes[n].x) .. ", " .. tostring(gfxmodes[n].y .. ", " .. tostring(gfxmodes[n].z)))
    end
end
```
