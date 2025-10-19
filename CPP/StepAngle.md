# StepAngle

This function increments one angle towards a target angle at a steady rate, using the shortest possible distance.

## Syntax

- float **Step**(const float start, const float stop, const float amount)

| Parameter | Description |
|---|---|
| start | beginning angle |
| stop | destination angle |
| amount | maximum distance to move |

## Returns

Returns the incremented angle. If the difference between the angles is less than *amount* then *stop* will be returned.
