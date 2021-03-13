# String::XOR #

This method encrypts the string with an XOR cipher and returns the result.

## Syntax ##

- [String](String.md) **XOR**(const [String](String.md)& key)

| Parameter | Description |
| --- | --- |
| key | encryption key |

## Returns ##

Returns the encrypted string.

## Example ##

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    String password = "HaikuMockingBonanzaTumble";
    String key = "d'U0)Ez[^?2?=^X|y49dKurq9mASp`5}";
    String encrypted = password.XOR(key);

    Print("Encrypted string: " + encrypted);
    
    String decrypted = encrypted.XOR(key);
    Print("Decrypted string: " + decrypted);

    return 0;
}
```
