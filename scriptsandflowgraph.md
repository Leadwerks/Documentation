# Scripts and the Flowgraph


You can download the sample scene for this tutorial [here](https://www.leadwerks.com/community/files/file/3592-entity-scripts-sample/) or use the [downloads manager](downloadsmanager.md) to install the package into a new Lua project.

## Entity Script System

The Leadwerks entity script system allows you to attach code files to objects in the scene to give them additional properties and behavior in the game. Open the scene "ScriptAndFlowgraph.map" from the sample package. You'll find four simple doorways, with a blue door in the middle. The two doors in the front have no script. The two doors in the back already have the SwingingDoor and SlidingDoor scripts added to them. The two doors in the back also have a transparent box around them, with a CollisionTrigger script added to each.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/ScriptAndFlowgraph.png?raw=true)

If you select the **Game > Run** menu item to run the game, you can use the WASD keys to move around. Without any modifications, the two rear doors will open if you approach them and press the **E** key.

### Sliding Doors

The two doors in the front don't have a script added to them yet, so let's fix that. Select the door on the right (Door4), and in the **Scene** tab, under the entity properties, press the **Add Entity Script** button. Select the **Physics > SlidingDoor** item and double-click on it, to add the script to the entity.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/addscript1.png?raw=true)

If we run the game now, we can walk up to the door and open it by pressing the **E** key. However, the door only opens partially. Let's exit the game and fix this.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/doorscript1.jpg?raw=true)

We can see in the _Back_ and _Top_ viewports that the door is 192 cm wide.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/swingingdoorscript3.png?raw=true)

Therefore, we just need to change the X component of the SlidingDoor Movement property to 192, and it should open all the way.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/doorscript2.png?raw=true)

Run the game again, and you can see the door opens all the way now.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/doorscript3.jpg?raw=true)

### Swinging Door Script

Let's do the same thing for the left front door, but this time we will use the swinging door script. Select the door on the left (Door3), and in the **Scene** tab, under the entity properties, press the **Add Entity Script** button. Select the **Physics > SwingingDoor** item and double-click on it, to add the script to the entity.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/swingingdoorscript1.png?raw=true)

When we run the game, the door will rotate to open when we approach it and press the **E** key, but it's rotating around the object center. This is probably not the behavior we want:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/swingingdoorscript2.jpg?raw=true)

We can see in the _Top_ viewport that the door is 192 cm wide.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/swingingdoorscript3.png?raw=true)

Therefore, we just need to set the X component of the Offset property to 192 / 2, which is equal to 96 cm.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/swingingdoorscript5.png?raw=true)

When we run the game now, the door will rotate around the edge like we want:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/swingingdoorscript4.jpg?raw=true)

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
