# Create an Image Converter

This page describes how to create a simple image converter utility.

Start with a new application and insert the code below into main.cpp.

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    //Get the input file path
    WString path;
    if (argc > 1)
    {
        path = argv[1];
    }
    else
    {
        path = RequestFile("Open Image");
        if (path == "")
        {
            Print("No file path specified.");
            return 1;
        }
    }

    // Load the image
    auto pixmap = LoadPixmap(path);
    if (pixmap == NULL)
    {
        Print("Failed to load pixmap \"" + path + "\"");
        return 1;
    }

    //Convert to RGBA if needed
    if (pixmap->format != TEXTURE_RGBA)
    {
        pixmap = pixmap->Convert(TEXTURE_RGBA);
    }

    // Resave the image
    if (!pixmap->Save("output.png"))
    {
        Print("Failed to save output.png");
        return 1;
    }

    RunFile("output.png");
    return 0;
}
```

To use our converter we can drag an image file onto the compiled executable, or use the file requester to select a file to convert. For testing, we can set the command line in the project properties. Set **Debugging \> Command Arguments** to the text below.

```txt
https://github.com/Leadwerks/Documentation/raw/master/Assets/Materials/Ground/dirt01.dds
```

![](https://raw.githubusercontent.com/Leadwerks/Documentation/master/Images/commandline.png)

When you run the program the specified file will be loaded, saved as a PNG image, and opened in the default system image viewer.
