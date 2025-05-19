# Entity.Staticize

This method makes the entity static. A static entity cannot move and can be much more efficient to render. This operation is one-way and cannot be reversed.

## Syntax

```csharp
public void Staticize()
```

## Example

This example shows how a scene can be optimized to make non-moving objects static, resulting in a lower shadow polygon count. In large scenes with many lights this can result in a large reduction of rendered polygons and faster performance.

![Staticize Example](https://github.com/UltraEngine/Documentation/raw/master/Images/API_Entity_MakeStatic.gif)

```csharp
using UltraEngine;
using UltraEngine.Core;
using UltraEngine.Rendering;

class Program
{
    static void Main(string[] args)
    {
        //Get display
        var displays = DisplayUtils.GetDisplays();

        //Create window
        var window = WindowUtils.CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[0], WindowFlags.WINDOW_TITLEBAR | WindowFlags.WINDOW_CENTER);

        //Create framebuffer
        var framebuffer = WindowUtils.CreateFramebuffer(window);

        //Create world
        var world = WorldUtils.CreateWorld();
        world.SetAmbientLight(0.1);
        world.RecordStats(true);

        //Create camera
        var camera = WorldUtils.CreateCamera(world);
        camera.SetClearColor(0.25);
        camera.SetPosition(0, 2, 0);
        camera.Move(0, 0, -5);

        //Build scene
        var tunnel = ModelUtils.LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Underground/tunnel_t.glb");
        tunnel.SetRotation(0, 180, 0);
        tunnel.Staticize();

        var cage = ModelUtils.LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Underground/fancage.glb");
        cage.Staticize();

        var fan = ModelUtils.LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Underground/fanblades.glb");
        fan.SetPosition(0, 2, 0);
        var mover = fan.AddComponent<Mover>();
        mover.rotationspeed.z = 300;

        var light = WorldUtils.CreatePointLight(world);
        light.SetColor(2, 2, 2);
        light.SetRange(10);
        light.SetPosition(0, 2, 2);
        light.SetColor(4.0);

        //Display text
        var orthocam = WorldUtils.CreateCamera(world, ProjectionType.PROJECTION_ORTHOGRAPHIC);
        orthocam.SetClearMode(ClearType.CLEAR_DEPTH);
        orthocam.SetRenderLayers(128);
        orthocam.SetPosition(framebuffer.size.x * 0.5f, framebuffer.size.y * 0.5f);

        var font = FontUtils.LoadFont("Fonts/arial.ttf");

        var text = SpriteUtils.CreateSprite(world, font, "Shadow polygons: 0", 14.0 * displays[0].scale);
        text.SetPosition(2, framebuffer.size.y - 16.0f * displays[0].scale);
        text.SetRenderLayers(128);

        var text2 = SpriteUtils.CreateSprite(world, font, "Press space to make the light static.", 14.0 * displays[0].scale);
        text2.SetPosition(2, framebuffer.size.y - 16.0f * 2.0f * displays[0].scale);
        text2.SetRenderLayers(128);

        //Main loop
        while (!window.KeyHit(KeyCode.KEY_ESCAPE) && !window.Closed)
        {
            world.Update();
            world.Render(framebuffer);

            if (window.KeyHit(KeyCode.KEY_SPACE))
            {
                light.Staticize();
                text2.SetHidden(true);
            }

            text.SetText("Shadow polygons: " + world.RenderStats.shadowpolygons.ToString());
        }
    }
}
```