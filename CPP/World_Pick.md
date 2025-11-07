# World::Pick

This method performs a line segment intersection test on all the entities in the world.

## Syntax

- [PickInfo](PickInfo.md) **Pick**(const [xVec3](xVec3.md)& p0, const [xVec3](xVec3.md)& p1, const dFloat radius = 0.0, const bool closest = false, bool filter(shared_ptr<[Entity](Entity.md)\>, shared_ptr<[Object](Object.md)\>) = NULL, shared_ptr<[Object](Object.md)\> extra = NULL)
- [PickInfo](PickInfo.md) **Pick**(const dFloat x0, const dFloat y0, const dFloat z0, const dFloat x1, const dFloat y1, const dFloat z1, const dFloat radius = 0.0, const bool closest = false, bool filter(shared_ptr<[Entity](Entity.md)\>, shared_ptr<[Object](Object.md)\>) = NULL, shared_ptr<[Object](Object.md)\> extra = NULL)

| Parameter | Description |
| --- | --- |
| p0, (x0, y0, z0) | line start position |
| p1, (x1, y1, z1) | line end position |
| radius | if greater than zero a swept sphere intersection test will be performed |
| closest | if set to true the closest intersected point will be found, otherwise the routine will return on the first hit |
| filter | optional callback to filter objects |
| extra | optional extra value to pass to filter |

## Returns

If the line segment intersects the entity, the resulting PickInfo's *success* member will be set to true, otherwise it will be false.

If a filter callback is provided it will be called for each entity that is evaluated. If the callback returns true the entity will be tested, otherwise it will be skipped.

## Example

![](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/World_Pick.gif)

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

bool PickFilter(std::shared_ptr<Entity> entity, std::shared_ptr<Object> extra) {
    if (entity->GetCollider() == nullptr) { return false; }
    return true;
}

int main(int argc, const char* argv[])
{
    // Get the displays
    auto displays = GetDisplays();
    
    //Create window
    auto window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[0], WINDOW_CENTER | WINDOW_TITLEBAR);
    
    //Create world
    auto world = CreateWorld();
    
    //Create framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Set up camera
    auto camera = CreateCamera(world);
    camera->SetClearColor(0.125);
    camera->SetFov(70);
    camera->SetPosition(0, 2, -3);
    camera->SetRotation(25, 0, 0);
    
    //Add a light
    auto light = CreateDirectionalLight(world);
    light->SetRotation(35, 45, 0);
    light->SetColor(2);

    //Set up the scene
    auto floor = CreatePlane(world, 100, 100);
    floor->Move(0, -1, 0);

    auto b1 = CreateBox(world, 2.0f);
    b1->SetPosition(-3.0f, 0.0f, 0.0f);
    b1->SetColor(1, 0, 0);

    auto b2 = CreateBox(world, 2.0f);
    b2->SetColor(0.0f, 0.0f, 1.0f);
    b2->SetPosition(3.0f, 0.0f, 2.0f);
    b2->SetRotation(0.0f, 45.0f, 0.0f);

    auto pivot = CreatePivot(world);
    
    auto rod_scale = 5.0f;
    auto rod = CreateCylinder(world, 0.05f);
    rod->SetCollider(nullptr);
    rod->SetParent(pivot);
    rod->SetRotation(90.0f, 0.0f, 0.0f);
    rod->SetPosition(0.0f, 0.0f, rod_scale / 2.0f);
    rod->SetScale(1.0f, rod_scale, 1.0f);

    auto sphere = CreateSphere(world, 0.25f);
    sphere->SetCollider(nullptr);
    sphere->SetParent(pivot);
    sphere->SetColor(0, 1, 0);
    sphere->SetPosition(0.0f, 0.0f, rod_scale);

    auto spin_speed = 0.5f;
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        pivot->Turn(0.0f, spin_speed, 0.0f);

        auto target_pos = Vec3(0.0f, 0.0f, rod_scale);
        target_pos = TransformPoint(target_pos, Mat4(), pivot->GetMatrix(true).Inverse());

        // Perform a ray cast
        auto pick_info = world->Pick(pivot->GetPosition(true), target_pos, 0.25f, true, PickFilter);
        if (pick_info.success) {
            sphere->SetPosition(pick_info.position, true);
        }
        else {
            sphere->SetPosition(target_pos, true);
        }

        // Update the world
        world->Update();

        // Render the world
        world->Render(framebuffer);
    }
    return 0;
}
```
