# Axis-aligned Bounding Boxes

An axis-aligned bounding box (AABB) is a 3D box with volume. It is defined as having width, height, depth, a center position, and minimum and maximum extents:

| Member | Type | Description |
|---|---|---|
| min | [Vec3](Vec3.md) | minimum extents of the bounding box |
| max | [Vec3](Vec3.md) | maximum extents of the bounding box |
| center | [Vec3](Vec3.md) | center position of the bounding box |
| size | [Vec3](Vec3.md) | size of the bounding box |
| radius | number | distance from the center of the box to any corner |

Axis-aligned bounding boxes are often used as a rough intersection test before more detailed calculations are made. In many cases this allows us to skip more expensive calculations on objects we know don't undersect the bounding box. "Axis-aligned" just means the box can't be rotated, which simplies a lot of calculations and makes them more efficient.

To define a bounding box, we just need to specify the minimum and maximum extents of the box, and the rest will be calculated automatically. The other members of the bounding box will be calculated automatically.

```lua
local aabb = Aabb(-2, -1, -1, 2, 1, 1)
Print(aabb.min)
Print(aabb.max)
Print(aabb.center)
Print(aabb.size)
Print(aabb.radius)
```

Here is the printed result when this code is run:

```txt
-2, -1, -1
2, 1, 1
0, 0, 0
4, 2, 2
2.44948983192443848
```

We can modify an Aabb at any time, but we need to remember to call the [Aabb:Update](Aabb_Update.md) method any time we do this. This method will calculate the center, size, and radius from the minimum and maximum extents.

## AABB Intersection Tests

| Method | Description |
|---|---|
| [IntersectsPoint](Aabb_IntersectsPoint.md) | Tests the intersection of the box and a point in 3D space |
| [IntersectsAabb](Aabb_IntersectsAabb.md) | Tests the intersection of the box and another axis-aligned bounding box |
| [IntersectsLine](Aabb_IntersectsLine.md) | Tests the intersection of the box and a line in 3D space |
| [IntersectsPlane](Aabb_IntersectsPlane.md) | Tests the intersection of the box and a plane |

Each entity has three bounding boxes we can retrieve, using the [Entity:GetBounds](Entity_GetBounds,md) method.

- The *local* bounding box encloses the entity, in its own local coordinate system.
- The *global* bounding box encloses the entity, in global space.
- The *recursive* bounding box encloses the entity and all of its children, in global space.

These bounding boxes are updated automatically any time the entity moves.
