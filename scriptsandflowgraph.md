# Scripts and the Flowgraph

www.youtube.com/watch?v=eww15sH0rSk

You can download two sample scenes for this tutorial [here](https://www.leadwerks.com/community/files/file/3592-entity-scripts-sample/) or use the [downloads manager](downloadsmanager.md) to install the package into a new Lua project.

## Entity Script System

The Leadwerks entity script system allows you to attach code files to objects in the scene to give them additional properties and behavior in the game. Open the scene "ScriptAndFlowgraph.map" from the sample package. You'll find two blue boxes, one with the SwingingDoor script, and the other with the SlidingDoor script. There is also a pivot in the middle of the scene with the FPSPlayer script added to it.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/ScriptAndFlowgraph.png?raw=true)

If you select the **Game > Run** menu item to run the game, you can use the WASD keys to move around, and open either door by walking up to it and pressing the E key.

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
