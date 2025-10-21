# Axis-aligned Bounding Boxes

An axis-aligned bounding box is a 3D box with volume. It is defined as having width, height, depth, a center position, and minimum and maximum extents:

To define a bounding box, we just need to specify the minimum and maximum extents of the box, and the rest will be calculated:
```lua
local aabb = Aabb(-2,-1,-1,2,1,1)
```

