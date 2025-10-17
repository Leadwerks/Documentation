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

## Vector Length

The Vec3 class includes a method that tells us the length of any 3D vector:

```lua
v = Vec3(-2, 4, 0)
l = v:Length()
Print(l)
```

This tells us that the length of this vector is exactly 4.47214.

## Normalizing Vectors

Sometimes we want to keep the same direction, but rescale a vector so that its length is exactly one. In mathematics, a vector with a length of one is called is called a _unit vector_.

The Vec3 class has a method that will returned a normalized version of any vector:

```lua
v = Vec3(-2, 4, 0)
n = v:Normalize()
Print(n.x)
Print(n.y)
Print(n.z)
l = n:Length()
Print(l)
```

This code will print out the following:

```txt
-0.447214
0.894427
0
1
```

Notice that the X and Y values both got smaller, Z stayed the same, and the length of the new vector is exactly one.

The result is a vector that points in the same direction as the first, but instead of being 4.47 units long, its now just one unit in length:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/3dvectorN.png?raw=true)

## Vector Addition and Subtraction


 Unit vectors can be useful for multiplication operations if we want to make sure we don't change the length or the other vector.

## Vector Multiplication and Division



