# World:GetEntitiesInArea

This method efficiently retrieves all entities that intersect the specified bounding box.

## Syntax

- [Entity](Entity.md)[] **GetEntitiesInArea**([xVec3](xVec3.md) minbounds, [xVec3](xVec3.md) maxbounds)

Parameter | Description
---|---
minbounds | lower bounds of area
maxbounds | upper bounds of area

## Returns

Returns an array of all top-level entities that intersect the specified bounding box, or have entities in their sub-hierarchy that intersect the bounding box.
