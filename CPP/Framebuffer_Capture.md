# Framebuffer::Capture

This method can be used to capture a screenshot.

## Syntax

- void **Capture**()

## Remarks

This method will cause the contents of the framebuffer to be copied to a [Pixmap](Pixmap.md) when the first frame is rendered after the next call to [World::Render](World_Render.md). The captured image will be available in the array returned by [Framebuffer:GetCaptures](Framebuffer_GetCaptures.md). One frame will be captured for each call to this method.

## Example

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

void main(const char* args, const int argc)
{
    //Get the displays
    auto displays = GetDisplays();

    //Create a window
    auto window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[0], WINDOW_TITLEBAR | WINDOW_CENTER);

    //Create a framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Create a world
    auto world = CreateWorld();

    //Create a camera
    auto camera = CreateCamera(world);
    camera->SetClearColor(0.125f);
    camera->SetPosition(0, 0, -2);

    //Create a light
    auto light = CreateBoxLight(world);
    light->SetRotation(45, 35, 0);
    light->SetRange(-10, 10);
    light->SetColor(2);

    //Create a model
    auto box = CreateBox(world);
    box->SetColor(0, 0, 1);

    //Main loop
    while (!window->Closed() and !window->KeyHit(KEY_ESCAPE))
    {
        //Rotate the model
        box->Turn(0, 1, 0);

        //Press the space key to queue a screenshot
        if (window->KeyHit(KEY_SPACE)) framebuffer->Capture();

        //Look for captured frames
        auto caps = framebuffer->GetCaptures();
        for (auto pixmap : caps)
        {
            auto path = GetPath(PATH_DESKTOP) + "/screenshot.jpg";
            pixmap->Save(path);
            RunFile(path);
        }

        //Update world
        world->Update();

        //Render world
        world->Render(framebuffer, true);
    }
}
```
