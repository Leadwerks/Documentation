# Entity::GetQuaternion

This method retrieves the entity rotation as a quaternion.

## Syntax

- [xQuat](xQuat.md) **GetQuaternion**(const bool global = false)

| Parameter | Description |
|---|---|
| global | if set to false, the rotation relative to the parent is returned, otherwise the rotation in world space is returned |

## Returns

Returns the entity rotation as a quaternion.
