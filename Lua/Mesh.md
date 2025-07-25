# Mesh

Base class: [Object](Object.md)

The mesh class is a collection of vertices and polygons that form visible surfaces.

| Property | Type | Description |
| --- | --- | --- |
| bounds | [Aabb](Aabb.md) | read-only mesh bounding box |
| extra | [Object](Object.md) | user-defined object |
| material | [Material](Material.md) | read-only mesh material |
| materials | [Material](Material.md)[4] | read-only mesh materials array |
| name | [string](https://www.lua.org/manual/5.4/manual.html#6.4) | user-defined name |
| type | number | read-only mesh primitive type |
| [AddPrimitive](Mesh_AddPrimitive.md) | Method | adds a new polygon to the mesh |
| [AddVertex](Mesh_AddVertex.md) | Method | adds a new vertex to the mesh |
| [Copy](Mesh_Copy.md) | Method | makes a copy of the mesh |
| [CountPrimitives](Mesh_CountPrimitives.md) | Method | returns the number of mesh primitives |
| [CountVertices](Mesh_CountVertices.md) | Method | returns the number of mesh vertices |
| [GetPrimitiveAttributes](Mesh_GetPrimitiveAttributes.md) | Method | gets attributes of a single primitive |
| [GetRenderLayers](Mesh_GetRenderLayers.md) | Method | gets the mesh render layers |
| [GetSkinned](Mesh_GetSkinned.md) | Method | gets the mesh render layers |
| [GetVertexColor](Mesh_GetVertexColor.md) | Method | gets the color of a vertex |
| [GetVertexPosition](Mesh_GetVertexPosition.md) | Method | gets the position of a vertex |
| [GetVertexNormal](Mesh_GetVertexNormal.md) | Method | gets the normal of a vertex |
| [GetVertexTexCoords](Mesh_GetVertexTexCoords.md) | Method | gets the texture coordinates of a vertex |
| [Modify](Mesh_Modify.md) | Method | batch modify vertices and indices |
| [Recenter](Mesh_Recenter.md) | Method | recenters a mesh along one or more axes |
| [Rotate](Mesh_Rotate.md) | Method | rotates a mesh |
| [Scale](Mesh_Scale.md) | Method | scales a mesh |
| [SetMaterial](Mesh_SetMaterial.md) | Method | sets the mesh material |
| [SetRenderLayers](Mesh_SetRenderLayers.md) | Method | sets the mesh render layers |
| [SetSkinned](Mesh_SetSkinned.md) | Method | enables or disables mesh skinning |
| [SetVertexColor](Mesh_SetVertexColor.md) | Method | sets the position of a vertex |
| [SetVertexPosition](Mesh_SetVertexPosition.md) | Method | sets the position of a vertex |
| [SetVertexNormal](Mesh_SetVertexNormal.md) | Method | sets the normal of a vertex  |
| [SetVertexTexCoords](Mesh_SetVertexTexCoords.md) | Method | sets the texture coordinates of one vertex |
| [Transform](Mesh_Transform.md) | Method | transforms a mesh |
| [Translate](Mesh_Translate.md) | Method | translates a mesh |
| [UpdateBounds](Mesh_UpdateBounds.md) | Method | updates the mesh bounding box |
| [UpdateNormals](Mesh_UpdateNormals.md) | Method | calculates new mesh normals |
| [UpdateTangents](Mesh_UpdateTangents.md) | Method | updates the mesh tangents |
| [CreateMesh](CreateMesh.md) | Function | creates a new mesh object |
