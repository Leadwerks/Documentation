# LoadModel

This function loads a model from a file.

## Syntax

- `Model LoadModel(string path, LoadFlags flags = LOAD_DEFAULT)`
- `Model LoadModel(Stream stream, LoadFlags flags = LOAD_DEFAULT)`

| Parameter | Description |
|---|---|
| path | file path to read from |
| stream | stream to read from |

## Returns

Returns the loaded model if successful, otherwise NULL is returned.

## Remarks

Ultra Engine natively supports glTF, OBJ, and Leadwerks MDL files. JPEG and PNG texture files are loaded using the FITextureLoader plugin.

## Example

```csharp
using System;
using UltraEngine;
using UltraEngine.Renderer;
using UltraEngine.Scripting;

namespace Example
{
    class Program
    {
        static void Main(string[] args)
        {
            //Get the displays
            var displays = Engine.GetDisplays();

            //Create a window
            var window = Engine.CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[0], WindowFlags.WINDOW_CENTER | WindowFlags.WINDOW_TITLEBAR);

            //Create a world
            var world = Engine.CreateWorld();
            world.SetAmbientLight(0);

            //Create a framebuffer
            var framebuffer = Engine.CreateFramebuffer(window);

            //Load model
            //Cyber Samurai by Khoa Minh: https://sketchfab.com/3d-models/cyber-samurai-26ccafaddb2745ceb56ae5cfc65bfed5
            var model = Engine.LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Characters/cyber_samurai.glb");
            model.Turn(0, 180, 0, true);

            //Environment maps
            var specmap = Engine.LoadTexture("https://github.com/UltraEngine/Assets/raw/main/Materials/Environment/footprint_court/specular.dds");
            var diffmap = Engine.LoadTexture("https://github.com/UltraEngine/Assets/raw/main/Materials/Environment/footprint_court/diffuse.dds");
            world.SetEnvironmentMap(diffmap, EnvironmentMapType.ENVIRONMENTMAP_BACKGROUND);
            world.SetEnvironmentMap(specmap, EnvironmentMapType.ENVIRONMENTMAP_SPECULAR);
            world.SetEnvironmentMap(diffmap, EnvironmentMapType.ENVIRONMENTMAP_DIFFUSE);

            //Create a camera    
            var camera = Engine.CreateCamera(world);
            camera.SetClearColor(0.125);
            camera.SetPosition(0, 1.4, -1);
            camera.SetFov(70);
            camera.AddPostEffect(Engine.LoadPostEffect("Shaders/FXAA.fx"));

            //Add camera controls
            camera.AddComponent<CameraControls>();

            //Create light
            var light = Engine.CreateBoxLight(world);
            light.SetRange(-10, 10);
            light.SetArea(15, 15);
            light.SetRotation(45, 35, 0);
            light.SetColor(1.2);

            //Main loop
            while (!(window.Closed() == true) && !(window.KeyDown(KeyCode.KEY_ESCAPE) == true))
            {
                world.Update();
                world.Render(framebuffer);
            }
        }
    }
}
```