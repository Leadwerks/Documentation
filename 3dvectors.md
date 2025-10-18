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

The length of a vector is easy to calculate. We just take the X, Y, and Z lengths, square each one, add them together, and take the square root:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/vectorlength.svg?raw=true)

This is a formula you should know by heart, and be able to draw out on paper with the help of a calculator. In code, it would look like this:

```lua
v = Vec3(3, 4, 0)
l = Sqrt(v.x * v.x + v.y * v.y + v.z * v.z)
Print(l)
```

The Vec3 class includes a method that tells uses this forumula to get the length of any 3D vector:

```lua
v = Vec3(3, 4, 0)
l = v:Length()
Print(l)
```

This tells us that the length of this vector is exactly 5 units.

## Normalizing Vectors

Sometimes we want to keep the same direction, but rescale a vector so that its length is exactly one. In mathematics, a vector with a length of one is called is called a _unit vector_. In computer graphics, a unit vector is also called a _normal_, and they have many uses. For example, mesh vertex normals tell the lighting system which direction the surface faces at each vertex and are used for lighting.



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

You can add two vectors simply by adding each member together. This shows how to add vectors A and B to make a new vector called C:

```txt
C.x = A.x + B.x
C.y = A.y + B.y
C.z = A.z + B.z
```

With code, the operation looks like this:

```lua
A = Vec3(1, 2, 3)
B = Vec3(2, 3, 1)

C = A + B

Print(C.x)
Print(C.y)
Print(C.z)
```

I don't usually think in numbers. Instead, I like to think in pictures. Adding vectors together visually is easy. All you have to do is connect one vector to the end of the other. Where you end up is the new vector:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/vectoraddition.png?raw=true)

## Vector Multiplication

Just like addition, vector multiplication can be performed by multiplying each vector component together:

```txt
C.x = A.x * B.x
C.y = A.y * B.y
C.z = A.z * B.z
```

We can perform this in one line of code like this:

```lua
C = A * B
```

We can also multiply a vector by a single number:

```lua
A = B * 2
```

This is the exact same thing as multiplying a vector by another vector that has the same value for X, Y, and Z:

```lua
A = B * Vec3(2)
```

Vector multiplication has many uses. To slow a moving object down, we can just multiply its velocity by some number between zero and one, like 0.1. This will gradually lower the velocity:

```
velocity = velocity * 0.1
```

We can use multiplication to make colors brighter or darker:

```
red = Vec3(1,0,0)
darkred = red * 0.5
```

We can also use multiplication to flip one vector component:

```
direction = direction * Vec3(-1,1,1)
```

If we multiply the entire vector by -1, we get a vector pointing in the exact opposite direction.

## Dot Product



## Reflection

