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
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = GetDisplays();

    //Create a window
    auto window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[0], WINDOW_CLIENTCOORDS | WINDOW_CENTER | WINDOW_TITLEBAR);

    //Create a framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Create a world
    auto world = CreateWorld();

    //Get the VR headset
    auto hmd = GetHmd(world);
    hmd->Start(framebuffer)

    //Environment maps
    auto specmap = LoadTexture("https://github.com/Leadwerks/Documentation/raw/master/Assets/Materials/Environment/footprint_court/specular.dds");
    auto diffmap = LoadTexture("https://github.com/Leadwerks/Documentation/raw/master/Assets/Materials/Environment/footprint_court/diffuse.dds");
    world->SetEnvironmentMap(specmap, ENVIRONMENTMAP_BACKGROUND);
    world->SetEnvironmentMap(specmap, ENVIRONMENTMAP_SPECULAR);
    world->SetEnvironmentMap(diffmap, ENVIRONMENTMAP_DIFFUSE);

    //Create a light
    auto light = CreateBoxLight(world);
    light->SetRotation(55, 35, 0);
    light->SetRange(-10, 10);
    light->SetColor(2);

    //Add a floor
    auto floor = CreateBox(world, 5, 1, 5);
    floor->SetPosition(0, -0.5, 0);
    auto mtl = CreateMaterial();
    mtl->SetTexture(LoadTexture("https://github.com/UltraEngine/Documentation/raw/master/Assets/Materials/Developer/griid_gray.dds"));
    floor->SetMaterial(mtl);

    //Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        world->Update();
        world->Render(framebuffer);
    }
    return 0;
}
```
