# LoadCollider #
This function loads a collision shape from a [collision file](Collision_File_Format.md). Collision objects can be saved to a file by calling the [Save](CPP_Asset_Save.md) method.

## Syntax ##
- shared_ptr<[Collider](CPP_Collision.md)\> **LoadCollider**(const string& path, const [LoadFlags](LoadFlags.md) flags = LOAD_DEFAULT)
- shared_ptr<[Collider](CPP_Collision.md)\> **LoadCollider**(const wstring& path, const [LoadFlags](LoadFlags.md) flags = LOAD_DEFAULT)
- shared_ptr<[Collider](CPP_Collision.md)\> **LoadCollider**(shared_ptr<[Stream](CPP_Stream.md)\> stream, const [LoadFlags](LoadFlags.md) flags = LOAD_DEFAULT)

## Parameters ##
|Name|Description|
|---|---|
|path|file path to open|
|stream|open stream to read from|
|flags|optional load settings|

## Returns ##
Returns the loaded collider object if it was successfully loaded, otherwise NULL is returned.

## Example ##
```c++
#include "pch.h"
#include "Project.h"

int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = ListDisplays();

    //Create a window
    auto window = CreateWindow(displays[0], L"", 0, 0, 1280, 720, WINDOW_CENTER | WINDOW_TITLEBAR);

    //Create a framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Create a world
    auto world = CreateWorld();

    //Create a camera
    auto camera = CreateCamera(world);
    camera->SetClearColor(0.125);
    camera->Move(0, 1, -3);
    camera->SetFOV(70);

    //Create light
    auto light = CreateLight(world, LIGHT_DIRECTIONAL);
    light->SetRotation(45, 35, 0);

    //Create ground
    auto ground = CreateBox(world, 10, 1, 10);
    ground->SetPosition(0, -0.5, 0);

    //Load model
    auto model = LoadModel(world, "https://github.com/Leadwerks/Documentation/raw/master/Assets/Models/Containers/crate01.glb");
    model->SetPosition(0, 3, 0);
    model->SetRotation(0, 0, 15);
    model->SetMass(1);

    //Load collision
    auto collision = LoadCollider("https://github.com/Leadwerks/Documentation/raw/master/Assets/Models/Containers/crate01.phy");
    model->SetCollider(collision);

    while (window->Closed() == false)
    {
        world->Update();
        world->Render(framebuffer);
    }
    return 0;
}
```
