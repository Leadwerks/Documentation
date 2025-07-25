# Process:GetStatus

This method returns the current status of a running process.

## Syntax 

- number Process:**GetStatus**()

## Returns

Returns the process status. This may be PROCESS_RUNNING or PROCESS_FINISHED. The [Process.Close](Process_Close.md) method should be called to close the handle and retrieve the exit code once this method returns PROCESS_FINISHED.

## Example

```lua
apppath = "C:/Windows/notepad.exe"

Print("Launching process")
local proc = CreateProcess(apppath)

Print("Process running")
while proc:GetStatus() == PROCESS_RUNNING do
    Sleep(500)
    Print(".")
end

local exitcode = proc:Close()

Print("Process finished (" .. tostring(exitcode) .. ")")
```
