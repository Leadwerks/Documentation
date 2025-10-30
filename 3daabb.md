# Axis-aligned Bounding Boxes

An axis-aligned bounding box is a 3D box with volume. It is defined as having width, height, depth, a center position, and minimum and maximum extents:

| Member | Type | Description |
|---|---|---|
| min | [Vec3](Vec3.md) | minimum extents of the bounding box |
| max | [Vec3](Vec3.md) | maximum extents of the bounding box |
| center | [Vec3](Vec3.md) | center position of the bounding box |
| size | [Vec3](Vec3.md) | size of the bounding box |
| radius | number | distance from the center of the box to any corner |

To define a bounding box, we just need to specify the minimum and maximum extents of the box, and the rest will be calculated:
```lua
local aabb = Aabb(-2,-1,-1,2,1,1)
```

