# Hmd::Stop

This method ends a running VR session.

## Syntax

- void **Stop**()
- 
## Remarks

At the time of this writing, SteamVR cannot start a new OpenXR session on a different framebuffer once a previous session has started and ended. This is a bug in SteamVR and has been reported to Valve.

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

    //Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        // Start and stop an OpenXR session
        if (window->KeyHit(KEY_SPACE))
        {
            if (hmd->GetState() == VRDEVICESTATE_INACTIVE)
            {
                hmd->Start(framebuffer);
            }
            else
            {
                hmd->Stop();
            }
        }

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

            case EVENT_VRSTOP:
                // Session has ended
                Print("HMD stopped");
                break;
            }
        }
    }

    Shutdown();
    return 0;
}
```
