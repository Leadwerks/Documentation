# SetCascadeDistance

For directional lights, this method sets the distance that each cascaded shadow map partition covers.

## Syntax

- **SetCascadeDistance**(const float p1)
- **SetCascadeDistance**(const float p1, const float p2, const float p3, const float p4)

| Parameter | Description |
|---|---|
| p1 | distance first partition covers |
| p2 | distance second partition covers |
| p3 | distance third partition covers |
| p4 | distance fourth partition covers |

## Remarks

If the overload that takes only one argument is used, the distance will be doubled for each of the other partitions. For example, calling SetPartition(8) will produce the same results as calling SetPartition(8, 16, 32, 64).
