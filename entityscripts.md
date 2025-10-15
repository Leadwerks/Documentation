# Entity Scripts

https://www.youtube.com/watch?v=-iOn8pHJn4I

You can download the sample scene for this tutorial [here](https://www.leadwerks.com/community/files/file/3592-entity-scripts-sample/) or use the [downloads manager](downloadsmanager.md) to install the package into a new Lua project.

The Leadwerks entity script system allows you to attach code files to objects in the scene to give them additional properties and behavior in the game. Open the scene "ScriptExample.map" from the sample package. You'll find four simple doorways, with a blue door in the middle. The two doors in the front have no script. The two doors in the back already have the SwingingDoor and SlidingDoor scripts added to them. The two doors in the back also have a transparent box around them, with a CollisionTrigger script added to each.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/ScriptAndFlowgraph.png?raw=true)

## FPSPlayer Script

If you select the Player pivot entity, you can see in the entity properties that it already has the FPSPlayer script added to it. This script will create a camera and provide player controls when the game is run.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/fpsplayerscript.png?raw=true)

If you select the **Game > Run** menu item to run the game, you can use the mouse and WASD keys to look and move around. Without any modifications, the two rear doors will open if you approach them and press the **E** key.

## Sliding Door Script

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

## Swinging Door Script

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

The flowgraph editor allows you to make connections between script inputs and outputs, to set up complex sequences of events. Press the _Flowgraph Editor_ button in the left side bar to open this tool.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/openflowgraph.gif?raw=true)

In this interface, you can see visual nodes that correspond to some objects in the scene. Left-click and drag a line to connect the Collide function on Trigger1 and Trigger2 to the Open function on Door1 and Door2:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/flowgraphconnect.gif?raw=true)

When you run the game now, simply stepping into the invisible trigger field around it will cause either of these doors to open.
