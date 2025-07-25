# RequestDir

This function displays a file dialog and lets the user select a folder.

## Syntax

- [string](https://www.lua.org/manual/5.4/manual.html#6.4) **RequestDir**()
- [string](https://www.lua.org/manual/5.4/manual.html#6.4) **RequestDir**([string](https://www.lua.org/manual/5.4/manual.html#6.4) title)
- [string](https://www.lua.org/manual/5.4/manual.html#6.4) **RequestDir**([string](https://www.lua.org/manual/5.4/manual.html#6.4) title, [string](https://www.lua.org/manual/5.4/manual.html#6.4) dir)

## Example

```lua
local file = RequestDir("Open Folder")
Print(file)
```
