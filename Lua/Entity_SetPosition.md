# Entity:SetPosition

This method sets the position of an entity in 3-dimensional space, using local or global coordinates.

An entity can be positioned in local or global coordinates. Local coordinates are relative to the entity parent's space. If the entity does not have a parent, local and global coordinates are the same.

The engine uses a left-handed coordinate system. The X axis points to the right, the Y axis points up, and the Z axis points forward.

## Syntax

- **SetPosition**([xVec3](xVec3.md) position)
- **SetPosition**(number x, number y, number z)
- **SetPosition**([xVec3](xVec3.md) position, boolean global)
- **SetPosition**(number x, number y, number z, boolean global)

| Parameter | Description |
| ------ | ------ |
| position, (x, y, z) | The position to set |
| global | Indicates whether the position should be set in global or local space |
