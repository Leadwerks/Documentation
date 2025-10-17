# 3D Vectors

If we draw a line from any point in 3D space to the origin (0, 0, 0), we get a vector. A vector is a line with a direction and a length.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/3dvector.png?raw=true)

We have a special class in Leadwerks for handling 3D vectors called [Vec3](Vec3.md). A 3D vector can be created like this:

```lua
v = Vec3(2, 4, 0)
```

We can then access the x, y, and z values individually:

```lua
Print(v.x)
Print(v.y)
Print(v.z)
```

You can think of a Vec3 as either a point in space, or a line from the origin to a point in space.
