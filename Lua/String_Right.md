# Right

This method returns the rightmost characters of the string.

## Syntax

- string Right(number count)

| Parameter | Description |
| --- | --- |
| count | Maximum number of characters to return |

## Returns

Returns the rightmost characters of the string. If the count parameter is equal to or greater than the length of the string, the entire string is returned.

## Example

```lua
local s = "Hello, how are you today?"
Print(Right(s, 6))
```
