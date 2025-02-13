# Entity::Turn

This method turns an entity. This will produce smooth rotation free from Gimbal lock problems that can occur when rotations are manually specified.

## Syntax

- void **Turn**(const [xQuat](xQuat.md)& rotation, const bool global = false)
- void **Turn**(const [xVec3](xVec3.md)& rotation, const bool global = false)
- void **Turn**(const dFloat pitch, const dFloat yaw, const dFloat roll, const bool global = false)

| Parameter | Description |
| --- | --- |
| rotation, (pitch, yaw, roll) | rotation to apply |
| global | if set to true global space is used, otherwise local space is used |
