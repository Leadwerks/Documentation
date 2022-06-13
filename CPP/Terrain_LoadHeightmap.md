# Terrain::LoadHeightmap

This method loads a heightmap onto the terrain.

## Syntax

- bool **LoadHeightmap**(const [WString](WString.md)& path, const LoadFlags flags = LOAD_DEFAULT)

## Example

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = GetDisplays();
   
    //Create a window
    auto window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[0], WINDOW_CENTER | WINDOW_TITLEBAR | WINDOW_CLIENTCOORDS);
    
    //Create a framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Create a world
    auto world = CreateWorld();

    //Create a camera
    auto camera = CreateCamera(world);
    camera->SetFOV(70);
    camera->SetClearColor(0.125);
    camera->SetRotation(45, 0, 0);
    camera->Move(0, 0, -500);
    
    //Create a light
    auto light = CreateLight(world, LIGHT_DIRECTIONAL);
    light->SetRotation(45, 45, 0);

    //Create terrain
    auto terrain = CreateTerrain(world, 1024);
    terrain->LoadHeightmap("https://raw.githubusercontent.com/Leadwerks/Documentation/master/Assets/Terrain/1024.r16");
    terrain->SetScale(1, 300, 1);
    terrain->SetPosition(0,-100,0);

    //Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        world->Update();
        world->Render(framebuffer, false);
    }
    return 0;
}
```
