# Component

The Ultra Engine entity component system allows you to easily add behavior to game objects. This class can be extended to add behavior and properties to an [Entity](Entity.md).

| Property    | Type                  | Description                                                |
| ----------- | --------------------- | ---------------------------------------------------------- |
| entity      | [Entity](Entity.md) | entity this component is attached to |
| [Collide](Component_Collide.md)  | Method                | called whenever a physics collision occurs                 |
| [Load](Component_Load.md)     | Method                | called when an actor is loaded or copied                   |
| [Start](Component_Start.md)   | Method                | called when a component is added                           |
| [Update](Component_Update.md) | Method                | called once each time [World:Update](World_Update.md) is called |

You can override these methods or add your own in your component class. To add a new component, just create a new .lua file in your "Source\Components" folder. You can use separate files if you want, but it is more convenient to put everything in a single file that can be included into your project. Compile your project once and the Lua interpreter will detect your new file and update the component system code. The component system will automatically update the component registration when the Lua interpreter detects changes to the component files.

The Lua interpreter is limited in its ability to parse Lua declarations, so it's a good idea to stick to straightforward Lua syntax.

## Using Components

To use components in Lua, create a new Lua script and use the Lua API functions to add the component to an entity with [Entity:AddComponent](Entity_AddComponent.md). The game engine will take care of the rest for you:

```lua
-- Create a world
local world = CreateWorld()

-- Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetFov(70)
camera:SetPosition(0, 0, -3)

-- Create a light
local light = CreateBoxLight(world)
light:SetRotation(35, 45, 0)
light:SetRange(-10, 10)

-- Create a box
local box = CreateBox(world)
box:SetColor(0, 0, 1)

-- Entity component system
local mover = box:AddComponent(Mover)
mover.rotationspeed.y = 45

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do
    world:Update()
    world:Render(framebuffer)
end
```

## Example Component

The Mover component is about as simple as it gets. It just stores some motion parameters and moves or turns the entity each time Update is called:

```lua
Mover = {}
Mover.name = "Mover"

Mover.movementspeed = Vec3(0)
Mover.rotationspeed = Vec3(0,1,0)
Mover.globalcoords = false

function Mover:Start()
    
end

function Mover:Update()
    if self.globalcoords then
        self.entity:Translate(self.movementspeed / 60, true)
    else
        self.entity:Move(self.movementspeed / 60)
    end
    self.entity:Turn(self.rotationspeed / 60, self.globalcoords)
end

RegisterComponent("Mover", Mover)

return Mover
```

## Component Methods and Members

To call a component method or get a value, first check if a component of the desired type is attached to the entity, and then call the method:

```lua
if type(entity.healthmanager) == "table" then
    if type(entity.healthmanager.TakeDamage) == "function" then
        entity.healthmanager:TakeDamage(10)
    end
end
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
