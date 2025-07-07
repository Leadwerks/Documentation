# Components

The Leadwerks Entity Component System (ECS) uses Lua code and tables to attach properties and functions to entities in your game.

## Creating Components

To create a new component, press the '+' button that appears below the **Scene** tab in the right-side panel. Select the **New Component** popup menu that appears.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/newcomponent.png?raw=true)

In the New Component dialog, select the group you want to place your component in and enter the name for your new component:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/newcomponent2.png?raw=true)

The editor will create two new files in the appropriate folder. The "CustomComponent.lua" file contains your component code. The "CustomComponent.json" file contains component definitions extracted from the code file, and tells the editor what editable properties the code file contains.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/newcomponent3.png?raw=true)

The new component will include example properties of every supported type:
```lua
CustomComponent.integervalue = 0--"Integer value"
CustomComponent.floatvalue = 0.0--"Float value"
CustomComponent.stringvalue = ""--"String value"
CustomComponent.booleanvalue = false--"Boolean value"
CustomComponent.optionvalue = 0--"Option value" ["Option 1", "Option 2", "Option 3"]
CustomComponent.entityvalue = nil--"Entity value"
CustomComponent.pathvalue = ""--"Path value" SOUND
CustomComponent.vec2value = Vec2(0,0)--"Vec2 value"
CustomComponent.vec3value = Vec3(0,0,0)--"Vec3 value"
CustomComponent.vec4value = Vec4(0,0,0,0)--"Vec4 value"
CustomComponent.rgbvalue = Vec3(1,1,1)--"RGB value" COLOR
CustomComponent.rgbavalue = Vec4(1,1,1,1)--"RGBA value" COLOR
```
