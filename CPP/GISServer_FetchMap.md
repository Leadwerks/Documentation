# GISServer::FetchMap

## Syntax 

- **FetchMap**()


## Example
```c++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    //Initialize the GIS server
    String url = "http://webmap.lroc.asu.edu/";
    auto server = OpenGISServer(url);

    //Fetch a map image
    iVec2 size = iVec2(64, 64);
    Vec4 bbox = Vec4(-180, -90, 180, 90);
    std::vector<String> layers = { "pluto_global" };
    String format = "image/jpeg";
    auto map = server->FetchMap( layers, size, bbox, format);
    if (map == NULL)
    {
        Print("Error: Failed to fetch map");
        return 0;
    }

    //Save and open pixmap
    WString path = GetPath(PATH_DESKTOP) + "/map.jpg";
    if (map->Save(path)) RunFile(path);

    return 0;
}
```
