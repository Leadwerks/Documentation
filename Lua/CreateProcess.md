# CreateProcess

This function launches an external executable and returns a handle that can be used for interaction.

## Syntax

- [Process](Process.md) **CreateProcess**([string](https://www.lua.org/manual/5.4/manual.html#6.1) path)
- [Process](Process.md) **CreateProcess**([string](https://www.lua.org/manual/5.4/manual.html#6.1) path, [string](https://www.lua.org/manual/5.4/manual.html#6.1) arguments)

| Parameter | Description |
|---|---|
| path | file path of the executable to launch |
| arguments | command-line arguments to pass to the program |

## Returns

If the program was launched, a new process is returned. Otherwise, nil is returned.

## Example

```lua
Print("Launching process")
local proc = CreateProcess("C:/Windows/notepad.exe")
Print("Process running")
local exitcode = proc:Wait()
Print("Process ended (" .. tostring(exitcode) .. ")")
```
