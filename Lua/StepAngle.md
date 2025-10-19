# StepAngle

This function increments one angle towards a target angle at a steady rate, using the shortest possible distance.

## Syntax

- number **StepAngle**(number start, number stop, number amount)

| Parameter | Description |
|---|---|
| start | beginning angle |
| stop | destination angle |
| amount | maximum distance to move |

## Returns

Returns the incremented angle. If the difference between the angles is less than *amount* then *stop* will be returned.
