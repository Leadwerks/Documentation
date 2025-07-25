# Entity:GetQuaternion

This method retrieves the entity rotation as a quaternion.

## Syntax

- [xQuat](xQuat.md) **GetQuaternion**()
- [xQuat](xQuat.md) **GetQuaternion**(boolean global)

| Parameter | Description |
|---|---|
| global | If set to `false`, the rotation relative to the parent is returned. If not provided or set to `true`, the rotation in world space is returned. |

## Returns

Returns the entity rotation as a quaternion.
