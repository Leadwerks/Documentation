# Bone::SetScale

This method can be used to manually scale a bone. You can control skinned models enirely in code or apply your own movements on top of animation.

## Syntax

- void **SetScale**(const float scale)

| Parameter | Description |
|---|---|
| scale | uniform scale to set |

## Remarks

To combine programmatic movement with animation, this method should be called after [World::Update](World_Update.md) and before [World::Render](World_Render.md).

## Example

This example will load and display an animated model, but we will add code to give the character a supersized noggin.

![](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/bone_setscale.jpg)

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
    camera->SetClearColor(0.125);
    camera->SetFOV(70);
    camera->Move(0, 2, -8);

    //Create light
    auto light = CreateBoxLight(world);
    light->SetRotation(45, 35, 0);
    light->SetRange(-10, 10);

    //Model by PixelMannen
    //https://opengameart.org/content/fox-and-shiba
    auto model = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Characters/Fox.glb");
    model->SetScale(0.05);
    model->Animate(1);
    model->SetRotation(0, -90, 0);

    auto neck = model->skeleton->FindBone("b_Neck_04");
    Vec3 rotation;

    //Main loop
    while (window->Closed() == false)
    {
        world->Update();

        rotation.y = Cos(float(Millisecs()) / 10.0f) * 65.0f;
        neck->SetRotation(rotation);
        neck->SetScale(2);

        world->Render(framebuffer);
    }
    return 0;
}
```
