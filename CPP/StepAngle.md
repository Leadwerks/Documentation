# Step

This function increments one value towards a target at a steady rate.

## Syntax

- float **Step**(const float start, const float stop, const float amount)
- double **Step**(const double start, const double stop, const double amount)

| Parameter | Description |
|---|---|
| start | beginning value |
| stop | destination value |
| amount | maximum distance to move |

## Returns

Returns the incremented value. If the difference between the values is less than *amount* then *stop* will be returned.
