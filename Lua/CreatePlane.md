# CreatePlane

This function creates a new model consisting of a single rectangle.

## Syntax

- [Model](Model.md) **CreatePlane**([World](World.md) world)
- [Model](Model.md) **CreatePlane**([World](World.md) world, number width = 1, number height = 1)
- [Model](Model.md) **CreatePlane**([World](World.md) world, number width = 1, number height = 1, number xsegs= 1, number ysegs = 1)
- [Model](Model.md) **CreatePlane**([World](World.md) world, number width = 1, number height = 1, number xsegs= 1, number ysegs = 1, number type = MESH_TRIANGLES)

| Parameter | Description |
|---|---|
| world | world to create the model in |
| width, height | plane dimensions |
| xsegs, ysegs | mesh subdivision |
| type | can be MESH_TRIANGLES or MESH_QUADS |

## Returns

Returns a new model.
