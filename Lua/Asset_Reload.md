# Asset:Reload

This method reloads an asset from a file on the disk. If changes were made to the file, they will appear after reloading.

## Syntax

- **Reload**()
- **Reload**(number flags)

| Parameter | Description |
|---|---|
| flags | load flags |

## Returns

If successful, true is returned. Otherwise, false is returned.

## Example

```lua
-- Get the displays
local displays = GetDisplays()

-- Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[1])

-- Create a user interface
local ui = CreateInterface(window)

-- Load an asset
local path = GetPath(PATH_DOCUMENTS) .. "/temp.dds"
if not CopyFile("https://github.com/Leadwerks/Documentation/raw/master/Assets/Materials/Ground/dirt01.dds", path) then
    RuntimeError("Failed to download pixmap.")
end

-- Load the file from the hard drive
local pixmap = LoadPixmap(path)

-- Show the pixmap
ui.root:SetPixmap(pixmap)

local button = CreateButton("Modify Pixmap", 10, 10, 100, 30, ui.root)

while true do
    local ev = WaitEvent()
    if ev.id == EVENT_WIDGETACTION and ev.source == button then
        -- Make a copy of the pixmap, modify it, and overwrite the file
        local pixmap2 = pixmap:Copy():AsPixmap()
        if pixmap2.format ~= TEXTURE_RGBA then
            pixmap2 = pixmap2:Convert(TEXTURE_RGBA)
        end
        local px = Random(0, pixmap.size.x - 1 - 100)
        local py = Random(0, pixmap.size.y - 1 - 100)
        local color = RGBA(Random(255), Random(255), Random(255), 255)
        for x = 0, 99 do
            for y = 0, 99 do
                pixmap2:WritePixel(px + x, py + y, color)
            end
        end
        pixmap2:Save(path)

        -- Reload the pixmap from the file
        pixmap:Reload()

        -- Redraw the panel
        ui.root:Paint()
    elseif ev.id == EVENT_WINDOWCLOSE then
        return 0
    end
end
```
