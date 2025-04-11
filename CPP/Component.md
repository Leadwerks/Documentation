# Component

The Ultra Engine entity component system allows you to easily add behavior to game objects. This class can be extended to add behavior and properties to an [Entity](Entity.md).

| Property | Type | Description |
|---|---|---|
| [CallMethod](Component_CallMethod.md) | Method | allows a method to be called by name, for use with the flowgraph |
| [Collide](Component_Collide.md) | Method | called whenever a physics collision occurs |
| [Copy](Component_Copy.md) | Method | makes a copy of the component, for copying entities |
| [GetEntity](Component_GetEntity.md) | Method | retrieves the entity this component is attached to |
| [Load](Component_Load.md) | Method | called when an actor is loaded or copied |
| [Start](Component_Start.md) | Method | called when a component is added |
| [Update](Component_Update.md) | Method | called once each time [World::Update](World_Update.md) is called |

You can override these methods or add your own in your component class. To add a new component, just create a new .hpp file in any subfolder in your "Source\Components" folder. You can use separate header and code files if you want, but it is more convenient to put everything in a single file that automatically gets included into your project. 

Open the file "Source\ComponentSystem.h" and add your component into the list of includes, as well as in the **RegisterComponents** function:
```c++
#pragma once
#include "UltraEngine.h"

#include "Components/Motion/Mover.hpp"
#include "Components/Motion/SlidingDoor.hpp"
#include "Components/Player/CameraControls.hpp"
#include "Components/Player/FirstPersonControls.hpp"
#include "Components/Player/ThirdPersonControls.hpp"
#include "Components/Player/VRPlayer.hpp"
#include "Components/Triggers/CollisionTrigger.hpp"

//Include user-defined component
#include "Components/Custom/MyComponent.hpp"

void RegisterComponents()
{
    RegisterComponent<Mover>();
    RegisterComponent<SlidingDoor>();
    RegisterComponent<CameraControls>();
    RegisterComponent<FirstPersonControls>();
    RegisterComponent<ThirdPersonControls>();
    RegisterComponent<VRPlayer>();
    RegisterComponent<CollisionTrigger>();

    //Register user-defined component
    RegisterComponent<MyComponent>();
}
```

## Using Components

To use components in C++, include the component system header file and add the component to an entity with [Entity::AddComponent](Entity_AddComponent.md). Call the **RegisterComponents** function at the start of your program to make it so the map loader is able to add components to entities that are loaded in a map. 

```c++
#include "UltraEngine.h"
#include "ComponentSystem.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    RegisterComponents();

    //Get the displays
    auto displays = GetDisplays();

    //Create a window
    auto window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[0], WINDOW_CENTER | WINDOW_TITLEBAR);

    //Create a world
    auto world = CreateWorld();

    //Create a framebuffer
    auto framebuffer = CreateFramebuffer(window);

    //Create a camera
    auto camera = CreateCamera(world);
    camera->SetClearColor(0.125);
    camera->SetFov(70);
    camera->SetPosition(0, 0, -3);

    //Create a light
    auto light = CreateBoxLight(world);
    light->SetRotation(35, 45, 0);
    light->SetRange(-10, 10);

    //Create a box
    auto box = CreateBox(world);
    box->SetColor(0,0,1);

    //Entity component system
    auto component = box->AddComponent<Mover>();
    component->rotationspeed.y = 45;

    //Main loop
    while (window->Closed() == false and window->KeyDown(KEY_ESCAPE) == false)
    {
        world->Update();
        world->Render(framebuffer);
    }
    return 0;
}
```

## Example Component

The Mover component is about as simple as it gets. It just stores some motion parameters and moves or turns the entity each time Update is called:
```c++
#pragma once
#include "UltraEngine.h"

class Mover : public Component
{
public: 
     
    Vec3 movementspeed;
    Vec3 rotationspeed = Vec3(0, 10, 0);
    bool globalcoords = false;
    
    //Update method, called once per loop
    virtual void Update()
    {
        if (globalcoords)
        {
            this->entity->Translate(movementspeed / 60.0f, true);
        }
        else
        {
            this->entity->Move(movementspeed / 60.0f);
        }
        this->entity->Turn(rotationspeed / 60.0f, globalcoords);
    }

    //This method will work with simple components
    virtual shared_ptr<Component> Copy()
    {
        return std::make_shared<Mover>(*this);
    }
}; 
```

## Component Methods and Members

To call a component method or get a value, first check if a component of the desired type is attached to the entity, and then call the method:
```c++
auto component = entity->GetComponent<HealthManager>();
if (component) component->TakeDamage(10);
```

## Exposing Components to the Editor

To display components in the editor, each component must have a JSON file with the same base name as the code file. The format of the JSON data is the same for every supported programming language. Here is the contents of the Mover.json file:

```json
{
    "component":
    {
        "properties":
        [
            {
                "name": "movementspeed",
                "label": "Movement",
                "value": [0.0,0.0,0.0]
            },
            {
                "name": "rotationspeed",
                "label": "Rotation",
                "value": [0.0,0.0,0.0]
            },
            {
                "name": "globalcoords",
                "label": "Global",
                "value": false
            }
        ]
    }
}
```

Each property entry represents an editable value that will be displayed in the component properties when it is attached to an entity. The default value of the property determines what type of interface element will be used to control the value.

![](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/component_properties.png)

We can add input and output functions to the component definition.

```json
{
    "component":
    {
        "outputs":
        [
            {
                "name": "Open"
            },
            {
                "name": "Close"
            }
        ],
        "inputs":
        [
            {
                "name": "Open"
            },
            {
                "name": "Close"
            },
            {
                "name": "Enable"
            },
            {
                "name": "Disable"
            }
        ]
    }
}
```

This will control which component methods can be connected in the flowgraph editor.

![](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/component_outputs.png)



