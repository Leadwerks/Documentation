# CreateCylinder

This function creates a new cylinder model with a physics collider.

## Syntax

- shared_ptr<[Model](Model.md)> **CreateCylinder**(shared_ptr<[World](World.md)> world, const float radius = 0.5, const float height = 1.0, const int sides = 16, const int heightsegs = 1, const int capsegs = 1)

| Parameter | Description |
|--|--|
| world | world to create the mdoel in |
| radius | cylinder radius |
| height | cylinder height |
| sides | number of sides |
| heightsegs | number of segments along the Y axis |
| capsegs | number of end cap subdivisions |

## Returns 

Returns a new model.
