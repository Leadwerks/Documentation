# LoadDir

This function loads the contents of a directory and returns an array of files.

## Syntax

- string[] **LoadDir**(string path)
- string[] **LoadDir**(string path, boolean packages)

| Parameter | Description |
|---|---|
| path | file path to load |
| packages | if true any loaded packages will be checked for the specified folder after the file system |

## Returns

Returns an array of file names found within the directory. The array will be empty if the specified path contains no files, or if the folder contains no files.
 
 ## Example

```lua
local path = CurrentDir()

local dir = LoadDir(path)
for _, file in ipairs(dir) do
    Print("Name: " .. file)
    Print("Type: " .. tostring(FileType(file)))
    Print("Time: " .. tostring(FileTime(file)))
    Print("Size: " .. tostring(FileSize(file)))
    Print("Hidden: " .. tostring(FileHidden(file)))
    Print("")
end
```
