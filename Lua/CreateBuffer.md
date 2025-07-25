# CreateBuffer

This function creates a new memory buffer object.

## Syntax

- [Buffer](Buffer.md) **CreateBuffer**(number size)

| Paramater | Description |
|---|---|
| size | size of the allocated memory block |

## Returns

If the memory is allocated successfully, a new buffer object is returned. Otherwise, `nil` is returned.

## Example

```lua
--Create a buffer
local buffer = CreateBuffer(20)

--Poke data to the buffer
for n = 0, buffer:GetSize() - 1 do
	buffer:PokeByte(n, n + 1)
end

--Peek and display data from the buffer
for n = 0, buffer:GetSize() - 1 do
	Print(buffer:PeekByte(n))
end
```
