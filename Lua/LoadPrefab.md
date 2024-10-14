# LoadPrefab

This function loads an entity from a prefab file.

## Syntax

- [Entity](Entity.md) **LoadPrefab**([World](World.md) world, string path, number flags = LOAD_DEFAULT, [Object](Object.md) extra = nil)

| Parameter | Description |
|---|---|
| world | world to create the entity in |
| path | file path of the file to load | 
| flags | loading flags |
| extra | extra object that will be passed to [Component::Load](Component.md) calls |
