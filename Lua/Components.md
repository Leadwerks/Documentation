# Components

The Leadwerks Entity Component System (ECS) uses Lua code and tables to attach properties and functions to entities in your game.

## Creating Components

To create a new component, press the '+' button that appears below the **Scene** tab in the right-side panel. Select the **New Component** popup menu that appears.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/newcomponent.png?raw=true)

In the New Component dialog, select the group you want to place your component in and enter the name for your new component:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/newcomponent2.png?raw=true)

The editor will create two new files in the appropriate folder. The Lua file contains your component code. The JSON file contains component definitions extracted from the code file, and tells the editor what editable properties the code file contains.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/newcomponent3.png?raw=true)

## Component Properties

The new component will include example properties of every supported type.
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
In most cases, the editor can detect the value assigned to the property and infer the type from that. All you need to do is add the display name for the property in quotes, and the editor will detect it:
```lua
MyComponent.health = 100 -- "Health"
```
In the case of file paths and colors, the type must be specified after the display name. For file path properties, you can specific SOUND, MODEL, MATERIAL, TEXTURE, or PREFAB to control what file types the file selection dialog will display.
```lua
MyComponent.pathvalue = ""--"Path value" SOUND
MyComponent.rgbvalue = Vec3(1,1,1)--"RGB value" COLOR
MyComponent.rgbavalue = Vec4(1,1,1,1)--"RGBA value" COLOR
```
## Component Inputs and Outputs

