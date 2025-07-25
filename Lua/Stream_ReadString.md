# Stream:ReadString

This method reads a string from the stream at the current position. The string will be terminated by either the null character, the end of the file, or the maximum string length, whichever comes first.

## Syntax

- [string](https://www.lua.org/manual/5.4/manual.html#6.4) **ReadString**()
- [string](https://www.lua.org/manual/5.4/manual.html#6.4) **ReadString**(number maxlength)

| Parameter | Description |
|---|---|
| maxlength | if greater than zero, this is the maximum length of the string that will be read |

## Example

```lua
path = GetPath(PATH_DOCUMENTS) .. "/temp.txt"

-- Write a new file
stream = WriteFile(path)
if stream == nil then
    Print("Failed to write file.")
    return 0
end

stream:writeString("Hello, world!")
stream:close()

stream = ReadFile(path)
Print(stream:readString())
```
