# CreateInterface

This function creates a new graphical user interface for desktop applications or in-game interfaces.

## Syntax

- shared_ptr<[Interface](Interface.md)\> **CreateInterface**(shared_ptr<[Window](Window.md)\> window)
- shared_ptr<[Interface](Interface.md)\> **CreateInterface**(shared_ptr<[Camera](Camera.md)\> camera, shared_ptr<[Font](Font.md)\> font, [iVec2](iVec2.md)\> size)
- shared_ptr<[Interface](Interface.md)\> **CreateInterface**(shared_ptr<[World](World.md)\> world, shared_ptr<[Font](Font.md)\> font, [iVec2](iVec2.md)\> size)

| Parameter | Description |
| --- | --- |
| window | window to create the user interface on |
| camera | camera to create the interface on, for 3D graphics |
| world | world to create the interface in, for 3D graphics |
| font | font to use, for 3D graphics |
| size | interface dimensions, for 3D graphics |

## Returns

Returns a new interface object.

## Example

Several examples are shown below to demonstrate different types of programs you can create.

### Desktop Applications

The first example shows how to create an interface directly on a window for an event-based desktop application.

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = GetDisplays();

    //Create window
    auto window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[0]);

    //Create user interface
    auto ui = CreateInterface(window);

    //Create widget
    iVec2 sz = ui->background->ClientSize();
    auto button = CreateButton("Button", sz.x / 2 - 75, sz.y / 2 - 15, 150, 30, ui->background);

    while (true)
    {
        const Event ev = WaitEvent();
        switch (ev.id)
        {
        case EVENT_WINDOWCLOSE:
            if (ev.source == window)
            {
                return 0;
            }
            break;
        }
    }
    return 0;
}
```

### Game Menus

The second example shows how to create an interface that appears in a 3D rendering viewport on top of the scene. Note that in this example you must send events to the interface with the [ProcessEvent](Interface_ProcessEvent.md) method.

```c++
#include "Leadwerks.h"

using namespace Leadwerks;

int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = GetDisplays();

    //Create window
    auto window = CreateWindow("Leadwerks", 0, 0, 1280, 720, displays[0]);

    //Create framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Create world
    auto world = CreateWorld();

    //Create main camera
    auto camera = CreateCamera(world);
    camera->SetPosition(0, 0, -3);

    //Create a model
    auto box = CreateBox(world);

    //Create a light
    auto light = CreateBoxLight(world);
    light->SetRange(-5, 5);
    light->SetRotation(34, 45, 0);

    //Load a font
    auto font = LoadFont("Fonts/arial.ttf");

    //Create user interface with a semi-transparent background
    auto ui = CreateInterface(camera, font, framebuffer->size);
    ui->background->SetColor(0, 0, 0, 0.5);

    //Create widget
    iVec2 sz = ui->background->ClientSize();
    auto button = CreateButton("Button", sz.x / 2 - 75, sz.y / 2 - 15, 150, 30, ui->background);

    while (true)
    {
        box->Turn(0, 1, 0);

        while (PeekEvent())
        {
            const Event ev = WaitEvent();
            switch (ev.id)
            {
            case EVENT_WINDOWCLOSE:
                if (ev.source == window)
                {
                    return 0;
                }
                break;
            default:
                ui->ProcessEvent(ev);
                break;
            }
        }

        world->Update();
        world->Render(framebuffer);
    }
    return 0;
}
```

### In-game Interfaces

The next example will display an interface inside the 3D world. This can be used to display an interface on a panel in the game, or a menu floating in the air in VR.

```c++
#include "Leadwerks.h"

using namespace Leadwerks;

