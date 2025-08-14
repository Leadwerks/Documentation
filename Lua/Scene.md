# Scene

Base class: [Object](Object.md)

This class stores all the objects in a game level.

| Property | Type | Description |
|---|---|---|
| entities | [Entity](Entity.md)[] | array of all top-level entities in the map |
| path | string | read-only file path |
| [GetEntity](Scene_GetEntity.md) | Method | retrieves an entity using a UUID |
| [LoadScene](LoadScene.md) | Function | loads a map from a file |
