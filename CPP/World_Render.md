# World::Render

This method sends all queued rendering instructions to the rendering thread and tells it to render and display the contents of this world.

## Syntax

- void **Render**(shared_ptr<[Framebuffer](Framebuffer.md)\> framebuffer, const bool vsync = true)

| Parameter | Description |
|---|---|
| framebuffer | framebuffer to render to |
| vsync | if set to true vertical sync is enabled |

## Remarks

If vertical sync is disabled the framerate will be uncapped and will usually be higher, but screen tearing artifacts can occur. 

Vertical sync should be disabled when benchmarking performance.

Rendering in Ultra Engine is asychronous, meaning it is executed on a separate thread from your game logic. Consequently, there is some delay between the first call to World::Render and the first appearance of visible graphics on the screen. Additionally, initialization of the renderer can fail if the hardware it is running on does not meet system requirements. You can evaluate the [STARTRENDERER](Constants.md#EventIDs) event to wait until the renderer has started drawing before you begin your game logic, to detect if the renderer has failed to initialize, and to retrieve the name of the graphics device the renderer is using. The event.data member will be set to 1 if the renderer was initialized successfully, otherwise it will be set to 0. The device name will be stored in the event.text member.

## Example

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = GetDisplays();

    //Create window
    auto window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[0], WINDOW_CENTER | WINDOW_TITLEBAR);

    //Create world
    auto world = CreateWorld();

    //Create framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Create a camera
    auto camera = CreateCamera(world);
    camera->SetClearColor(0.125);

    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        while (PeekEvent())
        {
            const auto e = WaitEvent();
            switch (e.id)
            {
            case EVENT_STARTRENDERER:
                if (e.data == 1)
                {
                    //Print the graphics device name
                    Print("Renderer started: " + e.text);
                }
                else
                {
                    //Show error message
                    Notify("Renderer failed to initialize.\n\n" + e.text, "Error", true);
                    return 0;
                }
                break;
            case EVENT_QUIT:
                return 0;
            }
        }

        world->Update();
        world->Render(framebuffer);
    }
    return 0;
}
```
