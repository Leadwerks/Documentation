# Widget::SetIcon #

This method adds an icon to the widget.

## Syntax ##
- void **Seticon**(shared_ptr<[Icon](Icon.md)\> icon)

| Parameter | Description |
| --- | --- |
| icon | icon to set |

## Example

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = ListDisplays();

    //Create window
    auto window = CreateWindow("Ultra Engine", 0, 0, 800, 800, displays[0]);

    //Create user interface
    auto ui = CreateInterface(window);

    //Create a pixmap
    auto icon = LoadIcon("https://github.com/Leadwerks/Documentation/raw/master/Assets/Materials/Logos/23.svg");

    //Show the icon
    ui->root->SetIcon(icon);

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
