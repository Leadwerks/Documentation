# Entity Components

www.youtube.com/watch?v=eww15sH0rSk

You can download two sample scenes for this tutorial [here](https://www.leadwerks.com/community/files/file/3592-components-sample/) or use the [downloads manager](downloadsmanager.md) to install the package into a new Lua project.

## Entity Component System

The Leadwerks entity component system (ECS) allows you to attach code files to objects in the scene to give them behavior in the game. Open the scene "component.map" from the sample package. You'll find two blue boxes, one with the SwingingDoor component, and the other with the SlidingDoor component. There is also a pivot in the middle of the scene with the FPSPlayer component added to it.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/components.png?raw=true)

If you select the **Game > Run** menu item to run the game, you can use the WASD keys to move around, and open either door by walking up to it and pressing the E key.

## Custom Components

Let's try creating a new custom component. Press the '+' button that appears below the **Scene** tab in the right-side panel. Select the **New Component** popup menu that appears.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/newcomponent.png?raw=true)

In the New Component dialog, select the **Motion** component group and enter the name "CustomComponent".

![](https://github.com/UltraEngine/Documentation/blob/master/Images/newcomponent2.png?raw=true)

The editor will create two new files in the folder "Source\Components\Motion". The "CustomComponent.lua" file contains your component code. The "CustomComponent.json" file contains component definitions extracted from the code file, and tells the editor what editable properties the code file contains.

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
You can replace all those properties with just one:
```lua
CustomComponent.rotationspeed = Vec3(0,0,0)--"Rotation speed"
```

By default, an Update function is present but contains no code:
```lua
function CustomComponent:Update()

end
```

Replace the Update function with this code, which will cause the object to turn when the T key is pressed:
```lua
function CustomComponent:Update()
	
	local window = ActiveWindow()
	if window == nil then
		return
	end

	if window:KeyDown(KEY_T) then
		self.entity:Turn(self.rotationspeed)
	end

end
```
Save the script and run the game again, and you can hold the T key to make the green box turn.

## FlowGraph Editor

