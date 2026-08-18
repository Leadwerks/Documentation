# Model::SetVertexColor

Vertex colors are normally part of the [Mesh](Mesh.md) object and are shared across different instances of a model that use the same mesh. This method sets a vertex color for the model that is unique for this instance of the model.

## Syntax
- void **SetVertexColor**(const int lod, const int mesh, const int v, const [Vec4](Vec4.md)& color)

| Parameter | Description |
|---|---|
| lod | lod index | 
| mesh | mesh index | 
| v | vertex index | 
| color | color to set |

## Example

```c++
#include "Leadwerks.h"

using namespace Leadwerks;

int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = GetDisplays();

    //Create a window
    auto window = CreateWindow("Leadwerks", 0, 0, 1280, 720, displays[0], WINDOW_CENTER | WINDOW_TITLEBAR);

    //Create a world
    auto world = CreateWorld();

    //Create a framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Create a camera
    auto camera = CreateCamera(world);
    camera->SetClearColor(0.125);
    camera->SetPosition(0, 0, -2);

    //Create a light
    auto light = CreateBoxLight(world);
    light->SetRotation(45, 35, 0);
    light->SetRange(-10, 10);
    light->SetColor(2);

    //Create a model
    auto a = CreateBox(world);
    a->SetPosition(-1, -0.75, 0);

    //Create an instance of the model
    auto b = a->Instantiate(world)->As<Model>();
    b->SetPosition(1, -0.75, 0);

    //Create a model
    auto c = CreateCylinder(world);
    c->SetPosition(-1, 0.75, 0);

    //Create an instance of the model
    auto d = c->Instantiate(world)->As<Model>();
    d->SetPosition(1, 0.75, 0);

    //Apply unique vertex colors to the instanced boxes
    for (int v = 0; v < b->lods[0]->meshes[0]->CountVertices(); ++v)
    {        
        a->SetVertexColor(0, 0, v, Vec4(0.0f, Random(0.0f, 1.0f), 0.0f, 1.0f) );
        b->SetVertexColor(0, 0, v, Vec4(Random(0.0f, 1.0f), Random(0.0f, 1.0f), Random(0.0f, 1.0f), 1.0f) );
    }

    //Apply unique vertex colors to the second cylinder instance
    for (int v = 0; v < d->lods[0]->meshes[0]->CountVertices(); ++v)
    {
        d->SetVertexColor(0, 0, v, Vec4(0.0f, Random(0.0f, 1.0f), Random(0.0f, 1.0f), 1.0f));
    }

    //Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        a->Turn(0.5, 1, 0);
        b->Turn(0.5, 1, 0);
        c->Turn(0.5, 1, 0);
        d->Turn(0.5, 1, 0);

        world->Update();
        world->Render(framebuffer);
    }
    return 0;
}
```
