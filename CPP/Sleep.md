# Sleep #
This function pauses the current thread for the specified number of milliseconds.

## Syntax ##
- void **Sleep**(const int time)

| Parameter | Description |
| ----- | ----- |
| time | Number of milliseconds to pause. |

## Example ##
```c++
#include "pch.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
	//Get the initial system time
	auto starttime = Millisecs();

	//Pause for one second
	Sleep(1000);

	//Show the current time relative to the starting time
	auto currenttime = Millisecs() - starttime;
	Print(currenttime);

	//Pause for one second
	Sleep(1000);

	//Show the current time relative to the starting time
	currenttime = Millisecs() - starttime;
	Print(currenttime);

	return 0;
}
```