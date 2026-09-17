# GetHmd

This function returns the head-mounted display, for virtual reality rendering.

## Syntax

- shared_ptr<[Hmd](Hmd.md)\> **GetHmd**(shared_ptr<[World](World.md)\> world = NULL)

| Parameter | Description |
|---|---|
| world | world to display the VR controllers in |

## Returns

Returns an object representing the user's head-mounted display. If the world parameter is non-NULL, this will always be returned, regardless of whether the headset is plugged in or active.

If the world parameter is NULL or not defined, the function will only return an HMD object if the HMD has already been initialized. This can be used to check if an application is running in VR mode.

## Remarks

You must call [Hmd::Start](Hmd_Start.md) to start a new OpenXR session before the headset will be usable.

## Example

```c++
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

    //Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        // Update the world
        world->Update();

        // Render the world
        world->Render(framebuffer);

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
                    Shutdown();
                    return 0;
                }
                else
                {
                    Print("HMD started");
                }
                break;
            }
        }
    }

    Shutdown();
    return 0;
}
```
