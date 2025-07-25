# LoadPrefab

This function loads an entity from a prefab file.

## Syntax

- [Entity](Entity.md) **LoadPrefab**([World](World.md) world, string path)
- [Entity](Entity.md) **LoadPrefab**([World](World.md) world, string path, number flags)
- [Entity](Entity.md) **LoadPrefab**([World](World.md) world, string path, number flags, [Object](Object.md) extra)

| Parameter | Description |
|---|---|
| world | world to create the entity in |
| path | file path of the file to load | 
| flags | loading flags |
| extra | extra object that will be passed to [Component::Load](Component.md) calls |

## Returns

The function returns the top-level entity in the prefab file, or nil if the prefab was not loaded.
