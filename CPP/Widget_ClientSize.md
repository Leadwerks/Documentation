# Widget::ClientSize #
This method returns the dimensions of the drawable area inside a widget, excluding any padding.

## Syntax ##
- [iVec2](iVec2.md) **ClientSize**()

## Returns ##
Returns the widget client size. This is the area inside the widget with all borders removed, inside which a child widget may be created.

## Example ##
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