int main(int argc, const char* argv[])
{
    // Get the displays
    auto displays = GetDisplays();

    // Create window
    auto window = CreateWindow("Leadwerks", 0, 0, 1280, 720, displays[0]);

    // Create framebuffer
    auto framebuffer = CreateFramebuffer(window);

    // Create world
    auto world = CreateWorld();

    // Load a font
    auto font = LoadFont("Fonts/arial.ttf");

    // Create a camera
    auto camera = CreateCamera(world);
    camera->SetPosition(0, 0, -2);
    camera->SetZoom(2);
    camera->SetClearColor(0.125);

    // Create a model
    auto box = CreateBox(world);
    box->SetRotation(0, 45, 0);
    box->SetPickMode(PICK_MESH);

    //Create light
    auto light = CreateBoxLight(world);
    light->SetRotation(45, 35, 0);
    light->SetRange(-10, 10);
    light->SetColor(2);

    // Create camera
    auto uicamera = CreateCamera(world, PROJECTION_ORTHOGRAPHIC);
    uicamera->SetRealtime(false);
    uicamera->SetLighting(false);

    // Render to a texture
    auto texbuffer = CreateTextureBuffer(TEXTURE_RGBA, 256, 256);
    uicamera->SetRenderTarget(texbuffer);
    
    // Apply the render texture to a material and show it on the box
    auto mtl = CreateMaterial();
    mtl->SetTexture(texbuffer->GetColorAttachment(0));
    box->SetMaterial(mtl);

    // Create user interface
    auto ui = CreateInterface(uicamera, font, texbuffer->size);
    
    // Create widget
    iVec2 sz = ui->background->ClientSize();
    auto button = CreateButton("Button", sz.x / 2 - 75, sz.y / 2 - 15, 150, 30, ui->background);

    // Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        while (PeekEvent())
        {
            Event ev = WaitEvent();
            switch (ev.id)
            {
            case EVENT_MOUSEDOWN:
            case EVENT_MOUSEUP:
            case EVENT_MOUSEMOVE:
                auto pick = camera->Pick(framebuffer, ev.position.x, ev.position.y, 0, true);
                if (pick.success and pick.entity == box)
                {
                    ev.position.x = Round(pick.texcoords[0].x * 256.0f);
                    ev.position.y = Round(pick.texcoords[0].y * 256.0f);
                    ui->ProcessEvent(ev);
                    uicamera->Render();
                }
                break;
            }
        }

        world->Update();
        world->Render(framebuffer);
    }
    return 0;
}
```

### VR Menus

This example demonstrates how to display a user interface on a floating panel and interact with it using VR controllers.

```cpp
#include "Leadwerks.h"

using namespace Leadwerks;

