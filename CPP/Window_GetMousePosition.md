# Window::GetMousePosition

This method returns the mouse position relative to the window, in integer screen coordinates.

## Syntax

- [iVec3](iVec3.md) **MousePosition**()

## Returns

Returns the mouse screen position in the x and y components of the vector, and the mouse wheel position in the z component.

## Example

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = GetDisplays();

    //Create window
    auto window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[0]);

    //Create user interface
    auto ui = CreateInterface(window);

    //Display window position
    auto sz = ui->root->ClientSize();
    auto label = CreateLabel("", 0, 0, sz.x, sz.y, ui->root, LABEL_CENTER | LABEL_MIDDLE);
    label->SetLayout(1, 1, 1, 1);

    auto pos = window->GetMousePosition();
    label->SetText("Mouse position: " + String(pos.x) + " x " + String(pos.y));

    while (true)
    {
        const Event ev = WaitEvent();
        switch (ev.id)
        {
        case EVENT_MOUSEMOVE:
            pos = window->GetMousePosition();
            label->SetText("Mouse position: " + String(pos.x) + " x " + String(pos.y));
            break;
        case EVENT_WINDOWCLOSE:
            return 0;
            break;
        }
    }

    return 0;
}
```
