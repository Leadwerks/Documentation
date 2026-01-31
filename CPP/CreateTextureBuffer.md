# CreateTextureBuffer

This function creates a new texture buffer, for render-to-texture operations.

## Syntax

- shared_ptr<[TextureBuffer](TextureBuffer.md)> **CreateTextureBuffer**(const int width, const int height, const int colorattachments = 1, const bool depthattachment = true, const int samples = 0)

| Parameter | Description |
|---|---|
| width, height | dimensions of the texture buffer |
| colorattachments | number of color textures to add, between 0 and 6 |
| depthattachment | set to true to add a depth texture |
| samples | number of samples, or 0 for a non-MSAA texture |

## Returns

Returns a new texture buffer object.

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
    camera->SetFOV(70);

    //Create scenery
    auto box = CreateBox(world);
    
    auto cone = CreateCone(world);
    cone->SetPosition(1.25, 0, 0);
    cone->SetColor(0, 0, 1);

    auto sphere = CreateSphere(world);
    sphere->SetPosition(-1.25, 0, 0);
    sphere->SetColor(1, 0, 0);

    //Create camera and texture buffer
    auto texbuffer = CreateTextureBuffer(256, 256);
    auto cam2 = CreateCamera(world);
    cam2->SetClearColor(1, 1, 1);
    cam2->SetRenderTarget(texbuffer);

    //Create material
    auto mtl = CreateMaterial();
    auto tex = texbuffer->GetColorAttachment();
    mtl->SetTexture(tex);
    box->SetMaterial(mtl);
    cone->SetMaterial(mtl);
    sphere->SetMaterial(mtl);

    //Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        //Orient the texturebuffer camera
        cam2->SetPosition(0, 0, 0);
        cam2->Turn(0, 1, 0);
        cam2->Move(0, 0, -3);

        world->Update();
        world->Render(framebuffer);
    }
    return 0;
}
```
