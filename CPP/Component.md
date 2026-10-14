# Component

The Leadwerks entity component system allows you to easily add behavior to game objects. This class can be extended to add behavior and properties to an [Entity](Entity.md).

| Property | Type | Description |
|---|---|---|
| [CallMethod](Component_CallMethod.md) | Method | allows a method to be called by name, for use with the flowgraph |
| [Collide](Component_Collide.md) | Method | called whenever a physics collision occurs |
| [GetEntity](Component_GetEntity.md) | Method | retrieves the entity this component is attached to |
| [Load](Component_Load.md) | Method | called when an actor is loaded or copied |
| [Start](Component_Start.md) | Method | called when a component is added |
| [Update](Component_Update.md) | Method | called once each time [World::Update](World_Update.md) is called |

## Creating Components

You can override these methods or add your own in your component class. To add a new component, press the **+** button at the top of the asset browser and select the "New Component" popup menu item.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/newcomponent.png)

Select the group the component should be placed in and enter the name of your new component, then press the OK button.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/newcomponentok.png)

This will create the new code files, and update your Visual Studio project automatically so they are included in the project filters.

## Example Component

The Mover component is about as simple as it gets. It just stores some motion parameters and moves or turns the entity each time Update is called:

```c++
#pragma once
#include "Leadwerks.h"
#include "../BaseComponent.h"

using namespace Leadwerks;

class Mover : public BaseComponent//Component
{
public: 
    Vec3 movementspeed = Vec3(0,0,0);//"Movement speed"
    Vec3 rotationspeed = Vec3(0,1,0);//"Rotation speed"
    bool globalcoords = false;//"World space"
	
    Mover();
    virtual void Update();
    virtual bool Load(table& properties, shared_ptr<Stream> binstream, shared_ptr<Scene> scene, const LoadFlags flags, shared_ptr<Object> extra);
    virtual bool Save(table& properties, shared_ptr<Stream> binstream, shared_ptr<Scene> scene, const SaveFlags flags, shared_ptr<Object> extra);
    virtual std::shared_ptr<Component> Copy();
};
```

## Component Methods and Members

To call a component method or get a value, first check if a component of the desired type is attached to the entity, and then call the method:

```c++
auto component = entity->GetComponent<HealthManager>();
if (component) component->TakeDamage(10);
```

## Exposing Components to the Editor

You can place a comment after a member declaration in the component header file to indicate the name that should be displayed in the editor for the property, like in the code below. The editor will automatically detect the member type and display a widget that is appropriate for the value:

```cpp
int integervalue = 0;//"Integer value"
float floatvalue = 0.0f;//"Float value"
WString stringvalue = "";//"String value"
bool booleanvalue = false;//"Boolean value"
Vec2 vec2value = Vec2(0,0);//"Vec2 value"
Vec3 vec3value = Vec3(0,0,0);//"Vec3 value"
Vec4 vec4value = Vec4(0,0,0,0);//"Vec4 value"
std::shared_ptr<Entity> entityvalue;//"Entity value"
```

To display a drop-down box for use with an integer member, you can place the option names in square brackets after the display name:
```cpp
int optionvalue = 0;//"Option value" ["Option 1", "Option 2", "Option 3"]
```

A Vec3 or Vec4 member can display a color picker by adding the text COLOR after the display name:
```cpp
Vec3 rgbvalue = Vec3(1,1,1);//"RGB value" COLOR
Vec4 rgbavalue = Vec4(1,1,1,1);//"RGBA value" COLOR
```

A file select dialog can be display with a string value by adding the text SOUND, PREFAB, MODEL, or TEXTURE after the display name:

```cpp
WString pathvalue;//"Path value" SOUND
```
Each property entry represents an editable value that will be displayed in the component properties when it is attached to an entity. The default value of the property determines what type of interface element will be used to control the value.

![](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/component_properties.png)

## Loading Member Values

The values of any members you expose to the editor must be manually loaded from the components properties table in C++, in the [Component::Load](Component_Load,md) method.

```cpp
bool MyComponent::Load(table& properties, shared_ptr<Stream> binstream, shared_ptr<Scene> scene, const LoadFlags flags, std::shared_ptr<Object> extra)
{
    if (properties["integervalue"].is_number()) integervalue = properties["integervalue"];
    if (properties["floatvalue"].is_number()) floatvalue = properties["floatvalue"];
    if (properties["booleanvalue"].is_boolean()) booleanvalue = properties["booleanvalue"];
    if (properties["entityvalue"].is_string())
    {
        entityvalue = scene->GetEntity(std::string(properties["entityvalue"]));
    }
    return BaseComponent::Load(properties, binstream, scene, flags, extra);
}
```

Upcoming additions to the C++ language may allow this step to be automated in the future.

## Exposing Methods to the Flowgraph Editor

We can add a comment after a method declaration to expose to make it act as an input, output, or both, in the flowgraph editor.

### Inputs

To make a method act as an input add the comment "in" in the same line as the method declaration:
```cpp
virtual void MyMethod();//in
```

In order to allow C++ to call the method by name, a condition must be added in the [Component::CallMethod](Component_CallMethod.md) method to handle this:

```cpp
std::any MyComponent::CallMethod(shared_ptr<Component> caller, const WString& name, const std::vector<std::any>& args)
{
    if (name == "MyMethod")
    {
        MyMethod();// no arguments are used here
    }
    return BaseComponent::CallMethod(caller, name, args);
}
```

### Outputs

To make a method act as an output add the comment "out" in the same line as the method declaration.
```cpp
virtual void MyMethod();//out
```

In the implementation (the .cpp file) you must also add a call to FireOutputs with the name of the method:
```cpp
void MyComponent::MyMethod()
{
    FireOutputs("MyMethod");
}
```

### Input + Output

To make a method act as both an input and an output add the comment "inout" in the same line as the method declaration:

```cpp
virtual void MyMethod();//inout
```

The requirements for both input and output functions must also be fulfilled, as shown above.

- Add a condition check for the method name in the [Component::CallMethod](Component_CallMethod.md) method.
- Add a call to FireOutputs with the name of the method in the method implementation.

This will allow you to control which component methods can be connected in the flowgraph editor, so the level design can set up interesting game interactions for each map:

![](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/component_outputs.png)

