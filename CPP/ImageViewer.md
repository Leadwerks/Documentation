# Create an Image Viewer

This page describes how to create a simple image viewing program.

## Interface Setup

Start with a new GUI project. Insert the code below into main.cpp. This will set up a basic user interface with a main panel for viewing images and a menu with a few items.

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    // Get the available displays
    auto displays = GetDisplays();

    // Create a window
    auto window = CreateWindow("Image Viewer", 0, 0, 1024, 768, displays[0], WINDOW_TITLEBAR | WINDOW_RESIZABLE | WINDOW_CENTER);

    // Create user interface
    auto ui = CreateInterface(window);
    iVec2 sz = ui->root->ClientSize();

    // Create menu
    auto mainmenu = CreateMenu("", ui->root);
    auto menu_file = CreateMenu("File", mainmenu);
    auto menu_open = CreateMenu("Open", menu_file);
    auto menu_save = CreateMenu("Save", menu_file);
    CreateMenu("", menu_file);
    auto menu_quit = CreateMenu("Quit", menu_file);

    // Main panel
    int padding = 4;
    auto mainpanel = CreatePanel(padding,mainmenu->size.y + padding,sz.x - padding*2, sz.y - padding*2 - mainmenu->size.y, ui->root, PANEL_BORDER);
    mainpanel->SetLayout(1, 1, 1, 1);
    mainpanel->SetColor(0.1, 0.1, 0.1);

    while (true)
    {
        const Event ev = WaitEvent();
        switch (ev.id)
        {
        case EVENT_WIDGETACTION:
            if (ev.source == menu_quit)
            {
                return 0;
            }
            break;
        case EVENT_WINDOWCLOSE:
            if (ev.source == window) return 0;
            break;
        }
    }
    return 0;
}
```

When we run the program it will look like the image below.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/master/Images/imageviewer1.png)

## Image Loading

We need to load the FreeImage plugin to support common image file formats. Add this code in the beginning of the main function:

```c++
    auto plugin = LoadPlugin("Plugins/FITextureLoader.*");
    if (plugin == NULL)
    {
        Print("Failed to load FreeImage plugin.");
        return 0;
    }
```

Now add this code in the EVENT_WIDGETACTION case in the switch statement. When the user selects the **File \> Open** menu item, this will show a file request dialog and allow them to select an image to load and display.

```c++
            if (ev.source == menu_open)
            {
                WString path = RequestFile("Open Image");
                if (path != "")
                {
                    auto pixmap = LoadPixmap(path);
                    if (pixmap)
                    {
                        mainpanel->SetPixmap(pixmap, PIXMAP_CONTAIN);
                        window->SetText("Image Viewer - " + StripDir(path));
                    }
                    else
                    {
                        Notify("Failed to load pixmap \"" + path + "\"", "Error", true);
                    }
                }
            }
```

We can now select an image to load and display in the main panel.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/master/Images/imageviewer2.png)

## Image Saving

To enable save behabior we just add some new code in the EVENT_WIDGETACTION case to handle when the **File \> Save** menu item is selected:

```c++
            if (ev.source == menu_save)
            {
                if (mainpanel->pixmap)
                {
                    WString path = RequestFile("Save Image", "", "Portable Network Graphics:png;JPEG:jpg;Bitmap:bmp", 0, true);
                    if (path != "")
                    {
                        if (!mainpanel->pixmap->Save(path))
                        {
                            Notify("Failed to save pixmap \"" + path + "\"", "Error", true);
                        }
                    }
                }
            }
```

Here is the complete code:

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    // Get the available displays
    auto displays = GetDisplays();

    // Create a window
    auto window = CreateWindow("Image Viewer", 0, 0, 1024, 768, displays[0], WINDOW_TITLEBAR | WINDOW_RESIZABLE | WINDOW_CENTER);

    // Create user interface
    auto ui = CreateInterface(window);
    iVec2 sz = ui->root->ClientSize();

    // Create menu
    auto mainmenu = CreateMenu("", ui->root);
    auto menu_file = CreateMenu("File", mainmenu);
    auto menu_open = CreateMenu("Open", menu_file);
    auto menu_save = CreateMenu("Save", menu_file);
    CreateMenu("", menu_file);
    auto menu_quit = CreateMenu("Quit", menu_file);

    // Main panel
    int padding = 4;
    auto mainpanel = CreatePanel(padding, mainmenu->size.y + padding, sz.x - padding * 2, sz.y - padding * 2 - mainmenu->size.y, ui->root, PANEL_BORDER);
    mainpanel->SetLayout(1, 1, 1, 1);
    mainpanel->SetColor(0.1, 0.1, 0.1);

    while (true)
    {
        const Event ev = WaitEvent();
        switch (ev.id)
        {
        case EVENT_WIDGETACTION:
            if (ev.source == menu_quit)
            {
                return 0;
            }
            else if (ev.source == menu_open)
            {
                WString path = RequestFile("Open Image");
                if (path != "")
                {
                    auto pixmap = LoadPixmap(path);
                    if (pixmap)
                    {
                        mainpanel->SetPixmap(pixmap, PIXMAP_CONTAIN);
                        window->SetText("Image Viewer - " + StripDir(path));
                    }
                    else
                    {
                        Notify("Failed to load pixmap \"" + path + "\"", "Error", true);
                    }
                }
            }
            else if (ev.source == menu_save)
            {
                if (mainpanel->pixmap)
                {
                    WString path = RequestFile("Save Image", "", "Portable Network Graphics:png;JPEG:jpg;Bitmap:bmp", 0, true);
                    if (path != "")
                    {
                        if (!mainpanel->pixmap->Save(path))
                        {
                            Notify("Failed to save pixmap \"" + path + "\"", "Error", true);
                        }
                    }
                }
            }
            break;
        case EVENT_WINDOWCLOSE:
            if (ev.source == window) return 0;
            break;
        }
    }
    return 0;
}
```
