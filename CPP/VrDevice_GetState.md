# VrDevice::GetState

This method returns the current state of the device.

## Syntax

VrDeviceState **GetState**()

## Returns

VRDEVICESTATE_INACTIVE is returned if the device is not detected.

VRDEVICESTATE_STARTING is returned if the device is an [Hmd](Hmd.md) and is currently starting up.

VRDEVICESTATE_IDLE is returned for devices that are detected but not currently in use by the player.

VRDEVICESTATE_ACTIVE is returned for devices that are currently in use by the player.

## Remarks

You can also listen for the EVENT_VRDEVICECHANGESTATE event to detect changes in a VR device state.

## Example

```cpp
#include "Leadwerks.h"

using namespace Leadwerks;

String StateName(const VrDeviceState state)
{
    if (state == VRDEVICESTATE_STARTING) return "Starting";
    if (state == VRDEVICESTATE_ACTIVE) return "Active";
    if (state == VRDEVICESTATE_IDLE) return "Idle";
    return "Inactive";
}

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

    VrDeviceState state[3] = { VRDEVICESTATE_INACTIVE, VRDEVICESTATE_INACTIVE, VRDEVICESTATE_INACTIVE };

    // Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        // Get headset state
        auto currentstate = hmd->GetState();
        if (currentstate != state[0])
        {
            state[0] = currentstate;
            Print("Headset state: " + StateName(currentstate));
        }

        // Get left controller state
        currentstate = hmd->controllers[0]->GetState();
        if (currentstate != state[1])
        {
            state[1] = currentstate;
            Print("Left controller state: " + StateName(currentstate));
        }

        // Get roght controller state
        currentstate = hmd->controllers[1]->GetState();
        if (currentstate != state[2])
        {
            state[2] = currentstate;
            Print("Right controller state: " + StateName(currentstate));
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
