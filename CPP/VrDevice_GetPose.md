# VrDevice::GetPose

This method retrieves a device pose. This is a predefined point of interest on the physical device.

## Syntax

- [Mat4](Mat4.md) **GetPose**(VrPose pose, bool adjusted = true)

| Parameter | Description |
|---|---|
| pose | can be VRPOSE_EYELEFT or VRPOSE_EYERIGHT for headsets, or VRPOSE_GRIP or VRPOSE_AIM for controllers |
| adjusted | if set to true, the current HMD offset will be considered, otherwise the real-world orientation will be returned |

## Returns

Returns a 4x4 matrix describing the requested pose.

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

    // Create a model to show the head pose
    auto box = CreateBox(world, 0.25);
    box->SetColor(0, 0, 1);

    // Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        // Get the center between the eyes
        auto pose = hmd->GetPose(VRPOSE_EYELEFT);
        pose[3] = (pose[3] + hmd->GetPose(VRPOSE_EYERIGHT)[3]) * 0.5f;

        // Position in front of the player
        pose[3] = Vec4(0, pose[3].y, 1, 1);

        // Orient the model
        box->SetMatrix(pose);

        // Turn around to face the player
        box->Turn(0, 180, 0, true);

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
