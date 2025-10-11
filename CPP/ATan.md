# ATan

This function returns the arc tangent of the specified value. The second overload will return an angle, given the Y and X coordinates of a point.

## Syntax

- float **ATan**(const float value)
- float **ATan**(const float y, const float x)

| Parameter | Description |
| --- | --- |
| value | tangent value |
| y | Y component of a point, to determine and angle |
| x | X component of a point, to determine and angle |

## Returns

Returns the arc tangent, or the angle given by the vector XY.

## Example

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    float angle = -65.0f;

    float s = Sin(angle);
    float c = Cos(angle);
    float t = Tan(angle);

    Print("Sin: " + String(ASin(s)));
    Print("Cos: " + String(ACos(c)));
    Print("Tan: " + String(ATan(t)));

    return 0;
}
```
