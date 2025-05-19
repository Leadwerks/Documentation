```csharp
using System;
using Apocalyptic.GameEngine.Plugins.UltraEngine; // (Insert appropriate namespace for the Ultra Engine API)

class Program
{
    static void Main(string[] args)
    {
        //Get the displays
        var displays = UltraEngine.GetDisplays();

        //Create a window
        var window = UltraEngine.CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[0], UltraEngine.WINDOW_TITLEBAR | UltraEngine.WINDOW_CENTER);

        //Create a framebuffer
        var framebuffer = UltraEngine.CreateFramebuffer(window);

        //Create a world
        var world = UltraEngine.CreateWorld();

        //Create a camera
        var camera = UltraEngine.CreateCamera(world);
        camera.SetClearColor(0.125f);
        camera.SetPosition(0, 0, -2);

        //Create a light
        var light = UltraEngine.CreateBoxLight(world);
        light.SetRotation(45, 35, 0);
        light.SetRange(-10, 10);
        light.SetColor(2);

        //Create a model
        var box = UltraEngine.CreateBox(world);
        box.SetColor(0, 0, 1);

        //Main loop
        while (!window.Closed() && !window.KeyHit(KEY_ESCAPE))
        {
            //Rotate the model
            box.Turn(0, 1, 0);

            //Press the space key to queue a screenshot
            if (window.KeyHit(KEY_SPACE)) framebuffer.Capture();

            //Look for captured frames
            var caps = framebuffer.GetCaptures();
            foreach (var pixmap in caps)
            {
                var path = GetPath(PATH_DESKTOP) + "/screenshot.jpg";
                pixmap.Save(path);
                RunFile(path);
            }

            //Update world
            world.Update();

            //Render world
            world.Render(framebuffer, true);
        }
    }
}
```