# MixAngle

This function performs a linear interpolation between two angles and returns the result.

## Syntax

- float **MixAngle**(const float angle0, const float angle1, const float d)

| Parameter | Description |
| --- | --- |
| angle0 | first value |
| angle1 | second value |
| d | interpolation amount |

## Returns

Returns the result of the linear interpolation.

## Remarks

This function only handles rotation on a single axis. For interpolation between full 3D rotations, use the [Quat::Slerp](Quat_Slerp.md) method.
