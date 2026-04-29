# Entity::Staticize

This method makes the entity static. A static entity cannot move and can be much more efficient to render. This operation is one-way and cannot be reversed.

## Syntax

- void **Staticize**()

## Example

This example shows how a scene can be optimized to make non-moving objects static, resulting in a lower shadow polygon count. In large scenes with many lights this can result in a large reduction of rendered polygons and faster performance.

![](https://github.com/UltraEngine/Documentation/raw/master/Images/API_Entity_MakeStatic.gif)

```c++
#include "Leadwerks.h"
#include "Components/Motion/Mover.hpp"

using namespace Leadwerks;

int main(int argc, const char* argv[])
{
    //Get display
    auto displays = GetDisplays();

    //Create window
    auto window = CreateWindow("Leadwerks", 0, 0, 1280, 720, displays[0], WINDOW_TITLEBAR | WINDOW_CENTER);

    //Create framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Create world
    auto world = CreateWorld();
    world->SetAmbientLight(0);
    world->RecordStats(true);

    //Create camera
    auto camera = CreateCamera(world);
    camera->SetClearColor(0.25);
    camera->SetPosition(0, 2, 0);
    camera->Move(0, 0, -5);

    //Build scene
    auto tunnel = LoadModel(world, "https://github.com/Leadwerks/Documentation/raw/master/Assets/Models/Underground/tunnel_t.glb");
    tunnel->SetRotation(0, 180, 0);
    tunnel->Staticize();

    auto cage = LoadModel(world, "https://github.com/Leadwerks/Documentation/raw/master/Assets/Models/Underground/fancage.glb");
    cage->Staticize();

    auto fan = LoadModel(world, "https://github.com/Leadwerks/Documentation/raw/master/Assets/Models/Underground/fanblades.glb");
    fan->SetPosition(0, 2, 0);
    
    auto light = CreatePointLight(world);
    light->SetRange(10);
    light->SetPosition(0, 2, 2);
    light->SetColor(2.0);

    //Display text
    auto font = LoadFont("Fonts/arial.ttf");

    auto text = CreateTile(world, font, "Shadow polygons: 0", 14.0 * displays[0]->scale);
    text->SetPosition(2, 2);
    
    auto text2 = CreateTile(world, font, "Press space to make the light static.", 14.0 * displays[0]->scale);
    text2->SetPosition(2, 22);
    
    //Main loop
    while (!window->KeyHit(KEY_ESCAPE) and !window->Closed())
    {
        fan->Turn(0,0,3);

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
