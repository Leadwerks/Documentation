# Mesh:AddVertex

This methods adds a new vertex to the mesh.

## Syntax

- number **AddVertex**(number x, number y, number z)
- number **AddVertex**(number x, number y, number z, number nx, number ny, number nz)
- number **AddVertex**(number x, number y, number z, number nx, number ny, number nz, number u, number v)
- number **AddVertex**(number x, number y, number z, number nx, number ny, number nz, number u, number v, number displacement)
- number **AddVertex**([Vec3](Vec3.md) position)
- number **AddVertex**([Vec3](Vec3.md) position, [Vec3](Vec3.md) normal)
- number **AddVertex**([Vec3](Vec3.md) position, [Vec3](Vec3.md) normal, [Vec2](Vec2.md) texcoords)
- number **AddVertex**([Vec3](Vec3.md) position, [Vec3](Vec3.md) normal, [Vec2](Vec2.md) texcoords, number displacement)

| Parameter | Description |
|---|---|
| position, (x, y, z) | vertex position |
| normal, (nx, ny, nz) | vertex normal |
| texcoords, (u, v) | vertex texture coordinates |
| displacement | maximum tessellation displacement value |

## Returns

Returns the index of the new vertex.

## Remarks

Once a mesh has been submitted to the rendering thread, additional vertices cannot be added to it. This occurs during the first call to [World:Render](World_Render.md) after the mesh is created.
