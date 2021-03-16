# Mix

This function performs a linear interpolation and returns the result.

## Syntax

- float **Mix**(const float value0, const float value1, const float d)
- double **Mix**(const double value0, const double value1, const double d)

| Parameter | Description |
| --- | --- |
| value0 | first value |
| value1 | second value |
| d | interpolation amount |

## Returns

Returns the result of the linear interpolation.

## Example
```c++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    Print(Mix(10.0f, 20.0f, 0.75f));
    return 0;
}
```
