# LoadModel

This function loads a model from a file.

## Syntax

- shared_ptr<[Model](Model.md)\> **LoadModel**(const [WString](WString.md)& path, const LoadFlags flags = LOAD_DEFAULT)
- shared_ptr<[Model](Model.md)\> **LoadModel**(shared_ptr<[Stream](Stream.md)\> stream, const LoadFlags flags = LOAD_DEFAULT)

| Parameter | Description |
|---|---|
| path | file path to read from |
| stream | stream to read from |

## Returns

Returns the loaded model if successful, otherwise NULL is returned.

## Remarks

Ultra Engine natively supports glTF, OBJ, and Leadwerks MDL files. MDL files with DDS textures will provide the fastest loading.

## Example

![](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/loadplugin.jpg)

```c++
#include "UltraEngine.h"
#include "ComponentSystem.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = GetDisplays();

    //Create a window
    auto window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[0], WINDOW_CENTER | WINDOW_TITLEBAR);

    //Create a world
    auto world = CreateWorld();
    world->SetAmbientLight(0);

    //Create a framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Load FreeImage plugin
    auto plg = LoadPlugin("Plugins/FITextureLoader");

    //Load model
    //Cyber Samurai by Khoa Minh: https://sketchfab.com/3d-models/cyber-samurai-26ccafaddb2745ceb56ae5cfc65bfed5
    auto model = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Characters/cyber_samurai.glb");
    model->Turn(0, 180, 0, true);

    //Environment maps
    auto specmap = LoadTexture("https://github.com/UltraEngine/Assets/raw/main/Materials/Environment/footprint_court/specular.dds");
    auto diffmap = LoadTexture("https://github.com/UltraEngine/Assets/raw/main/Materials/Environment/footprint_court/diffuse.dds");
    world->SetEnvironmentMap(diffmap, ENVIRONMENTMAP_BACKGROUND);
    world->SetEnvironmentMap(specmap, ENVIRONMENTMAP_SPECULAR);
    world->SetEnvironmentMap(diffmap, ENVIRONMENTMAP_DIFFUSE);

    //Create a camera    
    auto camera = CreateCamera(world);
    camera->SetClearColor(0.125);
    camera->SetPosition(0, 1.4, -1);
    camera->SetFov(70);

    //Activate the component system
    RegisterComponents();

    //Add camera controls
    camera->AddComponent<CameraControls>();

    //Create light
    auto light = CreateBoxLight(world);
    light->SetRange(-10, 10);
    light->SetArea(15, 15);
    light->SetRotation(45, 35, 0);
    light->SetColor(1.2);

    //Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        world->Update();
        world->Render(framebuffer);
    }
    return 0;
}
```
