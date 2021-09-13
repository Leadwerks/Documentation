# Mesh::Rotate

This method rotates all vertex positions by the specified rotation.

## Syntax 

- void **Rotate**(const [Quat](Quat.md) rotation)
- void **Rotate**(const [Vec3](Vec3.md) rotation)
- void **Rotate**(const float pitch, const float yaw, const float roll)

| Parameter | Description |
|---|---|
| rotation, (pitch, yaw, roll) | rotation of mesh vertices |

## Remarks

A call to [Mesh::Finalize](Mesh_Finalize.md) must be made before the results of this command are visible.
