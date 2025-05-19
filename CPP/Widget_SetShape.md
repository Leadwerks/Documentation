# Widget::SetShape

This method sets the widget position and height.

## Syntax

- void **SetShape**(const int x, const int y, const int width, const int height)
- void **SetShape**(const [iVec2](iVec2.md)& position, const [iVec2](iVec2.md)& size)

| Parameter | Description |
| --- | --- |
| x | X component of the widget position |
| y | Y component of the widget position |
| width | X component of the widget size |
| height | Y component of the widget size |
| position | widget position to set |
| size | widget size to set |

## Example

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = GetDisplays();

    //Create a window
    auto window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[0]);

    //Create User Interface
    auto ui = CreateInterface(window);
    auto sz = ui->root->ClientSize();

    //Create widget
    auto panel = CreatePanel(50, 50, sz.x - 100, sz.y - 100, ui->root);
    panel->SetColor(0, 0, 0, 1);

    //Set the shape
    panel->SetShape(10, 10, 200, 200);

    while (true)
    {
        const Event ev = WaitEvent();
        switch (ev.id)
        {
        case EVENT_WINDOWCLOSE:
            return 0;
            break;
        }
    }
    return 0;
}
```
