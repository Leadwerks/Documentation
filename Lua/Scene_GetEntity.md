# Scene:GetEntity

This method retrieves an entity from the scene, given the entity's UUID.

## Syntax

[Entity](Entity.md) **GetEntity**(string uuid)

| Paramater | Description |
|---|---|
| uuid | the entity UUID to search for, retrieved with [Entity:GetUuid](Entity_GetUuid.md) |

## Returns

If an entity with a matching UUID is present in the scene it is returned, otherwise nil is retuened.

## Remarks

The entity UUID is visible in the general properties, in the editor. This allows you to retrieve a specific entity from the scene, in a way that is more reliable than retrieving by name or by tags.
