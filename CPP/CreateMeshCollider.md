# CreateMeshCollider

This function creates a collider from a mesh or model.

## Syntax
- shared_ptr<[Collider](Collider.md)\> **CreateMeshCollider**(shared_ptr<[Mesh](Mesh.md)\> geometry)
- shared_ptr<[Collider](Collider.md)\> **CreateMeshCollider**(shared_ptr<[Model](Model.md)\> geometry)

## Parameters

| Name | Description |
|---|---|
| geometry | mesh or model to build the collision from |

## Remarks

An entity that uses a mesh collider will remain stationary and will not react to physics forces, although other objects will collide with it.

## Example

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    //Get display list
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
    camera->Move(0, 0, -12);
    camera->SetClearColor(0.125);

    //Create light
    auto light = CreateDirectionalLight(world);
    light->SetRotation(45, 35, 0);

    //Load model
    auto model = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Structures/wooden%20bridge.glb");
    model->SetRotation(0, 90, 0);

    //Create collision
    auto collision = CreateMeshCollider(model);
    model->SetCollider(collision);
    model->SetCollisionType(COLLISION_SCENE);

    //Add some objects to show collision
    vector<shared_ptr<Entity> > boxes;
    for (int n = 0; n < 5; ++n)
    {
        auto box = CreateBox(world);
        box->SetScale(2);
        box->SetPosition(Random(-2, 2), 8 + 3 * n, Random(-2, 2));
        box->SetColor(0, Random(), Random());
        box->SetMass(1);
        boxes.push_back(box);
    }

    while (window->Closed() == false and window->KeyHit(KEY_ESCAPE) == false)
    {
        world->Update();
        world->Render(framebuffer);
    }
    return 0;
}
```
