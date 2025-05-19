# Skeleton::AddHook


## Syntax

- **AddHook**(const int sequence, const int frame, void hook())

## Example

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

void Hook(shared_ptr<Skeleton> skeleton, shared_ptr<Object> extra)
{
    auto entity = extra->As<Entity>();
    entity->SetColor(Random(), Random(), Random());
}
 
int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = GetDisplays();

    //Create a window
    auto window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[0], WINDOW_CENTER | WINDOW_TITLEBAR);

    //Create a framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Create a world
    auto world = CreateWorld();

    //Create a camera
    auto camera = CreateCamera(world);
    camera->SetClearColor(0.125);
    camera->SetFov(70);
    camera->Move(0, 2, -8);

    //Create light
    auto light = CreateBoxLight(world);
    light->SetRotation(45, 35, 0);
    light->SetRange(-10, 10);
    light->SetArea(20, 20);

    //Create ground
    auto ground = CreateBox(world, 10, 1, 10);
    ground->SetColor(0, 1, 0);
    ground->SetPosition(0, -0.5, 0);

    //Load a model
    auto model = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Characters/Fox.glb");
    model->SetScale(0.05);
    model->SetRotation(0, -90, 0);
    model->Animate(1);

    //Add an animation callback function
    model->skeleton->AddHook(1, 0, Hook, model);

    //Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        world->Update();
        world->Render(framebuffer);
    }
    return 0;
}
```
