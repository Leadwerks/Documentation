# 4x4 Matrices

What is the matrix? In Leadwerks, a 4x4 matrix is a mathematical structure used to represent an object’s position, rotation, and scale in 3D space. Think of it as a compact way to encode all the spatial information about an entity. The matrix contains 16 values arranged in four rows and four columns, which together define how the object is oriented in the world.

The [Mat4](Mat4.md) class has four [Vec4](Vec4.md) that can be accessed either with i, j, k, and t, or by number:

```lua
m = Mat4(1)

Print(m[0])
Print(m[1])
Print(m[2])
Print(m[3])
```
The code above will print out the following:

```
1, 0, 0, 0
0, 1, 0, 0
0, 0, 1, 0
0, 0, 0, 1
```
This particular type of matrix is called an _identity matrix_ and instantly tells us a few things:
- The object is at position (0,0,0).
- The object is not rotated.
- The object has a scale of 1.0 on all three axes.

### Matrix Orientation

- The first three values in the first row represents the direction of the object's X axis in global space. For example, on a 3D model of an airplane this row would be a vector indicating the direction the right wing is pointing.

- The first three values in the second row represents the direction of the object's Y axis in global space. For example, on a 3D model of an airplane this row would be a vector indicating the up direction relative to the aircraft.

- The first three values in the third row represents the direction of the object's Z axis in global space. For example, on a 3D model of an airplane this row would be a vector indicating the forward direction relative to the aircraft.

### Matrix Translation

The first three values in the last row contains the position of the entity in world space. These are the X, Y, and Z coordinates where the object is located.

### Matrix Scale

- The length of the first row vector is the object's scale on the X axis, in world space.

- The length of the second row vector is the object's scale on the Y axis, in world space.

- The length of the third row vector is the object's scale on the Z axis, in world space.

The last value in each row is unused, so the right column is always set to (0, 0, 0, 1). This just makes the math work out nicely when we do fancy things with matrices.

## Getting and Settings Entity Matrices

Since the entity matrix encodes the position, rotation, and scale, this gives us an easy way to exactly copy one entity's orientation to another:

```lua
b:SetMatrix(a.matrix)
```
