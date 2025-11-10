# World::SetCollision

This method can be used to set custom collision responses between different collision types.

## Syntax

- void **SetCollision**(const int type1, const int type2, const COLLISION response)

| Parameter | Description |
|---|---|
| type1 | one of the collision types in the collision |
| type2 | the other collition type in the collision |
| response | the collision response, can be COLLISION_NONE, COLLISION_COLLIDE, or COLLISION_DETECT |

## Remarks

The collision types can be any integer value or predefined collision type:
- COLLISION_NONE
- COLLISION_PROP
- COLLISION_SCENE
- COLLISION_PLAYER
- COLLISION_TRIGGER
- COLLISION_DEBRIS
- COLLISION_PROJECTILE

The table below shows the default collision responses the engine defines for each new world:

| Type 1 | Type 2 | Response |
|---|---|---|
| COLLISION_PROP | COLLISION_PROP | COLLISION_COLLIDE |
| COLLISION_PROP | COLLISION_SCENE | COLLISION_COLLIDE |
| COLLISION_DEBRIS | COLLISION_SCENE | COLLISION_COLLIDE |
| COLLISION_DEBRIS | COLLISION_PROP | COLLISION_COLLIDE |
| COLLISION_SCENE | COLLISION_PLAYER | COLLISION_COLLIDE |
| COLLISION_PROP | COLLISION_PLAYER | COLLISION_COLLIDE |
| COLLISION_PLAYER | COLLISION_PLAYER | COLLISION_COLLIDE |
| COLLISION_SCENE | COLLISION_PROJECTILE | COLLISION_COLLIDE |
| COLLISION_PROP | COLLISION_PROJECTILE | COLLISION_COLLIDE |
| COLLISION_PLAYER | COLLISION_TRIGGER | COLLISION_DETECT |
