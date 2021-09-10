# World::GetCollisionResponse

This method can be used to get the collision response between different collision types.

- [CollisionResponse](Constants.md#CollisionResponse) **GetCollisionResponse**(const [CollisionType](Constants.md#CollisionType) type1, const [CollisionType](Constants.md#CollisionType) type2)

| Parameter | Description |
|---|---|
| type1 | one of the collision types in the collision |
| type2 | the other collition type in the collision |

## Returns

This can return COLLISIONRESPONSE_NONE, COLLISIONRESPONSE_COLLIDE, or COLLISIONRESPONSE_DETECT.
