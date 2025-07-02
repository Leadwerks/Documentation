# Camera::SetMsaa

This method can be used to enable mutli-sample antialiasing.

## Syntax

- void **SetMsaa**(const int mode)

| Parameter | Description | 
|---|---|
| mode | can be 0 (disabled), 2, 4, 8, 16, or 32 |

## Remarks

Not all hardware supports 32x antialiasing. In practice, 0, 2, and 4 are the only values you will need, as higher values will cause much slower performance.
