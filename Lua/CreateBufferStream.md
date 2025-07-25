# CreateBufferStream

This function creates a new BufferStream object that allows read and writing to a block of memory as if it were a file.

## Syntax
- shared_ptr<[BufferStream](BufferStream.md)\> **CreateBufferStream**()
- shared_ptr<[BufferStream](BufferStream.md)\> **CreateBufferStream**(shared_ptr<[Buffer](Buffer.md)\> data)
- shared_ptr<[BufferStream](BufferStream.md)\> **CreateBufferStream**(shared_ptr<[Buffer](Buffer.md)\> data, const [WString](WString.md)& path)

| Parameter | Description |
| --- | --- |
| data | can be used to specify an existing data buffer for the stream to use |
| path | sets the Stream path member to simulate a file |

## Returns
Returns a new BufferStream object.

## Example

```lua
-- Create a memory buffer and fill in some data
local buffer = CreateBuffer(10 * 4)
for n = 0, 9 do
    buffer:PokeInt(n * 4, n)
end

-- Create a buffer stream
local stream = CreateBufferStream(buffer)

-- Read from the memory buffer as if it were a file
while not stream:Eof() do
    Print(stream:ReadInt())
end
```
