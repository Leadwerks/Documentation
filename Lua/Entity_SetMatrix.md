# Entity:SetMatrix

This method sets the entity 4x4 matrix, which describes its position, rotation, and scale in global or local space.

## Syntax

- **SetMatrix**([xMat4](xMat4.md) matrix)
- **SetMatrix**([xMat4](xMat4.md) matrix, boolean global)

| Parameter | Description |
|---|---|
| matrix | the 4x4 matrix to set |
| global | if true world space will be used, otherwise the entity's local space will be used |
