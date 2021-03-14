# String::Mid
This method extracts a partial string and returns it.

## Syntax
- [String](String.md) **Mid**(const int pos, const int length)

| Parameter | Description |
| --- | --- |
| pos | zero-based position in the string to start |
| length | maximum number of characters to return |

## Returns
Returns a string extracted from the specified position and length.

## Example

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    String s = "Hello, how are you today?";
    Print(s.Mid(7,3));

    return 0;
}
```
