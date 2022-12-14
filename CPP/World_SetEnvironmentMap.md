# World::SetEnvironmentMap

This method sets the world skybox or specular and diffuse reflection maps.

## Syntax 

- void **SetEnvironmentMap**(shared_ptr<[Texture](Texture.md)\> texture, const EnvironmentMap id)

| Parameter | Description |
|---|---|
| texture | cubemap to set |
| id | environment map ID, may be ENVIRONMENT_BACKGROUND, ENVIRONMENT_SPECULAR, or ENVIRONMENT_DIFFUSE

## Example

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

const WString remotepath = "https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets";

int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = GetDisplays();

    //Create a window
    auto window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[0], WINDOW_CENTER | WINDOW_TITLEBAR);

    //Create a world
    auto world = CreateWorld();

    //Create a framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Create a camera
    auto camera = CreateCamera(world);
    camera->SetClearColor(0.125);
    camera->SetPosition(0, 0, -2);

    auto specmap = LoadTexture(remotepath + "/Materials/Environment/Storm/specular.dds");
    auto diffmap = LoadTexture(remotepath + "/Materials/Environment/Storm/diffuse.dds");

    world->SetEnvironmentMap(specmap, ENVIRONMENTMAP_BACKGROUND);
    world->SetEnvironmentMap(specmap, ENVIRONMENTMAP_SPECULAR);
    world->SetEnvironmentMap(diffmap, ENVIRONMENTMAP_DIFFUSE);

    auto mtl = CreateMaterial();
    mtl->SetRoughness(0.25);
    mtl->SetMetalness(0.5);

    auto ball = CreateSphere(world);
    ball->SetMaterial(mtl);

    //Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        world->Update();
        world->Render(framebuffer);
    }
    return 0;
}
```
