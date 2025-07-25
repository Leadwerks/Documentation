# Model::AddMesh

This method creates or inserts an existing mesh on the model.

## Syntax

- [Mesh](Mesh.md) **AddMesh**()
- [Mesh](Mesh.md) **AddMesh**(number type = MESH_TRIANGLES)
- [Mesh](Mesh.md) **AddMesh**(number type = MESH_TRIANGLES, number lod)
- [Mesh](Mesh.md) **AddMesh**([Mesh](Mesh.md) mesh)
- [Mesh](Mesh.md) **AddMesh**([Mesh](Mesh.md) mesh, number lod)

| Parameter | Description |
|---|---|
| type | primitive type, can be MESH_POINTS, MESH_LINES, MESH_TRIANGLES, or MESH_QUADS |
| mesh | adds an existing mesh to the model |
| lod | mesh detail level |

## Returns

Returns the added mesh.
