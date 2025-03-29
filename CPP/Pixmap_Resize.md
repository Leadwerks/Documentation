# Pixmap::Resize

This method resizes a pixmap to make it larger or smaller.

## Syntax

- shared_ptr<[Pixmap](Pixmap.md)\> **Resize**(const int width, const int height)

| Parameter | Description |
|---|---|
| width, height | resize dimensions |

## Returns

If successful a new pixmap is returned, otherwise nil is returned. Pixmaps that use compressed pixel formats cannot be resized directly, and must be converted to a format like RGBA or RGBA16 before resizing.

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

    //Create a pixmap
    auto pixmap = LoadPixmap("https://github.com/Leadwerks/Documentation/raw/master/Assets/Materials/Ground/dirt01.dds");
    
    //Resize the pixmap
    pixmap = pixmap->Resize(128, 128);

    //Show the pixmap
    ui->root->SetPixmap(pixmap);

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
