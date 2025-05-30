# LoadBuffer

This function loads a buffer from a file.

## Syntax

- [Buffer](Buffer.md) **LoadBuffer**([string](https://www.lua.org/manual/5.4/manual.html#6.4) path, number flags = LOAD_DEFAULT)

| Parameter | Description |
| ----- | ----- |
| path | file name to load |
| flags | optional load settings |

## Returns

Returns the loaded buffer if successful, otherwise NULL is returned.

## Example

```lua
--Create a buffer
local buffer = CreateBuffer(16)
buffer:PokeInt(0, 1)
buffer:PokeInt(4, 2)
buffer:PokeInt(8, 3)
buffer:PokeInt(12, 4)

--Save the buffer
local path = GetPath(PATH_DOCUMENTS) .. "/temp.bin"
if not buffer:Save(path) then
    RuntimeError("Failed to save buffer.")
end

--Load the buffer
buffer = LoadBuffer(path)
if buffer == nil then
    RuntimeError("Failed to load buffer.")
end
DeleteFile(path)

Assert(buffer:GetSize() == 16)
Print(buffer:PeekInt(0))
Print(buffer:PeekInt(4))
Print(buffer:PeekInt(8))
Print(buffer:PeekInt(12))
```
