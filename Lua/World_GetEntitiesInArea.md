# World:GetEntitiesInArea

This method efficiently retrieves all entities that intersect the specified bounding box.

## Syntax

- [Entity](Entity.md)[] **GetEntitiesInArea**([xVec3](xVec3.md) minbounds, [xVec3](xVec3.md) maxbounds)
- [Entity](Entity.md)[] **GetEntitiesInArea**([xVec3](xVec3.md) minbounds, [xVec3](xVec3.md) maxbounds, string field, string operation, value...)

| Parameter | Description |
| ---|--- |
| minbounds | lower bounds of area |
| maxbounds | upper bounds of area |
| field | the name of a field to check |
| operation | the operation to perform. This can be set to "==", "~=", "<", ">", "<=", or ">=" |
| value | the value to compare the entity field value to. This can be any Lua value. |

## Returns

Returns an array of all top-level entities that intersect the specified bounding box, or have entities in their sub-hierarchy that intersect the bounding box.
