# Light::SetRange

This method sets the distance to which the light illuminates.

## Syntax

- void **SetRange**(const float nearrange, const float farrange)
- void **SetRange**(const float farrange)

| Parameter | Description |
|---|---|
| nearrange | near range used for shadow map rendering |
| farrange | the maximum distance the light can reach |

## Remarks

Point and spot lights should use a near and far range above zero.

Box lights can have a negative near range, to make light appear behind the light position.
