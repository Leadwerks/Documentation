# Update

Namespace: [Steamworks](Steamworks.md)

This function should be called once per frame when a Steam app is running.

## Syntax

- void **Update**()

## Example

```c++
#include "UltraEngine.h"
#include "Steamworks/Steamworks.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    if (not Steamworks::Initialize())
    {
        RuntimeError("Steamworks failed to initialize.");
        return 1;
    }

    auto cl = ParseCommandLine(argc, argv);

    //Get the displays
    auto displays = GetDisplays();

    //Create a window
    auto window = CreateWindow("Ultra Engine", 0, 0, 1280 * displays[0]->scale, 720 * displays[0]->scale, displays[0], WINDOW_CENTER | WINDOW_TITLEBAR);

    //Create a world
    auto world = CreateWorld();

    //Create a framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Load the map
    WString mapname = "Maps/start.ultra";
    if (cl["map"].is_string()) mapname = std::string(cl["map"]);
    auto scene = LoadMap(world, mapname);

    //Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        world->Update();
        world->Render(framebuffer);
        Steamworks::Update();
    }

    Steamworks::Shutdown();

    return 0;
}
```
