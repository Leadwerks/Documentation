# VrController::ButtonDown

This method gets the current button pressed state of the controller.

## Syntax

- bool **ButtonDown**(VrControllerButton button)

| Parameter | Description |
|---|---|
| button | can be VRBUTTON_PRIMARY, VRBUTTON_SECONDARY, VRBUTTON_GRIP, or VRBUTTON_THUMBSTICK |

## Returns

Returns true if the specified button is pressed, otherwise false is returned.

```cpp
#include "Leadwerks.h"

using namespace Leadwerks;

int main(int argc, const char* argv[])
{
    // Get the displays
    auto displays = GetDisplays();

    // Create a window
    auto window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[0]->scale, 720 * displays[0]->scale, displays[0], WINDOW_CLIENTCOORDS | WINDOW_CENTER | WINDOW_TITLEBAR);

    // Create a framebuffer
    auto framebuffer = CreateFramebuffer(window);

    // Create a world
    auto world = CreateWorld();

    // Get the VR headset
    auto hmd = GetHmd(world);
    hmd->Start(framebuffer);

    // Environment maps
    auto specmap = LoadTexture("Materials/Environment/Default/specular.dds");
    auto diffmap = LoadTexture("Materials/Environment/Default/diffuse.dds");
    auto skymap = LoadTexture("Materials/Environment/Default/skybox.dds");
    world->SetEnvironmentMap(skymap, ENVIRONMENTMAP_BACKGROUND);
    world->SetEnvironmentMap(specmap, ENVIRONMENTMAP_SPECULAR);
    world->SetEnvironmentMap(diffmap, ENVIRONMENTMAP_DIFFUSE);

    // Create a light
    auto light = CreateBoxLight(world);
    light->SetRotation(55, 35, 0);
    light->SetRange(-10, 10);
    light->SetArea(15, 15);

    // Add a floor
    auto floor = CreateBox(world, 10, 1, 10);
    floor->SetPosition(0, -0.5, 0);
    floor->SetColor(0.5, 0.5, 0.5);

    // Create visual models for controllers
    std::array<shared_ptr<Model>, 2> models;
    for (int n = 0; n < 2; ++n)
    {
        models[n] = CreateBox(world, 0.1f);
        models[n]->SetShadows(false);
        models[n]->Attach(hmd->controllers[n], VRPOSE_GRIP);
    }

    // Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        // Display color changes based on controller input
        for (int n = 0; n < 2; ++n)
        {
            models[n]->SetColor(0.5f);
            if (hmd->controllers[n]->ButtonDown(VRBUTTON_PRIMARY)) models[n]->SetColor(1, 0, 0);
            if (hmd->controllers[n]->ButtonDown(VRBUTTON_SECONDARY)) models[n]->SetColor(0, 1, 0);
            if (hmd->controllers[n]->ButtonDown(VRBUTTON_GRIP)) models[n]->SetColor(0, 0, 1);
            if (hmd->controllers[n]->ButtonDown(VRBUTTON_THUMBSTICK)) models[n]->SetColor(1, 0.5, 0);
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
            }
        }
    }

    Shutdown();
    return 0;
}
```
