# SetCascadeDistance

For directional lights, this method sets the distance that each cascaded shadow map partition covers.

## Syntax

- **SetCascadeDistance**(const float p0)
- **SetCascadeDistance**(const float p0, const float p1, const float p2, const float p3)

| Parameter | Description |
|---|---|
| p0 | distance first partition covers |
| p1 | distance second partition covers |
| p2 | distance third partition covers |
| p3 | distance fourth partition covers |

## Remarks

If the overload that takes only one argument is used, the distance will be doubled for each of the other partitions. For example, calling SetPartition(8) will produce the same results as calling SetPartition(8, 16, 32, 64).
