# Adding the Player

www.youtube.com/watch?v=Eiznn-zF6Ok

We now know enough that we can add a first-person player to a simple scene and run the game.

You can use the [downloads manager](downloadsmanager.md) to install the [player example scene](https://www.leadwerks.com/community/files/file/3588-player-example-scene/) into a blank project, or just follow the instructions below to recreate it.

First, create a box for the floor. It should be 1024x1024 cm, and 32 cm high.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/floor.png)

Next, create a single wall along one side. Make it 256 cm tall and about 64 cm thick.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/wall.png)

Create four more walls to enclose the area.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/walls.png)

Now add another box on top to make the ceiling. It should be 1024x1024 cm and 32 cm high:

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/ceiling.png)

Select the point light object in the object creation drop-down panel.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/playertestlight0.png)

Add a point light to the center of the room. In the [entity properties](entityproperties.png) dialog, set the light far range to 6 meters.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/playertestlight.png)

Now select the **Pivot** object from the object dialog.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/createpivot.png)

Create a pivot object in the center of the room at the floor.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/createpivot2.png)

Add a **FPSPlayer** component to the pivot.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/playercomponent.png)

Since this is an indoor scene, you can remove the specular and diffuse PBR reflection maps in thee [world settings](worldsettings.md) dialog.

You can also set the skybox to the _Materials\\Environment\\Default\\default.dds_ file using the [world settings](worldsettings.md) dialog.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/removeenvmaps.gif)

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/playertestlight2.png)

You're now ready to run the game. Select the **Game > Run** menu item to launch the game. If you are using a Lua project, the game is ready to run. If you are using a C++ project, then you must compile the Visual Studio project before the game executable will be available.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/playerrungame.jpg)

The scene you just created is a minimal example of a very simple game. You can use the mouse to look around. The WASD keys will control player movement. The space key will make the player jump.
