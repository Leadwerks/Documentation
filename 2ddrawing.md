# 2D Drawing

There is a long-standing convention in computer graphics that considers the upper-left corner of the screen to be position (0, 0). Moving to the right of the screen increases the X coordinate, as expected, but in screen coordinates moving down the screen also increases the Y coordinate. This is the opposite of a 3D coordinate system where the positive Y direction points up. This is probably because text in most languages reads from the top down, so if you are designing a user interface it makes sense to start at the top-left corner.

The diagram below shows the coordinates at the corners, halfway along the edges, and in the center of a 1280 x 720 screen.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/screencoords.png?raw=true)

