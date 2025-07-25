# Entity Component System

The Leadwerks entity component system allows you to assign behaviors and attributes to 3D objects in your scene. Each component contains values that can be modified in the editor, and functions that will execute code at key points in the game loop. Components can be used to add enemy behavior, movement, sound, and a variety of other behaviors and attributes.

An entity may have one or more components attached to it:

- Entity
  - Component 1
  - Component 2
  - Component 3
 
One entity may only have one instance of any specific component attached to it; you may not add the same component twice to the same entity.

Components are stored in source code files located in one of the subfolders found in the Source/Components directory.

## Adding Components

To add a component to an entity, press the **Add Component** button at the bottom of the [scene panel](mapbrowser.md).

![](https://github.com/UltraEngine/Documentation/blob/master/Images/addcomponent.png?raw=true)

A dialog will appear that shows a list of components to choose from, separated into categories.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/addcomponent2.png?raw=true)

Double-click on the component you want to add, and it will appear as a new group in the entity properties.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/addcomponent3.png?raw=true)

## Stock Components

The default project template includes many components to perform common actions in games.

### AI Components
- **Monster**: This provides simple behavior for an enemy with a melee attack.

### Appearance Components

- **ChangeEmission**: This allows an input to modify the emission color of the entity.

- **ChangeVisibility**: This allows an input to hide or show the entity.

### Logic Components

- **Relay**: This accepts an input and will trigger an output, after a user-defined period of time has passed.

### Motion Components

- **Mover**: This provides continuous linear motion or rotation.

### Physics Components

- **Impulse**: When triggered, this component will apply a force to an object over a defined period of time.

- **SlidingDoor**: Creates a slider joint and acts as a sliding door.

- **SwingingDoor**: Creates a hinge joint and acts as a swinging door.

### Player Components

- **CameraControls**: Provides simple "free-look" camera rotation and movement.

- **FPSPlayer**: Provides a first-person controller with compatibility with optional weapons.

- **VRPlayer**: Basic VR player controls.

### Sound Components

- **AmbientNoise**: Plays a noise originating from the entity.

- **ImpactNoise**: Plays a noise when a collision occurs.

### Triggers

- **CollisionTrigger**: Triggers an output when the object collides with anything.

- **PushButton**: The first-person player component can activate this to trigger an output.

### Weapons

- **Bullet**: For use with weapons, a basic projectile.

- **FPSGun**: View model weapon, compatible with the first-person player.

## User-Created Components

To create a new component, press the '+' button at the top of the [scene panel](mapbrowser.md) interface, and select the **Add Component** popup menu item. A dialog will appear that allows you to enter a name for the component and select the group it belongs in.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/newcomponent.png?raw=true)

Press the **OK** button to create the new component, and a new code file will be added in the appropriate directory, along with an associated JSON file.

### C++ Projects

If your project uses C++, then the new .cpp and .h file will be automatically inserted into your Visual Studio project, so they will be included in the game next time you compile it.

### Component Properties

You can expose component code values as editable fields that appears in the component properties. This is done by adding extra information in a code comment on the line where the value is declared.

The first value must be a name to show in the editor, surrounded by quotation marks.

For most values, the default value declared in the code is enough to figure out what kind of value it is.

To display a dropdown box with different options, add a list of items in quotation marks, separated by commas, with the list surrounded by brackets.

To display a color selecter, add the word COLOR after the display name. This will display an RGB or RGBA selecter, depending on what type of value is declared in the code.

```lua
MyComponent.integervalue = 0--"Integer value"
MyComponent.floatvalue = 0.0--"Float value"
MyComponent.stringvalue = ""--"String value"
MyComponent.booleanvalue = false--"Boolean value"
MyComponent.optionvalue = 0--"Option value" ["Option 1", "Option 2", "Option 3"]
MyComponent.entityvalue = nil--"Entity value"
MyComponent.pathvalue = ""--"Path value" SOUND
MyComponent.vec2value = Vec2(0,0)--"Vec2 value"
MyComponent.vec3value = Vec3(0,0,0)--"Vec3 value"
MyComponent.vec4value = Vec4(0,0,0,0)--"Vec4 value"
MyComponent.rgbvalue = Vec3(1,1,1)--"RGB value" COLOR
MyComponent.rgbavalue = Vec4(1,1,1,1)--"RGBA value" COLOR
```

Here is the same thing in a C++ header file:
```cpp
class MyComponent : public BaseComponent
{
public: 
    int integervalue = 0;//"Integer value"
    float floatvalue = 0.0f;//"Float value"
    WString stringvalue = "";//"String value"
    bool booleanvalue = false;//"Boolean value"
    int optionvalue = 0;//"Option value" ["Option 1", "Option 2", "Option 3"]
    std::shared_ptr<Entity> entityvalue;//"Entity value"
    WString pathvalue;//"Path value" SOUND
    Vec2 vec2value = Vec2(0,0);//"Vec2 value"
    Vec3 vec3value = Vec3(0,0,0);//"Vec3 value"
    Vec4 vec4value = Vec4(0,0,0,0);//"Vec4 value"
    Vec3 rgbvalue = Vec3(1,1,1);//"RGB value" COLOR
    Vec4 rgbavalue = Vec4(1,1,1,1);//"RGBA value" COLOR
};
```

Any time your code is modified, the code will be analyzed and the results will be stored in the associated JSON file, from which the editor will load properties to display. This file will always be auto-generated, so there is no need to edit its contents.

### Component Inputs and Outputs

Component functions can be exposed for use in the [flowgraph editor](flowgrapheditor.md) by adding a commend after the function declaration. The following values can be used:
- **in**: The function can accept inputs that will trigger the function to be executed
- **out**: The function can be connected to another function it will trigger after execution
- **inout**: The function will act as both an input and an output

```lua
function MyComponent:Activate()--inout
	self.active = true
end
```


