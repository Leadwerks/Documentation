# Mix

This function performs a linear interpolation and returns the result.

## Syntax

- number **Mix**(number value0, number value1, number d)
- number **Mix**([Vec2](Vec2.md) value0, [Vec2](Vec2.md) value1, number d)
- number **Mix**([Vec3](Vec3.md) value0, [Vec3](Vec3.md) value1, number d)

| Parameter | Description |
| --- | --- |
| value0 | first value |
| value1 | second value |
| d | interpolation amount |

## Returns

Returns the result of the linear interpolation.

## Example

```lua
Print(Mix(10, 20, 0.75))
```
