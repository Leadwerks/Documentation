# Pixmap:Sample

This method retrieves a pixel sample using bilinear filtering to smoothly interpolate between pixels. This can also be used to read color values from high-precision pixel formats.

## Syntax

- [Vec4](Vec4.md) **Sample**(number u, number v)
- [Vec4](Vec4.md) **Sample**([Vec2](Vec2.md) coords)
- [Vec4](Vec4.md) **Sample**([iVec2](iVec2.md) coords)

| Parameter | Description |
|---|---|
| (u, v), coords | sample coordinate or pixel |

## Returns 

Returns a bilinear filtered pixel sample at the specified coordinate.

If the pixmap uses a compressed format Vec4(0) will be returned.

## Remarks

Float coordinates will be clamped to the range 0.0-1.0.

If coord is an [iVec2](iVec2.md) bilinear filtering will not be used.
