# Step

This function increments one value towards a target at a steady rate.

## Syntax

- number **Step**(number start, number stop, number amount)

| Parameter | Description |
|---|---|
| start | beginning value |
| stop | destination value |
| amount | maximum distance to move |

## Returns

Returns the incremented value. If the difference between the values is less than *amount* then *stop* will be returned.
