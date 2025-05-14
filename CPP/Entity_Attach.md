# Entity::Attach

This method attaches an entity to a model bone or a navigation agent. This provides a way of "gluing" an entity to a non-entity object.

## Syntax

- bool **Attach**(shared_ptr<[Model](Model.md)> model, shared_ptr<[Bone](Bone.md)> bone)
- bool **Attach**(shared_ptr<[NavAgent](NavAgent.md)> agent)
- bool **Attach**(shared_ptr<[VrDevice](VrDevice.md)> device)

| Parameter | Description |
| --- | --- |
| model | model to attach entity to |
| bone | skeleton bone to attach entity to |
| agent | navigation agent to attach entity to |
| device | VR device to attach entity to |

## Returns

Returns true if the attachment is valid, otherwise false is returned.

## Remarks

For bone attachments, the bone must belong to the skeleton the model is currently using.

The entity's local orientation at the time this method is called will be used to orient around the attachment.

A bone's scale will be disregarded in the entity placement.

## Example

This example will load an animated model and add some headgear to keep him warm.

![](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/entity_attach.jpg)

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
    auto head = model->skeleton->FindBone("b_Head_05");
    Vec3 rotation;

    //Model by alissvetlana
    //https://sketchfab.com/3d-models/hat-a7f54e87bea94730b4a1827ec1f770df
    auto hat = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Characters/hat.glb");
    hat->SetScale(0.025);
    hat->SetPosition(-0.3, 0.4, 0);
    hat->Attach(model, head);
    
    //Main loop
    while (window->Closed() == false and window->KeyHit(KEY_ESCAPE) == false)
    {
        world->Update();

        rotation.y = Cos(float(Millisecs()) / 10.0f) * 65.0f;
        neck->SetRotation(rotation);
       
        world->Render(framebuffer);
    }
    return 0;
}
```
