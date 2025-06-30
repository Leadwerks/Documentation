# Player Controls

We now know enough that we can add a first-person player to a simple scene and run the game.

You can use the [downloads manager](downloadsmanager.md) to install the [player example scene](https://www.leadwerks.com/community/files/file/3588-player-example-scene/) into a blank project, or just follow the instructions below to recreate it.

First, create a box for the floor. It should be 1024x1024 cm, and 32 cm high.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/floor.png)

Next, create a single wall along one side. Make it 256 cm tall and about 64 cm thick.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/wall.png)

Create four more walls to enclose the area.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/walls.png)

Now select the **Pivot** object from the object dialog.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/createpivot.png)

Create a pivot object in the center of the room at the floor.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/createpivot2.png)

Add a **FPSPlayer** component to the pivot.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/playercomponent.png)

You can also set the skybox to the _Materials\\Environment\\Default\\default.dds_ file using the [world settings](worldsettings.md) dialog.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/playersky.png)

You're now ready to run the game. Select the **Game > Run** menu item to launch the game. If you are using a Lua project, the game is ready to run. If you are using a C++ project, then you must compile the Visual Studio project before the game executable will be available.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Images/playerrungame.jpg)

The scene you just created is a minimal example of a very simple game. You can use the mouse to look around. The WASD keys will control player movement. The space key will make the player jump.
