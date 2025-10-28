# Entity Scripting

www.youtube.com/watch?v=gV7un0VPeZ0

The Leadwerks entity script system allows you to attach properties and functions directly to entities in your game.

## Creating Entity Scripts

To create a new entity script, press the '+' button that appears below the **Scene** tab in the right-side panel. Select the **New Entity Script** popup menu that appears.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/newcomponent.png?raw=true)

In the New Entity Script dialog, select the group you want to place your script in and enter the name for your new script:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/myplayercomponent.png?raw=true)

The editor will create a new Lua file in the appropriate folder. The Lua file contains your script code. A JSON file will also be added to the "Entity Definitions" folder. This contains property definitions extracted from the code file, and tells the editor what editable properties the script contains.

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
	
	self:Move(movex, 0, movez)

end
```

Now we need to create a simple scene to test the script in. Create a large flat box for the floor. Create a small box for the player, change the color to make it stand out, and add your new script to it. Finally, add a camera that points down at a 45 degree angle, so that it can see most of the floor. You can also set the skybox to the default sky in the [world properties](worldsettings.md) dialog, if you wish.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/myplayercomponent3.png?raw=true)

Once your scene is set up, you can run the game to try your new script. You should be able to control the player box with the arrow keys.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/myplayercomponent4.png?raw=true)

Now let's change the script so that it automatically creates a camera and updates it each frame, to follow the player. Delete the camera from your scene and replace the script code with this:

```lua
MyPlayer = {}
MyPlayer.name = "MyPlayer"

MyPlayer.speed = 0.02--"Speed"
MyPlayer.cameradistance = 2--"Camera distance"

function MyPlayer:Start()
	self.camera = CreateCamera(self.world)
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
	
	self:Move(movex, 0, movez)

	--Update camera
	self.camera:SetPosition(self:GetPosition())
	self.camera:SetRotation(45,0,0)
	self.camera:Move(0,0,-self.cameradistance)

end
```
When you run the game, the camera will follow the player around as you move with the arrow keys.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/myplayercomponent6.gif?raw=true)

## Script Properties

When a new script is created, it will include example properties for every supported type:

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

You can add new properties or edit these ones. Whenever you save a script, the editor will automatically detect the changed file, and update the JSON file stored in the "Entity Definitions" folder.

## Script Functions and the Flowgraph Editor

Script functions can be marked as inputs and/or outputs, for use with the [flowgraph editor](flowgrapheditor.md). To do this, just add a comment after the function declaration:

```
-- Function can act as a flowgraph input
function CustomScript:MyFunction()--in
end

-- Function can act as a flowgraph output
function CustomScript:MyFunction2()--out
end

-- Function can act as an input or an output
function CustomScript:MyFunction3()--inout
end
```

## Common Properties and Functions

The stock scripts included in a new project make assumptions about some commonly used properties many types of objects may make use of. These are not strict rules you have to follow, but when scripts follow these guidelines they will enjoy greater interoperability with other community-created scripts.

| Name | Type | Description |
|---|---|---|
| camera | [Camera](Camera.md) | usually for player controllers, this is a camera created in code and associated with the entity. |
| health | integer | if greater than zero, the object is alive, if zero or less the object is dead. If this is nil the object is inanimate. |
| score | integer | general-purpose score value |
| team | integer | number indicating an object's team affiliation. It is generally understood that 0 means good, 1 means bad, and 2 means neutral, but you can set up whatever team values you want. |

The following methods are commonly used in entity scripts and can provide increased interoperability in your scripts:

| Name | Syntax | Description |
|---|---|---|
| Damage | Damage(integer amount, [Entity](Entity.md) attacker) | Applies damage to an object. The _attacker_ argument may be nil. |
| Kill | Kill([Entity](Entity.md) attacker) | Instantly kills an object. The _attacker_ argument may be nil. |
