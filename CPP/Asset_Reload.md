# Asset::Reload

This method reloads an asset from a file on the disk. If changes were made to the file they will appear after reloading.

## Syntax

- bool **Reload**(const [LoadFlags](Constants.md#LoadFlags) flags = LOAD_DEFAULT)

| Parameter | Description |
|---|---|
| **flags** | optional load flags |

## Returns
If successful true is returned, otherwise false is returned.

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

    //Load an asset
    WString path = GetPath(PATH_DOCUMENTS) + "/temp.dds";
    if (!CopyFile("https://github.com/Leadwerks/Documentation/raw/master/Assets/Materials/Ground/dirt01.dds", path))
    {
        RuntimeError("Failed to download pixmap.");
    }

    //Load the file from the hard drive
    auto pixmap = LoadPixmap(path);

    //Show the pixmap
    ui->root->SetPixmap(pixmap);

    auto button = CreateButton("Modify Pixmap", 10, 10, 100, 30, ui->root);

    while (true)
    {
        const Event ev = WaitEvent();
        switch (ev.id)
        {
        case EVENT_WIDGETACTION:
            if (ev.source == button)
            {
                //Make a copy of the pixmap, modify it, and overwrite the file
                auto pixmap2 = pixmap->Copy()->As<Pixmap>();
                if (pixmap2->format != TEXTURE_RGBA) pixmap2 = pixmap2->Convert(TEXTURE_RGBA);
                int px = Random(0, pixmap->size.x - 1 - 100);
                int py = Random(0, pixmap->size.y - 1 - 100);
                int color = Rgba(Random(255), Random(255), Random(255), 255);
                for (int x = 0; x < 100; ++x)
                {
                    for (int y = 0; y < 100; ++y)
                    {
                        pixmap2->WritePixel(px + x, py + y, color);
                    }
                }
                pixmap2->Save(path);

                //Reload the pixmap from the file
                pixmap->Reload();
                
                //Redraw the panel
                ui->root->Paint();
            }
            break;
        case EVENT_WINDOWCLOSE:
            return 0;
            break;
        }
    }

    return 0;
}
```
