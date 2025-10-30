# Planes

A plane is like an infinite surface rotated in any direction that divides th entire universe into two pieces. Everything is in the world is either in front of, behind, or exactly on the plane's surface.

Any plane can be defined with just a normal and a distance to the origin:

```lua
p = Plane(nx, ny, nz, d)
```

Note that the distance to the plane is considered "distance in front of the plane". If the origin is behind the plane, the distance value will be nagative.

Planes have two superpowers that are very useful for games:

- We can calculate the distance between any point in 3D space and the plane's surface.
- We can determine the intersection point of a line in 3D space with the plane.

## Plane Constructors

There are several ways we can construct a plane:
- From a normal and a distance to the origin.
- From any point on the plane, and a normal.
- From three points on a triangle.

```lua
--From a normal and a distance to the origin:
local p1 = Plane(0, 1, 0, 2)-- nx, ny, nz, d

--From a point and a normal:
local p2 = Plane(Vec3(0,-2,0), Vec3(0,1,0))-- point, normal

--From a triangle (three points on the plane)
local p3 = Plane(Vec3(0,-2,0), Vec3(0,-2,1), Vec3(1,-2,0))-- A, B, C

--Display the results
Print(tostring(p1.x)..", "..tostring(p1.y)..", "..tostring(p1.z)..", "..tostring(p1.d))
Print(tostring(p2.x)..", "..tostring(p2.y)..", "..tostring(p2.z)..", "..tostring(p2.d))
Print(tostring(p3.x)..", "..tostring(p3.y)..", "..tostring(p3.z)..", "..tostring(p3.d))
```

## Plane-point Distance

The [Plane:DistanceToPoint](Plane_DistanceToPoint.md) method allows us to easily retrieve the closest distance between a point in 3D space and the plane's surface.
- If the plane-point distance is _greater than zero_, the point is in front of the plane.
- If the plane-point distance is _less than zero_, the point is behind the plane.
- If the plane-point distance is _zero_, the point lies exactly on the plane.

For example, if we want to determine if the camera is above or below water level, we can use a plane like so:

```
local p = Vec3(0, 3, 0)
local waterplane = Plane(0, 1, 0, -2)-- the plane is two meters above the origin, so the origin is behind it, and distance is negative
local d = waterplane:DistanceToPoint(p)

if d > 0 then
  Print("Above water")
else
  Print("Below water")
end
```

## Convex Volumes

Things get interesting when we start using multiple planes. Before we get ahead of ourselves, lets define what convex and concave shapes are.

A convex shape doesn't have any parts of the shaoe that point inwards. A concave shape has part that point inwards, _like a cave_. As usual, it's easies to explain this with pictures:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/convexconcave.png?raw=true)





