# Camera::WorldToScreen

This method projects a 3D position onto 2D screen space.

## Syntax

- [Vec3](Vec3.md) **WorldToScreen**(const [Vec3](Vec3.md)& point, shared_ptr<[Framebuffer](Framebuffer.md)\> framebuffer)

| Parameter | Description |
|---|---|
| point | position in global space |
| framebuffer | framebuffer to test with |

## Returns

Returns a screen coordinate with the distance in front of the camera stored in the Z component.
