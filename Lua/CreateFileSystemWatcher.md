# CreateFileSystemWatcher

This function can be used to create an object that monitors a specified directory for changes.

## Syntax

- [FileSystemWatcher](FileSystemWatcher.md) **CreateFileSystemWatcher**([string](https://www.lua.org/manual/5.4/manual.html#6.4) path, boolean recursive = true)

| Parameter | Description |
|---|---|
| path | path to folder to watch |
| recursive | set to true to detect changes to the subdirectory |

## Returns

Returns a new FileSystemWatcher object if the specified directory exists, otherwise NULL is returned.

## Remarks

Once the FileSystemWatcher object is created, it will monitor the directory to detect changes. When changes occur an event will be emitted. The event ID will be one of the following
- EVENT_FILECREATE
- EVENT_FILEDELETE
- EVENT_FILERENAME
- EVENT_FILECHANGE

## Example

```lua
-- This example demonstrates use of a FileSystemWatcher to allow dynamic asset reloading.
-- Run the example and modify the image file in a paint program to see your changes appear as the program is running.

-- Get the primary display
local displaylist = GetDisplays()
local display = displaylist[1]

-- Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, display, WINDOW_TITLEBAR | WINDOW_CENTER)

-- Download the texture file
local path = GetPath(PATH_DOCUMENTS) .. "/Temp"
CreateDir(path)
CopyFile("https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets/Materials/Ground/dirt01.jpg", path .. "/dirt01.jpg")
OpenDir(path .. "/dirt01.jpg")

-- Create FileSystemWatcher to detect changes to files
local watcher = CreateFileSystemWatcher(path)

local ui = CreateInterface(window)
local panel = CreatePanel(0, 0, window:ClientSize().x, window:ClientSize().y, ui.background)
local pixmap = LoadPixmap(path .. "/dirt01.jpg")
panel:SetPixmap(pixmap)

-- Main loop
while window:Closed() == false do

    -- Check for file change events
    local e = WaitEvent()

    -- Look for file change or create events. Some programs delete the file and then recreate it when they save.
    if e.id == EVENT_FILECHANGE or e.id == EVENT_FILECREATE then

        -- Look for a loaded asset with this file path
        local asset = FindCachedAsset(e.text)
        if asset then
            -- Reload the modified asset
            asset:Reload()
            panel:Redraw()
        end
    end
end
```
