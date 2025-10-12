# Entity Scripts

www.youtube.com/watch?v=eww15sH0rSk

You can download two sample scenes for this tutorial [here](https://www.leadwerks.com/community/files/file/3592-components-sample/) or use the [downloads manager](downloadsmanager.md) to install the package into a new Lua project.

## Entity Script System

The Leadwerks entity script system allows you to attach code files to objects in the scene to give them behavior in the game. Open the scene "scripts.map" from the sample package. You'll find two blue boxes, one with the SwingingDoor script, and the other with the SlidingDoor script. There is also a pivot in the middle of the scene with the FPSPlayer script added to it.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/components.png?raw=true)

If you select the **Game > Run** menu item to run the game, you can use the WASD keys to move around, and open either door by walking up to it and pressing the E key.

## Custom Scripts

Let's try creating a new custom script. Press the '+' button that appears below the **Scene** tab in the right-side panel. Select the **New Entity Script** popup menu that appears.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/newcomponent.png?raw=true)

In the New Entity Script dialog, select the **Motion** script group and enter the name "CustomScript".

![](https://github.com/UltraEngine/Documentation/blob/master/Images/newcomponent2.png?raw=true)

The editor will create two new files. The "CustomScript.lua" file located in the "Scripts\Entities\Motion" folder contains your script code. The "CustomScript.json" file located in the "Entity Definitions" folder contains script definitions extracted from the code file, and tells the editor what editable properties the code file contains.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/newcomponent3.png?raw=true)

The new script will include example properties of every supported type:
```lua
CustomScript.integervalue = 0--"Integer value"
CustomScript.floatvalue = 0.0--"Float value"
CustomScript.stringvalue = ""--"String value"
CustomScript.booleanvalue = false--"Boolean value"
CustomScript.optionvalue = 0--"Option value" ["Option 1", "Option 2", "Option 3"]
CustomScript.entityvalue = nil--"Entity value"
CustomScript.pathvalue = ""--"Path value" SOUND
CustomScript.vec2value = Vec2(0,0)--"Vec2 value"
CustomScript.vec3value = Vec3(0,0,0)--"Vec3 value"
CustomScript.vec4value = Vec4(0,0,0,0)--"Vec4 value"
CustomScript.rgbvalue = Vec3(1,1,1)--"RGB value" COLOR
CustomScript.rgbavalue = Vec4(1,1,1,1)--"RGBA value" COLOR
```
You can replace all those properties with just one:
```lua
CustomScript.rotationspeed = Vec3(0,0,0)--"Rotation speed"
```

By default, an Update function is present but contains no code:
```lua
function CustomScript:Update()

end
```

Replace the Update function with this code, which will cause the object to turn when the T key is pressed:
```lua
function CustomScript:Update()
	
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

## Flowgraph Editor

The flowgraph editor allows you to make connections between script inputs and outputs, to set up complex sequences of events. Open the scene "flowgraph.map". Press the **Flowgraph Editor** button in the left-side bar to view the flowgraph editor interface.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/flowgraphexample.png?raw=true)

The interface shows a connection between the two trigger field Collide outputs and the Open input on the corresponding door. When you run the game, stepping into the invisible trigger volume will cause each door to open.

You can add a custom input to the script we previously created. Just open the file "Scripts\Entities\Motion\CustomScript.lua" and add this function anywhere in the file. The "in" comment after the function declaration will tell the editor the function can be used as an input in the code editor:

```lua
function CustomScript:Turn()--in
	self.entity:Turn(self.rotationspeed)
end
```

Select the green box in the middle of the scene and switch to the flowgraph editor. You can drag the box into the flowgraph view to add it into the interface.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/addentitytoflowgraph.gif?raw=true)

You can drag a connection from the Collide output of both the trigger fields to the Turn input on the box.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/connect.gif?raw=true)

When you run the game now, stepping into the invisible trigger fields will open the corresponding door, but will also cause the green box to rotate.
