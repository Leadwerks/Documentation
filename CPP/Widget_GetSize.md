# Widget::GetSize

This method returns the dimensions of the widget. To retrieve the area inside the widget excluding any padding, use the [ClientSize](Widget_ClientSize.md) method.

## Syntax

- [iVec2](iVec2.md) **GetSize**()

## Returns

Returns the widget size.

## Example

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = GetDisplays();

    //Create a window
    auto window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[0], WINDOW_TITLEBAR | WINDOW_RESIZABLE);

    //Create User Interface
    auto ui = CreateInterface(window);
    auto sz = ui->root->ClientSize();

    //Create widget
    auto panel = CreatePanel(50, 50, sz.x - 100, sz.y - 100, ui->root, PANEL_BORDER);
    panel->SetLayout(1, 1, 1, 1);

    sz = panel->ClientSize();
    auto label = CreateLabel("", 0, 0, sz.x, sz.y, panel, LABEL_CENTER | LABEL_MIDDLE);
    label->SetLayout(1, 1, 1, 1);

    while (true)
    {
        const Event ev = WaitEvent();
        switch (ev.id)
        {
        case EVENT_WINDOWCLOSE:
            return 0;
            break;
        case EVENT_WINDOWSIZE:
            sz = panel->GetSize();
            label->SetText(String(sz.x) + " x " + String(sz.y));
            break;
        }
    }
    return 0;
}
```
