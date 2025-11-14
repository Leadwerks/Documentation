# Entity::GetVisible

This method performs a line of sight test to determine if two entities can see each other.

## Syntax

- bool **GetVisible**(shared_ptr<[Entity](Entity.md)> entity)

| Parameter | Description |
|---|---|
| entity | entity to test the visibility of |

## Returns

Returns true if the two entities have a clear line of sight between their positions, otherwise false is returned.

## Remarks

This method performs a raycast between the positions of the two entities. Neither entity will block the raycast. If you want more control over the raycast, see the [World::Pick](World_Pick.md) command.
