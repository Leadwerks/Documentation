# CreateCylinderCollider

This function creates a collision cylinder shape for physics interactions.

## Syntax

- shared_ptr<[Collider](Collider.md)> **CreateCapsuleCollider**(const float radius, const float height, const float x = 0.0, const float y = 0.0, const float z = 0.0, const float pitch = 0.0, const float yaw = 0.0, const float roll = 0.0)

- shared_ptr<[Collider](Collider.md)> **CreateCapsuleCollider**(const float radius, const float height, const [Vec3](Vec3.md)& offset, const [Vec3](Vec3.md)& rotation = 0.0)

|Parameter|Description|
|---|----|
|radius|radius of shape|
|height|height of shape|
|x|x component of shape offset|
|y|y component of shape offset|
|z|z component of shape offset|
|pitch|pitch of shape rotation|
|yaw|yaw of shape rotation|
|roll|roll of shape rotation|
|offset|offset of shape|
|rotation|rotation of shape|

## Returns

Returns a new collider object.

## Example

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    //Get the display list
    auto displays = GetDisplays();

    //Create a window
    auto window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[0], WINDOW_TITLEBAR | WINDOW_CENTER);

    //Create framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Create world
    auto world = CreateWorld();

    //Create camera
    auto camera = CreateCamera(world);
    camera->SetFOV(70);
    camera->Turn(15, 0, 0);
    camera->Move(0, 2, -8);
    camera->SetClearColor(0.125);

    //Create light
    auto light = CreateDirectionalLight(world);
    light->SetRotation(45, 35, 0);

    //Create ground
    auto ground = CreateBox(world, 10, 1, 10);
    ground->SetPosition(0, -0.5, 0);
    ground->SetColor(0, 1, 0);

    //Create model
    auto model = CreateCylinder(world, 0.5, 4);
    model->SetPosition(0, 5, 0);
    model->Turn(90, 10, 0);
    model->SetColor(0, 0, 1);
    model->SetMass(1);
    model->AddForce(100, 0, 0);

    //Create collider
    auto collider = CreateCapsuleCollider(0.5, 4);
    model->SetCollider(collider);

    while (window->Closed() == false and window->KeyHit(KEY_ESCAPE) == false)
    {
        world->Update();
        world->Render(framebuffer);
    }
    return 0;
}
```
