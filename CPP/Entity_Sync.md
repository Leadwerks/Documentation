# Entity::Sync

This method synchronizes changes to an entity's orientation and color. Use this to disable rendering interpolation when an object is "teleported" to a new location.

## Syntax

- void **Sync**()

## Remarks

Rendering is performed on a separate thread, and is likely to run at a different frequency than the main thread. In the rendering thread, changes to an entity's position, rotation, scale, and color are smoothly inerpolated between the most recent two updates received, resulting in smooth motion. If for any reason you want motion and color forced to the current value when they are received, this command can be called after setting the orientation or color. For example, if you load a model and then place it in a position where it is supposed to appear, you may wish to call this command to ensure there is not any interpolation between its original and final positions.

Note that if physics are enabled it may introduce additional interpolation if the entity has a non-zero mass.

## Example

In this example the box on the top will use rendering interpolation, while the box on the bottom will continously call Sync() to prevent interpolation.

```c++
#include "UltraEngine.h"
#include "Components/Motion/Mover.hpp"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    //Get display
    auto displays = GetDisplays();

    //Create window
    auto window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[0], WINDOW_TITLEBAR | WINDOW_CENTER);

    //Create framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Create world
    auto world = CreateWorld();
    world->SetAmbientLight(0.1);
    world->RecordStats(true);

    //Create camera
    auto camera = CreateCamera(world);
    camera->SetClearColor(0.25);
    camera->SetPosition(0, 2, 0);
    camera->Move(0, 0, -5);

    //Build scene
    auto tunnel = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Underground/tunnel_t.glb");
    tunnel->SetRotation(0, 180, 0);
    tunnel->Staticize();

    auto cage = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Underground/fancage.glb");
    cage->Staticize();

    auto fan = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Underground/fanblades.glb");
    fan->SetPosition(0, 2, 0);
    auto mover = fan->AddComponent<Mover>();
    mover->rotationspeed.z = 300;

    auto light = CreatePointLight(world);
    light->SetColor(2, 2, 2);
    light->SetRange(10);
    light->SetPosition(0, 2, 2);
    light->SetColor(4.0);

    //Display text
    auto orthocam = CreateCamera(world, PROJECTION_ORTHOGRAPHIC);
    orthocam->SetClearMode(CLEAR_DEPTH);
    orthocam->SetRenderLayers(128);
    orthocam->SetPosition(float(framebuffer->size.x) * 0.5, float(framebuffer->size.y) * 0.5f);

    auto font = LoadFont("Fonts/arial.ttf");

    auto text = CreateSprite(world, font, "Shadow polygons: 0", 14.0 * displays[0]->scale);
    text->SetPosition(2, framebuffer->size.y - 16.0f * displays[0]->scale);
    text->SetRenderLayers(128);

    auto text2 = CreateSprite(world, font, "Press space to make the light static.", 14.0 * displays[0]->scale);
    text2->SetPosition(2, framebuffer->size.y - 16.0f * 2.0f * displays[0]->scale);
    text2->SetRenderLayers(128);

    //Main loop
    while (!window->KeyHit(KEY_ESCAPE) and !window->Closed())
    {
        world->Update();
        world->Render(framebuffer);

        if (window->KeyHit(KEY_SPACE))
        {
            light->Staticize();
            text2->SetHidden(true);
        }

        text->SetText("Shadow polygons: " + String(world->renderstats.shadowpolygons));
    }
    return 0;
}
```
