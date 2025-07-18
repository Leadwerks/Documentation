# Command

This function allows you to interact with the operating system terminal or console. This can be used to perform low-level system actions.

## Syntax

- number **Command**([string](https://www.lua.org/manual/5.4/manual.html#6.4) command, [Stream](Stream.md) stream = nil)

Parameter | Description
---|---
command | command to execute
stream | optional stream for capturing printed output

## Returns

Returns the result of the command.

## Remarks

On the Windows operating system the command output will be piped to a file stored in the system "ProgramData/Leadwerks" directory. This file should be deleted if the command output contains any sensitive information.

## Example

```lua
local stream = CreateBufferStream()
Command("systeminfo | findstr /B /C:\"OS Name\"", stream)

while not stream:Eof() do
    Print(stream:ReadLine())
end
```
