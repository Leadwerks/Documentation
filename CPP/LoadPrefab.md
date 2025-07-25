# LoadPrefab

This function loads an entity from a prefab file.

## Syntax

- shared_ptr<[Entity](Entity.md)> **LoadPrefab**(shared_ptr<[World](World.md)> world, const [WString](WString)& path, const LoadFlags flags = LOAD_DEFAULT, shared_ptr<[Object](Object.md)> extra = nullptr);

| Parameter | Description |
|---|---|
| world | world to create the entity in |
| path | file path of the file to load | 
| flags | loading flags |
| extra | extra object that will be passed to [Component::Load](Component.md) calls |

## Returns

The function returns the top-level entity in the prefab file, or NULL if the prefab was not loaded.
