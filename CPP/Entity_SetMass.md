# Entity::SetMass

This method sets the entity mass for physics interactivity.

## Syntax

- void **SetMass**(float mass)

| Parameter | Description |
| --- | --- |
| mass | mass to set in kilograms, or zero for immovable objects |

## Example

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

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
    camera->SetPosition(0, 1, -4);

    //Create light
    auto light = CreateBoxLight(world);
    light->SetRange(-10, 10);
    light->SetRotation(45, 35, 0);
    light->SetColor(2);

    //Create the ground
    auto ground = CreateBox(world, 10, 1, 10);
    ground->SetPosition(0, -0.5, 0);
    ground->SetColor(0, 1, 0);

    //Add some boxes
    auto box1 = CreateBox(world);
    box1->SetMass(1);
    box1->SetPosition(0, 5, 0);
    box1->SetElasticity(1);
    box1->SetColor(0, 0, 1);

    auto box2 = CreateBox(world);
    box2->SetMass(1);
    box2->SetPosition(0.5, 6.5, 0);
    box2->SetElasticity(0.25);
    box2->SetColor(0, 0, 1);

    //Very slow gravoty
    world->SetGravity(0, -2, 0);

    //Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        world->Update();
        world->Render(framebuffer);
    }
    return 0;
}
```
