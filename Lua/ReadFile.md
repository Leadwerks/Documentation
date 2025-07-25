# ReadFile

This function loads a file from a path and returns a stream.

## Syntax

- [Stream](Stream.md) **ReadFile**([string](https://www.lua.org/manual/5.4/manual.html#6.4) path)
- [Stream](Stream.md) **ReadFile**([string](https://www.lua.org/manual/5.4/manual.html#6.4) path, number flags)

| Parameter | Descriptio   |
|--|--|
| path | file name or URL to load |
| flags | optional load settings |

## Returns

Returns a new [Stream](Stream.md) object If the file was successfully read, otherwise `nil` is returned.

## Example

```lua
local path = GetPath(PATH_DOCUMENTS) .. "/temp.txt";

--Write a new file
local stream = WriteFile(path);
if stream == nil then
    Print("Failed to write file.");
    return
end

stream:WriteLine("Hello, world!");
stream:Close();

stream = ReadFile(path);
Print(stream:ReadLine());
```
