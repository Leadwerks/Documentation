# Scene

Base class: [Object](Object.md)

This class stores all the objects in a game level.

| Property | Type | Description |
|---|---|---|
| entities | vector< shared_ptr<[Entity](Entity.md)\> \> | array of all top-level entities in the map |
| path | [WString](WString.md) | file path |
| [LoadScene](LoadScene.md) | Function | loads a map from a file |
