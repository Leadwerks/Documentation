# 2D Drawing



## Screen Coodinates

There is a long-standing convention in computer graphics that considers the upper-left corner of the screen to be position (0, 0). Moving to the right of the screen increases the X coordinate, as expected, but in screen coordinates moving down the screen also increases the Y coordinate. This is the opposite of a 3D coordinate system where the positive Y direction points up. This is probably because text in most languages reads from the top down, so if you are designing a user interface it makes sense to start at the top-left corner.

The diagram below shows the coordinates at the corners, halfway along the edges, and in the center of a 1280 x 720 screen.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/screencoords.png?raw=true)

We may work with windows of different sizes, so rather than hard-coding the coordinates, we can always get screen coordinates for a window of any size with the following formulas:

| Coordinate | Location |
|--|--|
| 0, 0 | top-left of the screen |
| framebuffer.size.x, 0 | top-right of the screen |
| framebuffer.size.x / 2, framebuffer.size.y / 2 | center of the screen |
| 0, framebuffer.size.y | bottom-left of the screen |
| framebuffer.size.x, framebuffer.size.y | bottom-right of the screen |

## Tile Orientation

By default, a tile's position is oriented around its upper-left corner. This way if you position a tile at (0, 0) it will be visible in the top-left corner of the screen.
