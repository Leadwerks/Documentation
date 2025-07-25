# CreateCone

This function creates a new cone model with a physics collider.

## Syntax

- [Model](Model.md) **CreateCone**([World](World.md) world)
- [Model](Model.md) **CreateCone**([World](World.md) world, number radius = 0.5, number height = 1.0)
- [Model](Model.md) **CreateCone**([World](World.md) world, number radius = 0.5, number height = 1.0, number sides = 16)
- [Model](Model.md) **CreateCone**([World](World.md) world, number radius = 0.5, number height = 1.0, number sides = 16, number heightsegs = 1, number capsegs = 1)

| Parameter | Description |
|--|--|
| world | world to create the mdoel in |
| radius | cone radius |
| height | cone height |
| sides | number of sides |
| heightsegs | number of segments along the Y axis |
| capsegs | number of end cap subdivisions |

## Returns 

Returns a new model.
