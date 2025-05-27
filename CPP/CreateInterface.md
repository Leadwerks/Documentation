# CreateInterface

This function creates a new graphical user interface for desktop applications or in-game interfaces.

## Syntax

- shared_ptr<[Interface](Interface.md)\> **CreateInterface**(shared_ptr<[Window](Window.md)\> window)
- shared_ptr<[Interface](Interface.md)\> **CreateInterface**(shared_ptr<[Camera](Camera.md)\> camera, shared_ptr<[Font](Font.md)\> font, [iVec2](iVec2.md)\> size)

| Parameter | Description |
| --- | --- |
| window | window to create the user interface on |
| camera | camera to create the interface in, for 3D graphics |
| font | font to use, for 3D graphics |
| size | interface dimensions, for 3D graphics |

## Returns

Returns a new interface object.

## Example

Several examples are shown below to demonstrate different types of programs you can create.

The first example shows how to create an interface directly on a window for an event-based desktop application.

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = GetDisplays();

    //Create window
    auto window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[0]);

    //Create user interface
    auto ui = CreateInterface(window);

    //Create widget
    iVec2 sz = ui->background->ClientSize();
    auto button = CreateButton("Button", sz.x / 2 - 75, sz.y / 2 - 15, 150, 30, ui->background);

    while (true)
    {
        const Event ev = WaitEvent();
        switch (ev.id)
        {
        case EVENT_WINDOWCLOSE:
            if (ev.source == window)
            {
                return 0;
            }
            break;
        }
    }
    return 0;
}
```

The second example shows how to create an interface that appears in a 3D rendering viewport on top of the scene. Note that in this example you must send events to the interface with the [ProcessEvent](Interface_ProcessEvent.md) method.

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = GetDisplays();

    //Create window
    auto window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[0]);

    //Create framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Create world
    auto world = CreateWorld();

    //Create main camera
    auto camera = CreateCamera(world);
    camera->SetPosition(0, 0, -3);

    //Create a model
    auto box = CreateBox(world);

    //Create a light
    auto light = CreateBoxLight(world);
    light->SetRange(-5, 5);
    light->SetRotation(34, 45, 0);

    //Load a font
    auto font = LoadFont("Fonts/arial.ttf");

    //Create user interface with a semi-transparent background
    auto ui = CreateInterface(world, font, framebuffer->size);
    ui->background->SetColor(0, 0, 0, 0.5);

    //Create widget
    iVec2 sz = ui->background->ClientSize();
    auto button = CreateButton("Button", sz.x / 2 - 75, sz.y / 2 - 15, 150, 30, ui->background);

    //Create camera
    auto orthocamera = CreateCamera(world, PROJECTION_ORTHOGRAPHIC);
    orthocamera->SetClearMode(CLEAR_DEPTH);
    orthocamera->SetPosition(float(framebuffer->size.x) * 0.5f, float(framebuffer->size.y) * 0.5f, 0);

    //UI will only appear in orthographic camera
    orthocamera->SetRenderLayers(2);
    ui->SetRenderLayers(2);

    while (true)
    {
        box->Turn(0, 1, 0);

        while (PeekEvent())
        {
            const Event ev = WaitEvent();
            switch (ev.id)
            {
            case EVENT_WINDOWCLOSE:
                if (ev.source == window)
                {
                    return 0;
                }
                break;
            default:
                ui->ProcessEvent(ev);
                break;
            }
        }

        world->Update();
        world->Render(framebuffer);
    }
    return 0;
}
```

The last example shows how to create an interactive user interface that is displayed on a 3D surface:

```c++
#include "UltraEngine.h"
#include "ComponentSystem.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = GetDisplays();

    //Create window
    auto window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[0]);

    //Create framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Create world
    auto world = CreateWorld();

    //Load a font
    auto font = LoadFont("Fonts/arial.ttf");

    //Create a camera
    auto camera = CreateCamera(world);
    camera->SetPosition(0, 0, -2);
    camera->SetClearColor(0.125);

    //Camera controls
    camera->AddComponent<CameraControls>();

    //Create a model
    auto box = CreateBox(world);
    box->SetRotation(0, 45, 0);
    box->SetPickMode(PICK_MESH);

    //Create light
    auto light = CreateBoxLight(world);
    light->SetRotation(45, 35, 0);
    light->SetRange(-10, 10);
    light->SetColor(4);

    //Create user interface
    auto ui = CreateInterface(world, font, iVec2(256));
    ui->SetRenderLayers(2);

    //Create widget
    iVec2 sz = ui->background->ClientSize();
    auto button = CreateButton("Button", sz.x / 2 - 75, sz.y / 2 - 15, 150, 30, ui->background);

    //Create camera
    auto uicamera = CreateCamera(world, PROJECTION_ORTHOGRAPHIC);
    uicamera->SetClearColor(1, 0, 0, 1);
    uicamera->SetPosition(128.0f, 128.0f, 0);
    uicamera->SetRenderLayers(2);
    uicamera->SetRealtime(false);

    auto texbuffer = CreateTextureBuffer(256, 256, 1, true, 0);
    uicamera->SetRenderTarget(texbuffer);

    auto mtl = CreateMaterial();
    mtl->SetTexture(texbuffer->GetColorAttachment(0));
    box->SetMaterial(mtl);

    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        while (PeekEvent())
        {
            Event ev = WaitEvent();
            switch (ev.id)
            {
            case EVENT_MOUSEDOWN:
            case EVENT_MOUSEUP:
            case EVENT_MOUSEMOVE:
                auto pick = camera->Pick(framebuffer, ev.position.x, ev.position.y, 0, true);
                if (pick.success and pick.entity == box)
                {
                    ev.position.x = Round(pick.texcoords[0].x * 256.0f);
                    ev.position.y = Round(pick.texcoords[0].y * 256.0f);
                    ui->ProcessEvent(ev);
                    uicamera->Render();
                }
                break;
            }
        }

        world->Update();
        world->Render(framebuffer);
    }
    return 0;
}
```
