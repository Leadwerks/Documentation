# World:GetTaggedEntities

This method retrieves all entities in the world with the specified tag.

## Syntax

- [Entity](Entity.md)[] **GetTaggedEntities**([string](https://www.lua.org/manual/5.4/manual.html#6.4) tag)

| Parameter | Description |
|---|---|
| tag | tag to search for |

## Returns

Returns an array of all entities that use the specified tag.

## Remarks

You can set entity tags with the [Entity:AddTag](Entity_AddTag.md) method.
