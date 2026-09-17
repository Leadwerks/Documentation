# Hmd::GetRefreshRate

This method returns the headset refresh rate.

## Syntax

- int **GetRefreshRate**()

## Returns

This method will return 0 until the OpenXR session initializes. After that, it will return the headset refresh rate, in frames per second.

## Example

```cpp
#include "Leadwerks.h"

using namespace Leadwerks;

int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = GetDisplays();

    //Create a window
    auto window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[0]->scale, 720 * displays[0]->scale, displays[0], WINDOW_CLIENTCOORDS | WINDOW_CENTER | WINDOW_TITLEBAR);

    //Create a framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Create a world
    auto world = CreateWorld();

    // Get the VR headset
    auto hmd = GetHmd(world);
    hmd->Start(framebuffer);

    //Environment maps
    auto specmap = LoadTexture("Materials/Environment/Default/specular.dds");
    auto diffmap = LoadTexture("Materials/Environment/Default/diffuse.dds");
    auto skymap = LoadTexture("Materials/Environment/Default/skybox.dds");
    world->SetEnvironmentMap(skymap, ENVIRONMENTMAP_BACKGROUND);
    world->SetEnvironmentMap(specmap, ENVIRONMENTMAP_SPECULAR);
    world->SetEnvironmentMap(diffmap, ENVIRONMENTMAP_DIFFUSE);

    //Create a light
    auto light = CreateBoxLight(world);
    light->SetRotation(55, 35, 0);
    light->SetRange(-10, 10);
    light->SetArea(15, 15);

    //Add a floor
    auto floor = CreateBox(world, 10, 1, 10);
    floor->SetPosition(0, -0.5, 0);
    floor->SetColor(0.5, 0.5, 0.5);

    //Default update frequency, before the HMD initializes
    float frequency = 60.0f;

    //Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        // Update the world in sync with the headset frequency
        world->Update(frequency);

        // Render the world with one synced frame
        world->Render(framebuffer, true, 1);

        // Evaluate HMD events
        while (PeekEvent())
        {
            const auto ev = WaitEvent();
            switch (ev.id)
            {
            case EVENT_VRSTART:
                // Session has started
                if (ev.data == 0)
                {
                    Notify("HMD failed to start\n\n" + ev.text, "OpenXR Error", true);
                    return 0;
                }
                else
                {
                    Print("HMD started");
                    frequency = hmd->GetRefreshRate();
                }
                break;
            }
        }
    }

    Shutdown();
    return 0;
}
```