int main(int argc, const char* argv[])
{
    // Get the displays
    auto displays = GetDisplays();

    // Create window
    auto window = CreateWindow("Leadwerks", 0, 0, 1280, 720, displays[0]);

    // Create framebuffer
    auto framebuffer = CreateFramebuffer(window);

    // Create world
    auto world = CreateWorld();

    auto hmd = GetHmd(world);
    hmd->Start(framebuffer);

    //Create light
    auto light = CreateBoxLight(world);
    light->SetRotation(45, 35, 0);
    light->SetRange(-20, 20);
    light->SetArea(25, 25);

    // Create the ground
    auto ground = CreateBox(world, 10, 1, 10);
    ground->SetPosition(0, -0.5, 0);
    ground->SetColor(0.5);

    // Render to a texture
    auto texbuffer = CreateTextureBuffer(TEXTURE_RGBA, 256, 256);

    // Create camera
    auto uicamera = CreateCamera(world, PROJECTION_ORTHOGRAPHIC);
    uicamera->SetRealtime(false);
    uicamera->SetLighting(false);
    uicamera->SetRenderTarget(texbuffer);
    uicamera->Render();
    uicamera->SetRenderLayers(0);

    // Create a model
    auto plane = CreatePlane(world);
    plane->SetRotation(0, 45, 0);
    plane->SetPickMode(PICK_MESH);
    plane->SetRotation(-90, 0, 0);
    plane->SetScale(2, 2, -2);// flip the texcoords vertically
    plane->SetPosition(0, 1.5, 1);
    plane->SetShadows(false);

    // Apply the render texture to a material and show it on the box
    auto mtl = CreateMaterial();
    mtl->SetTexture(texbuffer->GetColorAttachment(0));
    plane->SetMaterial(mtl);

    // Create user interface
    const float scale = 1.0;
    auto font = LoadFont("Fonts/arial.ttf");
    auto ui = CreateInterface(uicamera, font, texbuffer->size);
    
    // Create some widgets
    iVec2 sz = ui->background->ClientSize();
    auto button = CreateButton("Button", (sz.x / 2) / scale - 75 * scale, (sz.y / 3) / scale - 15 * scale, 150 * scale, 30 * scale, ui->background);
    auto checkbox = CreateButton("Check box", (sz.x / 2) / scale - 75 * scale, (sz.y / 2) / scale - 15 * scale, 150 * scale, 30 * scale, ui->background, BUTTON_CHECKBOX);
    auto dropdown = CreateComboBox((sz.x / 2) / scale - 75 * scale, (sz.y * 0.667) / scale - 15 * scale, 150 * scale, 30 * scale, ui->background);
    dropdown->AddItem("Item 1", true);
    dropdown->AddItem("Item 2");
    dropdown->AddItem("Item 3");

    // Pointer / indicator
    auto beam = CreateSprite(world, 1, 1);
    beam->SetColor(2, 0, 0);
    beam->SetViewMode(SPRITEVIEW_YROTATION);

    iVec2 mousepos;// Simulated mouse position
    std::array<bool, 2> triggerpressed = { false, false };// for keeping track of simulated mouse button state

    // Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        int hand = 0;
        if (hmd->controllers[hand]->GetState() == VRDEVICESTATE_ACTIVE)
        {
            // Simulated mouse movement
            Mat4 pose = hmd->controllers[hand]->GetPose(VRPOSE_AIM);
            Vec3 p0 = pose[3].xyz();
            Vec3 p1 = p0 + pose[2].xyz() * 100.0;
            PickInfo pick = world->Pick(p0, p1, 0, true);
            if (pick.entity == plane)
            {
                beam->SetHidden(false);
                beam->SetPosition((p0 + pick.position) * 0.5);
                beam->AlignToVector(pick.position - p0, 1);
                beam->SetScale(0.01, (pick.position - p0).Length(), 1);
                beam->Sync();
                
                // Transform the picked position to UI coordinates
                Vec3 pos = TransformPoint(pick.position, NULL, plane);
                pos.x += 0.5;
                pos.z = pos.z;
                pos.z += 0.5;
                pos.x *= texbuffer->size.x;
                pos.z *= texbuffer->size.y;
                mousepos.x = pos.x;
                mousepos.y = pos.z;

                // Send a fake mouse movement event to the UI
                ui->ProcessEvent(Event(EVENT_MOUSEMOVE, window, 0, mousepos));

                // Refresh the camera
                uicamera->Render();
            }
            else
            {
                beam->SetHidden(true);
            }

            // Simulated mouse button press
            if (hmd->controllers[hand]->GetAxis(VRAXIS_TRIGGER) > 0.98)
            {
                if (not triggerpressed[hand])
                {
                    triggerpressed[hand] = true;

                    // Send a fake mouse button event to the UI
                    ui->ProcessEvent(EVENT_MOUSEDOWN, window, MOUSE_LEFT, mousepos.x, mousepos.y);
                }
            }
            else if (triggerpressed[hand])
            {
                triggerpressed[hand] = false;

                // Send a fake mouse button event to the UI
                ui->ProcessEvent(EVENT_MOUSEUP, window, MOUSE_LEFT, mousepos.x, mousepos.y);
            }
        }

        while (PeekEvent())
        {
            Event ev = WaitEvent();
            switch (ev.id)
            {
            case EVENT_VRSTART:
                if (ev.data == 0)
                {
                    Print("Error: OpenXR failed to initialize");
                    return 1;
                }
                break;
            case EVENT_WIDGETACTION:
                if (ev.source == button)
                {
                    Print("Button pressed");
                }
                else if (ev.source == checkbox)
                {
                    Print("Checkbox pressed");
                }
                break;
            case EVENT_WIDGETSELECT:
                if (ev.source == dropdown)
                {
                    Print("Dropdown item " + String(ev.data) + " selected");
                }
                break;
            }
        }

        // Update the world
        world->Update();

        // Render the world
        world->Render(framebuffer);
    }

    Shutdown();
    return 0;
}
```

