# NavMesh::RandomPoint

This method returns a random valid position on the navigation mesh. This can be useful for placing enemies or making characters wander throughout a scene.

## Syntax

- [Vec3](Vec3) **RandomPoint**()

## Returns

Returns a valid position on the navigation mesh.

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

    //Create a framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Create a world
    auto world = CreateWorld();

    //Create a camera    
    auto camera = CreateCamera(world);
    camera->SetFov(70);
    camera->SetClearColor(0.125);
    camera->SetPosition(0, 3, -6);
    camera->SetRotation(35, 0, 0);

    //Create light
    auto light = CreateBoxLight(world);
    light->SetRange(-20, 20);
    light->SetArea(20, 20);
    light->SetRotation(35, 35, 0);
    light->SetColor(3);

    //Create scene
    auto ground = CreateBox(world, 10, 1, 10);
    ground->SetPosition(0, -0.5, 0);
    ground->SetColor(0, 1, 0);
    auto wall = CreateBox(world, 1, 2, 4);

    //Create navmesh
    auto navmesh = CreateNavMesh(world, 5, 4, 4);
    navmesh->Build();

    //Create player
    auto player = CreateCylinder(world, 0.4, 1.8);
    player->SetNavObstacle(false);
    player->SetColor(0, 0, 1);
    auto agent = CreateNavAgent(navmesh);
    player->Attach(agent);
    agent->SetPosition(navmesh->RandomPoint());

    //Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        //Press the space key to reposition the agent
        if (window->KeyHit(KEY_SPACE))
        {
            agent->SetPosition(navmesh->RandomPoint());
            player->Sync();
        }

        world->Update();
        world->Render(framebuffer);
    }
    return 0;
}
```
