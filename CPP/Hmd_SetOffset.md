# Hmd::SetOffset

Sets the offset position and rotation, for player movement.

## Syntax

- void **SetOffset**([Vec3](Vec3.md) position, [Vec3](Vec3.md) rotation = Vec3(0))

| Parameter | Description |
|---|---|
| position | offset translation |
| rotation | offset rotation |

## Example

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

    // Some variables for the controller input
    Vec3 position, rotation;
    bool pushed[2] = { false, false };
    const float limit = 0.99f;

    // Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        //-----------------------------------------------------------------------
        // See the VRPlayer class for full locomotion support
        //-----------------------------------------------------------------------

        // Simple example movement on the Z axis with the left controller
        Vec2 axis = hmd->controllers[0]->GetAxis(VRAXIS_THUMBSTICK);
        if (not pushed[0])
        {
            if (axis.Length() > limit)
            {
                pushed[0] = true;
                float z = 1;
                if (axis.y < 0.0) z = -1;
                Mat4 pose = hmd->GetPose(VRPOSE_EYELEFT);
                Mat4 identity;
                Vec3 delta = TransformVector(0, 0, z, pose, identity);
                delta.y = 0;
                if (delta.x != 0.0f or delta.y != 0.0f) delta = delta.Normalize();
                position += delta;
                hmd->SetOffset(position, rotation);
            }
        }
        else
        {
            if (axis.Length() < 0.01f) pushed[0] = false;
        }

        // Simple example rotation on the Y axis with the right controller
        axis = hmd->controllers[1]->GetAxis(VRAXIS_THUMBSTICK);
        if (not pushed[1])
        {
            if (axis.Length() > limit)
            {
                pushed[1] = true;

                float angle = 45;
                if (axis.x < 0.0) angle = -45;

                Mat4 offsetmatrix = Mat4(position, rotation, 1.0f);
                Vec3 hmdpos = (hmd->GetPose(VRPOSE_EYELEFT)[3].xyz() + hmd->GetPose(VRPOSE_EYERIGHT)[3].xyz()) * 0.5f;

                // Recenter the offset space around the headset
                Mat4 identity;
                Vec3 relativeoffset = TransformPoint(hmdpos, identity, offsetmatrix);

                // Rotate the offset space
                offsetmatrix[3].x = hmdpos.x; offsetmatrix[3].z = hmdpos.z;
                Mat4 rmat = Mat4(Vec3(0), Vec3(0, angle, 0), Vec3(1));
                offsetmatrix *= rmat;
                offsetmatrix[3].x = hmdpos.x; offsetmatrix[3].z = hmdpos.z;

                // Shift the offset space away from the headset
                relativeoffset = TransformVector(relativeoffset, offsetmatrix, identity);
                offsetmatrix[3].x -= relativeoffset.x; offsetmatrix[3].z -= relativeoffset.z;
                position = offsetmatrix[3].xyz();

                rotation.y += angle;
                hmd->SetOffset(position, rotation);
            }
        }
        else
        {
            if (axis.Length() < 0.01f) pushed[1] = false;
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
