# Entity::AddComponent

This method adds a component to the entity.

## Syntax

- shared_ptr<T\> **AddComponent**<T\>()
- shared_ptr<[Component](Component.md)\> **AddComponent**(const [WString](WString.md)& name)

| Parameter | Description |
|---|---|
| T | C++ type, must be derived from the [Component](Component.md) class |
| name | name of a Lua component |

## Returns

Returns a new component if successful, otherwise NULL is returned.

## Example

```c++
#include "UltraEngine.h"
#include "Components/Mover.hpp"

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
    camera->SetFov(70);
    camera->SetPosition(0, 0, -3);

    //Create a light
    auto light = CreateBoxLight(world);
    light->SetRotation(35, 45, 0);
    light->SetRange(-10, 10);

    //Create a box
    auto box = CreateBox(world);
    box->SetColor(0,0,1);

    //Entity component system
    auto component = box->AddComponent<Mover>();
    component->rotationspeed.y = 45;

    //Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        world->Update();
        world->Render(framebuffer);
    }
    return 0;
}
```
