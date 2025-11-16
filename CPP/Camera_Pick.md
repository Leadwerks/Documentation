# Camera::Pick

This method performs a raycast at the specified screen coordinate.

## Syntax

- [PickInfo](PickInfo.md) Pick(shared_ptr<[Framebuffer](Framebuffer.md)\> framebuffer, float x, float y, float radius = 0.0, bool closest = false, bool filter(shared_ptr<[Entity](Entity.md)\>, shared_ptr<[Object](Object.md)\>) = NULL, shared_ptr<[Object](Object.md)\> extra = NULL)
- [PickInfo](PickInfo.md) Pick(shared_ptr<[Framebuffer](Framebuffer.md)\> buffer, [Vec2](Vec2.md) screencoord, float radius = 0.0, bool closest = false, bool filter(shared_ptr<[Entity](Entity.md)\>, shared_ptr<[Object](Object.md)\>) = NULL, shared_ptr<[Object](Object.md)\> extra = NULL)

| Parameter | Description |
| ----- | ----- |
| framebuffer | framebuffer to test with |
| screencoord, (x, y) | screen coordinate to pick |
| radius | pick sphere radius |
| closest | if true the closest point will be determined |
| filter | optional callback to filter objects |
| extra | extra value to send to filter callback |

## Returns

Returns a [PickInfo](PickInfo.md) structure. If the *success* member of the structure is true an object was hit, otherwise it will be false.

If a filter callback is provided it will be called for each entity that is evaluated. If the callback returns true the entity will be tested, otherwise it will be skipped.
  
## Example

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

bool PickFilter(std::shared_ptr<Entity> entity, std::shared_ptr<Object> extra)
{
    return true;
}

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

    //Create light
    auto light = CreateBoxLight(world);
    light->SetRange(-10, 10);
    light->SetRotation(15, 15, 0);
    light->SetColor(2);

    //Create camera
    auto camera = CreateCamera(world);
    camera->SetClearColor(0.125);
    camera->SetPosition(0, 0, -3);
    camera->SetFov(70);

    //Create scenery
    auto box = CreateBox(world);

    auto cone = CreateCone(world);
    cone->SetPosition(1.25, 0, 0);

    auto sphere = CreateSphere(world);
    sphere->SetPosition(-1.25, 0, 0);

    //Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        //Click on an object to change its color
        if (window->MouseHit(MOUSE_LEFT))
        {
            box->SetColor(1, 1, 1);
            cone->SetColor(1, 1, 1);
            sphere->SetColor(1, 1, 1);
            auto mousepos = window->GetMousePosition();
            auto pick = camera->Pick(framebuffer, mousepos.x, mousepos.y, 0, true, PickFilter, NULL);
            if (pick.success)
            {
                pick.entity->SetColor(1, 0, 0);
            }
        }

        world->Update();
        world->Render(framebuffer);
    }
    return 0;
}
```
