# Model::Save

This method saves the model to a file, in [glTF](https://www.khronos.org/gltf/) or Wavefront OBJ format.

## Syntax

- boolean **Save**([string](https://www.lua.org/manual/5.4/manual.html#6.4) path)
- boolean **Save**([string](https://www.lua.org/manual/5.4/manual.html#6.4) path, number flags)

| Parameter | Description |
|---|---|
| path | file path to save |
| flags | optional save flags |

## Returns

Returns true if the model is successfully saved, otherwise false is returned.

## Example

```lua
-- Create model
local model = CreateBox(nil)

-- Save to file
if model:Save("box.obj") then
    -- Show file
    OpenDir("box.obj")
end
```
