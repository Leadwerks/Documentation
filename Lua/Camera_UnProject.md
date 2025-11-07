# Camera:ScreenToWorld

This method projects 2D screen coordinate to a point in world space.

## Syntax

- [Vec3](Vec3.md) **ScreenToWorld**([Vec3](Vec3.md) coord, [Framebuffer](Framebuffer.md) framebuffer)

| Parameter | Description |
|---|---|
| coord | screen coordinate, plus distance in front of camera stored in the Z component |
| framebuffer | framebuffer to test with |

## Returns

Returns a 3D position in global space.
