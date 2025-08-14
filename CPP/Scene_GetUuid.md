# Scene::GetEntity

This method retrieves an entity from the scene, given the entity's UUID.

## Syntax

shared_ptr<[Entity](Entity.md)\> **GetEntity**([String](String.md) uuid)

| Paramater | Description |
|---|---|
| uuid | the entity UUID to search for, retrieved with [Entity::GetUuid](Entity_GetUuid.md) |

## Returns

If an entity with a matching UUID is present in the scene it is returned, otherwise NULL is retuened.
