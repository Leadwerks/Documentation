# Entity::CollisionTest

This method performs a static or swept collision test between this entity and the specified entity, or all objects in the nearby vicinity.

- std::vector<[Collision](Collision.md)> **CollisionTest**(shared_ptr<[Entity](Entity.md)> entity, int hits = 1)
- std::vector<[Collision](Collision.md)> **CollisionTest**(int hits = 1)
- std::vector<[Collision](Collision.md)> **CollisionTest**([Vec3](Vec3.md) position, const [Quat](Quat.md) rotation, int hits = 1)

| Parameter | Description |
|---|---|
| entity | single entity to test collision with |
| position | for a swept collision test, the final position of this entity |
| rotation | for a swept collision test, the final rotation of this entity |
| hits | the maximum number of collisions that will be allowed to occur before the routine stops checking |

## Returns

Returns a list of all collisions that are detected.
