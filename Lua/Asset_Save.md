# Asset:Save

This method saves the object to a file.

## Syntax

- boolean **Save**([string](https://www.lua.org/manual/5.4/manual.html#6.4) path)
- boolean **Save**([string](https://www.lua.org/manual/5.4/manual.html#6.4) path, number flags)

| Parameter | Description |
|---|---|
| path | string representing the file path to save to. |
| flags | optional save flags |

## Returns

Returns true if saving is supported for this object type, and if the object was successfully saved, otherwise false is returned.

## Example

```lua
--Load an asset
local pixmap = LoadPixmap("https://github.com/Leadwerks/Documentation/raw/master/Assets/Materials/Brick/brickwall01.dds")

--Save the asset
local path = GetPath(PATH_DOCUMENTS) .. "/temp.dds"
pixmap:Save(path)

--Open the file
RunFile(path)
```
