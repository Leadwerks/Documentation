# CreateTerrain

This function creates a new terrain entity.

## Syntax

- shared_ptr<[Terrain](Terrain.md)\> **CreateTerrain**(shared_ptr<[World](World.md)\> world, const int width, const int height)
- shared_ptr<[Terrain](Terrain.md)\> **CreateTerrain**(shared_ptr<[World](World.md)\> world, const [iVec2](iVec2.md) resolution)

| Parameter | Description |
|---|---|
| world | world to create the terrain in |
| resolution, (width, height) | number of terrain points on each axis |

## Example

```c++
#include "UltraEngine.h"
#include "ComponentSystem.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    //Get the display list
    auto displays = GetDisplays();

    //Create a window
    auto window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[0], WINDOW_CENTER | WINDOW_TITLEBAR);

    //Create a world
    auto world = CreateWorld();
    world->SetAmbientLight(0);

    //Create a framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Create a camera
    auto camera = CreateCamera(world);
    camera->SetFov(70);
    camera->SetPosition(0, 50, 0);
    camera->SetRotation(45, 0, 0);
    camera->SetClearColor(0.125);

    //Sunlight
    auto light = CreateDirectionalLight(world);
    light->SetRotation(45, 35, 0);
    light->SetColor(2);

    //Create terrain
    auto terrain = CreateTerrain(world, 512, 512);
    terrain->LoadHeightmap("https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets/Terrain/512.r16");
    terrain->SetScale(1, 100, 1);

    //Create base material
    auto ground = CreateMaterial();
    auto diffusemap = LoadTexture("https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets/Materials/Ground/river_small_rocks_diff_2k.dds");
    auto normalmap = LoadTexture("https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets/Materials/Ground/river_small_rocks_nor_gl_2k.dds");
    ground->SetTexture(diffusemap, TEXTURE_BASE);
    ground->SetTexture(normalmap, TEXTURE_NORMAL);
    terrain->SetMaterial(ground);

    //Create paint material
    auto rocks = CreateMaterial();
    diffusemap = LoadTexture("https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets/Materials/Ground/Rocks_Dirt_Ground_2k.dds");
    normalmap = LoadTexture("https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets/Materials/Ground/Rocks_Dirt_Ground_2k_dot3.dds");
    auto dispmap = LoadTexture("https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets/Materials/Ground/Rocks_Dirt_Ground_2k_disp.dds");
    rocks->SetTexture(diffusemap, TEXTURE_BASE);
    rocks->SetTexture(normalmap, TEXTURE_NORMAL);
    rocks->SetTexture(dispmap, TEXTURE_DISPLACEMENT);

    int rocklayer = terrain->AddLayer(rocks);

    //Apply material based on terrain slope
    for (int x = 0; x < terrain->resolution.x; ++x)
    {
        for (int y = 0; y < terrain->resolution.y; ++y)
        {
            float slope = terrain->GetSlope(x, y);
            if (slope > 15.0f)
            {
                float wt = Min((slope - 15.0f) / 10.0f, 1.0f);
                terrain->SetLayerWeight(rocklayer, x, y, wt);
            }
        }
    }

    //Camera controls
    camera->AddComponent<CameraControls>();

    //Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        world->Update();
        world->Render(framebuffer);
    }
    return 0;
}
```
