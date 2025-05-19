# Framebuffer::GetCaptures

This method returns an array of screen capture images that have been recorded by calling [Framebuffer::Capture](Framebuffer_Capture.md).

## Syntax

- std::vector<[Pixmap](Pixmap.md)> **GetCaptures**()

## Returns

Returns an array of captured frames and clears the stored items.

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
            auto path = GetPath(PATH_DESKTOP) .. "/screenshot.jpg";
            pixmap:Save(path);
            RunFile(path);
        }

        //Update world
        world->Update();

        //Render world
        world->Render(framebuffer, true);
    }
}
```
