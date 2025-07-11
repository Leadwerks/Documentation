# Components

www.youtube.com/watch?v=OjQDJKFnYq0

The Leadwerks Entity Component System (ECS) uses Lua code and tables to attach properties and functions to entities in your game.

## Creating Components

To create a new component, press the '+' button that appears below the **Scene** tab in the right-side panel. Select the **New Component** popup menu that appears.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/newcomponent.png?raw=true)

In the New Component dialog, select the group you want to place your component in and enter the name for your new component:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/myplayercomponent.png?raw=true)

The editor will create two new files in the appropriate folder. The Lua file contains your component code. The JSON file contains component definitions extracted from the code file, and tells the editor what editable properties the code file contains.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/myplayercomponent2.png?raw=true)

Open the MyPlayer.lua code file in the script editor and replace it with this code:

```lua
MyPlayer = {}
MyPlayer.name = "MyPlayer"

MyPlayer.speed = 0.02--"Speed"

function MyPlayer:Update()

	--Get the game window
	local window = ActiveWindow()
	if window == nil then return end

	--Player controls
	local movex = 0
	local movez = 0
	
	if window:KeyDown(KEY_LEFT) then movex = movex - self.speed end
	if window:KeyDown(KEY_RIGHT) then movex = movex + self.speed end

	if window:KeyDown(KEY_DOWN) then movez = movez - self.speed end
	if window:KeyDown(KEY_UP) then movez = movez + self.speed end
	
	self.entity:Move(movex, 0, movez)

end
 
RegisterComponent("MyPlayer", MyPlayer)
return MyPlayer
```

Now we need to create a simple scene to test the component in. Create a large flat box for the floor. Create a small box for the player, change the color to make it stand out, and add your new component to it. Finally, add a camera that points down at a 45 degree angle, so that it can see most of the floor. You can also set the skybox to the default sky in the [world properties](worldsettings.md) dialog, if you wish.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/myplayercomponent3.png?raw=true)

Once your scene is set up, you can run the game to try your new component. You should be able to control the player box with the arrow keys.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/myplayercomponent4.png?raw=true)

Now let's change the component so that it automatically creates a camera and updates it each frame, to follow the player. Delete the camera from your scene and replace the component code with this:

```lua
MyPlayer = {}
MyPlayer.name = "MyPlayer"

MyPlayer.speed = 0.02--"Speed"
MyPlayer.cameradistance = 2--"Camera distance"

function MyPlayer:Start()
	self.camera = CreateCamera(self.entity.world)
end

function MyPlayer:Update()

	--Get the game window
	local window = ActiveWindow()
	if window == nil then return end

	--Player controls
	local movex = 0
	local movez = 0
	
	if window:KeyDown(KEY_LEFT) then movex = movex - self.speed end
	if window:KeyDown(KEY_RIGHT) then movex = movex + self.speed end

	if window:KeyDown(KEY_DOWN) then movez = movez - self.speed end
	if window:KeyDown(KEY_UP) then movez = movez + self.speed end
	
	self.entity:Move(movex, 0, movez)

	--Update camera
	self.camera:SetPosition(self.entity:GetPosition())
	self.camera:SetRotation(45,0,0)
	self.camera:Move(0,0,-self.cameradistance)

end
 
RegisterComponent("MyPlayer", MyPlayer)
return MyPlayer
```
When you run the game, the camera will follow the player around as you move with the arrow keys.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/myplayercomponent6.gif?raw=true)
