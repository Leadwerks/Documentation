# Framebuffer.GetCaptures

This method returns an array of screen capture images that have been recorded by calling [Framebuffer.Capture](Framebuffer_Capture.md).

## Syntax

```csharp
List<Pixmap> GetCaptures();
```

## Returns

Returns an array of captured frames and clears the stored items.

## Example

```csharp
using System;
using System.Collections.Generic;
using UltraEngine;

class Program
{
    static void Main(string[] args)
    {
        // Get the displays
        var displays = GetDisplays();

        // Create a window
        var window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[0], WindowFlags.WINDOW_TITLEBAR | WindowFlags.WINDOW_CENTER);

        // Create a framebuffer
        var framebuffer = CreateFramebuffer(window);

        // Create a world
        var world = CreateWorld();

        // Create a camera
        var camera = CreateCamera(world);
        camera.SetClearColor(0.125f);
        camera.SetPosition(0, 0, -2);

        // Create a light
        var light = CreateBoxLight(world);
        light.SetRotation(45, 35, 0);
        light.SetRange(-10, 10);
        light.SetColor(2);

        // Create a model
        var box = CreateBox(world);
        box.SetColor(0, 0, 1);

        // Main loop
        while (!window.Closed() && !window.KeyHit(Key.KEY_ESCAPE))
        {
            // Rotate the model
            box.Turn(0, 1, 0);

            // Press the space key to queue a screenshot
            if (window.KeyHit(Key.KEY_SPACE))
                framebuffer.Capture();

            // Look for captured frames
            var caps = framebuffer.GetCaptures();
            foreach (var pixmap in caps)
            {
                var path = GetPath(Path.PATH_DESKTOP) + "/screenshot.jpg";
                pixmap.Save(path);
                RunFile(path);
            }

            // Update world
            world.Update();

            // Render world
            world.Render(framebuffer, true);
        }
    }
}
```