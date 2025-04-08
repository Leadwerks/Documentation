# CreateSprite

This function creates a sprite that displays a rectangle or a string of text.

## Syntax

- shared_ptr<[Sprite](Sprite.md)\> **CreateSprite**(shared_ptr<[World](World.md)\> world, const float width, const float height, const bool wireframe = false)
- shared_ptr<[Sprite](Sprite.md)\> **CreateSprite**(shared_ptr<[World](World.md)\> world, shared_ptr<[Font](Font.md)\> font, const [WString](WString.md)& text, const int size, const TextAlignment = TEXT_LEFT | TEXT_TOP)

| Parameter | Description |
| --- | --- |
| world | canvas to add the sprite to |
| width | width of the sprite, in pixels |
| height | height of the sprite, in pixels |
| wireframe | set to true for wireframe or false for solid |
| text | text to display |
| font | font to render text with |
| size | font size |
| textalignment | alignemtn flags, can be any combination of TEXT_LEFT, TEXT_CENTER, TEXT_RIGHT, TEXT_TOP, TEXT_MIDDLE, and TEXT_BOTTOM |

## Returns

Returns a new sprite object.

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

    //Create framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Create world
    auto world = CreateWorld();

    //Create camera
    auto camera = CreateCamera(world, PROJECTION_ORTHOGRAPHIC);
    camera->SetClearColor(0.125);
    camera->SetPosition(float(framebuffer->size.x) * 0.5f, float(framebuffer->size.y) * 0.5f, 0.0f);

    //Create sprite
    auto sprite = CreateSprite(world, 100, 100);
    sprite->SetColor(0, 0, 1);
    sprite->SetPosition(10, 10, 0);

    //Main loop
    while (window->Closed() == false and window->KeyHit(KEY_ESCAPE) == false)
    {
        world->Update();
        world->Render(framebuffer);
    }
    return 0;
}
```
