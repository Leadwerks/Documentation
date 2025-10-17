# 3D Space

To convert our 2D grid into a 3D grid, we just need to add one additional axis called Z. Since we can't actually draw a 3D shape on a 2D image, we will draw the Z axis with some perspective, at a 45 degree angle. All coordinates on the 3D grid now have three components: X, Y, and Z. I've also labeled and color-coded the positive and negative directions for each axis. Picture the postive Z axis going into the screen, and the negative Z axis coming out of the screen.

Can you pick out the coordinate (2, 2, 2) on this grid? Point to where you think it would be.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/3dgrid.png?raw=true)

To figure out where the coordinate (2, 2, 2) appears on the screen, we can start at the origin (0, 0, 0) and move forward two units. Then we move to the right two units. Then we move up two units, and the final position tells us where coordinate (2, 2, 2) would appear on the screen.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/3dgrid_222.png?raw=true)

Draw this grid on paper and label the axes. Then pick five random 3D coordinates and draw and label where they should appear in the image.

## Coordinate System Handedness

In the Leadwerks 3D coordinate system, positive X points to the right, positive Y points up, and positiue Z points forward. 
