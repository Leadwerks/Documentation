# Entity.Sync

This method synchronizes changes to an entity's orientation and color. Use this to disable rendering interpolation when an object is "teleported" to a new location.

## Syntax

```csharp
void Sync();
```

## Remarks

Rendering is performed on a separate thread, and is likely to run at a different frequency than the main thread. In the rendering thread, changes to an entity's position, rotation, scale, and color are smoothly interpolat**ed** between the most recent two updates received, resulting in smooth motion. If for any reason you want motion and color forced to the current value when they are received, this command can be called after setting the orientation or color. For example, if you load a model and then place it in a position where it is supposed to appear, you may wish to call this command to ensure there is not any interpolation between its original and final positions.

Note that if physics are enabled it may introduce additional interpolation if the entity has a non-zero mass.

## Example

In this example the box on the top will use rendering interpolation, while the box on the bottom will continuously call Sync() to prevent interpolation.

```csharp
using System;
using UltraEngine;

class Program
{
    static void Main(string[] args)
    {
        // Get display
        var displays = GetDisplays();

        // Create window
        var window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[0], WindowFlags.WINDOW_TITLEBAR | WindowFlags.WINDOW_CENTER);

        // Create framebuffer
        var framebuffer = CreateFramebuffer(window);

        // Create world
        var world = CreateWorld();
        world.SetAmbientLight(0.1);
        world.RecordStats(true);

        // Create camera
        var camera = CreateCamera(world);
        camera.SetClearColor(0.25);
        camera.SetPosition(0, 2, 0);
        camera.Move(0, 0, -5);

        // Build scene
        var tunnel = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Underground/tunnel_t.glb");
        tunnel.SetRotation(0, 180, 0);
        tunnel.Staticize();

        var cage = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Underground/fancage.glb");
        cage.Staticize();

        var fan = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Underground/fanblades.glb");
        fan.SetPosition(0, 2, 0);
        var mover = fan.AddComponent<Mover>();
        mover.rotationspeed.z = 300;

        var light = CreatePointLight(world);
        light.SetColor(2, 2, 2);
        light.SetRange(10);
        light.SetPosition(0, 2, 2);
        light.SetColor(4.0);

        // Display text
        var orthocam = CreateCamera(world, ProjectionType.PROJECTION_ORTHOGRAPHIC);
        orthocam.SetClearMode(ClearMode.CLEAR_DEPTH);
        orthocam.SetRenderLayers(128);
        orthocam.SetPosition(framebuffer.size.x * 0.5f, framebuffer.size.y * 0.5f);

        var font = LoadFont("Fonts/arial.ttf");

        var text = CreateSprite(world, font, "Shadow polygons: 0", 14.0 * displays[0].scale);
        text.SetPosition(2, framebuffer.size.y - 16.0f * displays[0].scale);
        text.SetRenderLayers(128);

        var text2 = CreateSprite(world, font, "Press space to make the light static.", 14.0 * displays[0].scale);
        text2.SetPosition(2, framebuffer.size.y - 16.0f * 2.0f * displays[0].scale);
        text2.SetRenderLayers(128);

        // Main loop
        while (!window.KeyHit(KeyCode.KEY_ESCAPE) && !window.Closed())
        {
            world.Update();
            world.Render(framebuffer);

            if (window.KeyHit(KeyCode.KEY_SPACE))
            {
                light.Staticize();
                text2.SetHidden(true);
            }

            text.SetText("Shadow polygons: " + world.renderstats.shadowpolygons.ToString());
        }
    }
}
```