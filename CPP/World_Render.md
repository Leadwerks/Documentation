# World::Render

This method sends all queued rendering instructions to the rendering thread and tells it to render and display the contents of this world.

## Syntax

- void **Render**(shared_ptr<[Framebuffer](Framebuffer.md)\> framebuffer, const bool vsync = true, const int syncedframes = -1)

| Parameter | Description |
|---|---|
| framebuffer | framebuffer to render to |
| vsync | if set to true vertical sync is enabled |
| syncedframes | number of frames to render for each world update, or -1 to let the engine choose |

## Remarks

If vertical sync is disabled the framerate will be uncapped and will usually be higher, but screen tearing artifacts can occur. Vertical sync should be disabled when benchmarking performance.

Rendering in Leadwerks is asychronous, meaning it is executed on a separate thread from your game logic. Consequently, there is some delay between the first call to World::Render and the first appearance of visible graphics on the screen. Additionally, initialization of the renderer can fail if the hardware it is running on does not meet system requirements. You can evaluate the STARTRENDERER event to wait until the renderer has started drawing before you begin your game logic, to detect if the renderer has failed to initialize, and to retrieve the name of the graphics device the renderer is using. The event.data member will be set to 1 if the renderer was initialized successfully, otherwise it will be set to 0. The device name will be stored in the event.text member.

If your game spendsa significant amount of time initializing a scene, you can save a few seconds of loading time by calling this method immediately after creating a framebuffer so that initialization is performed at the same time your game is loading.

The syncedframes parameter lets you control the exact number of frames that are drawn for each world update. If your game updates at 60 hz, and your display refresh rate is 60 hz, you can set this value to 1 and exactly one frame will be rendered for each game update, without any object interapolation. If the screen refresh rate is 144 you can set this value to 2 and use 72 as the world update frequency, and exactly two frames will be rendered for each game update.

## Example

```c++
import UltraEngine;

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
    auto camera = CreateCamera(world, PROJECTION_ORTHOGRAPHIC);
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
                    //Display the graphics device name
                    window->SetText(window->text + " - " + e.text);
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
