# ATan

This function returns the arc tangent of the specified value. The second overload will return an angle, given the Y and X coordinates of a point.

## Syntax

- number **ATan**(number value)
- number **ATan**(number y, number x)

| Parameter | Description |
| --- | --- |
| value | tangent value |
| y | Y component of a point, to determine and angle |
| x | X component of a point, to determine and angle |

## Returns

Returns the arc tangent, or the angle given by the vector XY.

## Example

```lua
angle = -65.0

s = Sin(angle)
c = Cos(angle)
t = Tan(angle)

Print("Sin: " .. ASin(s))
Print("Cos: " .. ACos(c))
Print("Tan: " .. ATan(t))
```
