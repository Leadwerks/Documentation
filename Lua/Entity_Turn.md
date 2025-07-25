# Entity:Turn

This method turns an entity. This will produce smooth rotation free from Gimbal lock problems that can occur when rotations are manually specified.

## Syntax

- **Turn**(number pitch, number yaw, number roll)
- **Turn**(number pitch, number yaw, number roll, boolean global)
- **Turn**([xVec3](xVec3.md) rotation)
- **Turn**([xVec3](xVec3.md) rotation, boolean global)
- **Turn**([xQuat](xQuat.md) rotation)
- **Turn**([xQuat](xQuat.md) rotation, boolean global)

| Parameter | Description |
| --- | --- |
| rotation, (pitch, yaw, roll) | rotation to apply |
| global | if set to true global space is used, otherwise local space is used |
