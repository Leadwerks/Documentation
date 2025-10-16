# 2D Graphics

In this lesson we will learn about 2D drawing and screen orientation, with a focus on the spatial properties of screen coordinates and 2D tiles.

## Screen Coordinates

There is a long-standing convention in computer graphics that considers the upper-left corner of the screen to be position (0, 0). Moving to the right of the screen increases the X coordinate, as expected, but in screen coordinates moving down the screen also increases the Y coordinate. This is the opposite of a 3D coordinate system where the positive Y direction points up. This is probably because text in most languages reads from the top down, so if you are designing a user interface it makes sense to start at the top-left corner.

The diagram below shows the coordinates at the corners, halfway along the edges, and in the center of a 1280 x 720 screen.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/screencoords.png?raw=true)

We may work with windows of different sizes, so rather than hard-coding the coordinates, we can always get screen coordinates for a window of any size with the following formulas:

| Coordinate | Location |
|--|--|
| 0, 0 | top-left of the screen |
| framebuffer.size.x, 0 | top-right of the screen |
| framebuffer.size.x / 2, framebuffer.size.y / 2 | center of the screen |
| 0, framebuffer.size.y | bottom-left of the screen |
| framebuffer.size.x, framebuffer.size.y | bottom-right of the screen |

## Tiles

Leadwerks 5 uses persistent objects that stay on the screen. This provides better performance and easier management of 2D shapes. The basic drawing primitive in Leadwerks is called a [Tile](Tile.md). Tiles come in three forms and can be used to display rectangles, images, or text.

### Tile Orientation

Like screen coordinates, a tile's position is oriented around its upper-left corner. This way if you position a tile at (0, 0) it will be visible in the top-left corner of the screen.

The code below creates a single tile and places it at coordinate (10, 10).

```lua
--Get the displays
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Leadwerks", 0, 0, 1280, 720, displays[1], WINDOW_TITLEBAR | WINDOW_CENTER)

--Create a framebuffer
local framebuffer = CreateFramebuffer(window)

--Create a world
local world = CreateWorld()

--Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)

--Load a tile from an image
local tile = CreateTile(world, 150, 150)
tile:SetColor(0,0,1)

--Set the tile position
tile:SetPosition(10, 10)

while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do
	
	--Update the world
	world:Update()
	
	--Render the world
	world:Render(framebuffer)
end
```
Here is the result when the code is run. The tile is indented a little bit (10 pixels, to be exact) from the top-left corner:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/tileupperleft.png?raw=true)

To place the tile in the lower-right corner of the screen, you have to take the tile's width and height into account. Replace the tile:SetPosition command at line 22 with this code:

```lua
tile:SetPosition(framebuffer.size.x - tile.size.x - 10, framebuffer.size.y - tile.size.y - 10)
```

When you run the code again, the tile will appear in the bottom-right corner, with 10 pixels of indentation.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/tilelowerright.png?raw=true)

You can use this code to place the tile in the exact center of the screen, but you must remember to subtract half the width and height from the coordinate:

```lua
tile:SetPosition(framebuffer.size.x / 2 - tile.size.x / 2, framebuffer.size.y / 2 - tile.size.y / 2)
```

### Tile Handles

Optionally, we can add an offset to the tile handle so that it is oriented around a different point, using the [Tile:SetHandle](Tile_SetHandle.md) command. This can be used to shift the tile over so that it is oriented around its center.

```lua
tile:SetHandle(-tile.size.x / 2, -tile.size.y / 2)
tile:SetPosition(framebuffer.size.x / 2, framebuffer.size.y / 2)
```
Here is a diagram showing a tile with the default orientation on the left, and with the handle shifted to the center on the right:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/tilehandle.png?raw=true)

The [Tile:MidHandle](Tile_MidHandle) command will automatically set the center of the tile as its handle, without the need to specify any parameters:

```lua
tile:MidHandle()
tile:SetPosition(framebuffer.size.x / 2, framebuffer.size.y / 2)
```

### Tile Rotation

We can rotate a tile using the [Tile:SetRotation](Tile_SetRotation.md) or [Tile:Turn](Tile_Turn.md) commands. Unless we change the handle position, a tile will rotate around its upper-left corner:

```lua
--Get the displays
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_TITLEBAR | WINDOW_CENTER)

--Create a framebuffer
local framebuffer = CreateFramebuffer(window)

--Create a world
local world = CreateWorld()

--Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)

--Load a tile from an image
local tile = CreateTile(world, 150, 150)
tile:SetColor(0,0,1)

--Set the tile position in the center of the screen
tile:SetPosition(framebuffer.size.x / 2 - tile.size.x / 2, framebuffer.size.y / 2 - tile.size.y / 2)

while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do
	
	--Rotate the tile
	tile:Turn(1)
	
	--Update the world
	world:Update()
	
	--Render the world
	world:Render(framebuffer)
end
```

We can use the [Tile:MidHandle](Tile_MidHandle.md) to center the tile, which is usually best for rotation:

```lua
--Get the displays
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_TITLEBAR | WINDOW_CENTER)

--Create a framebuffer
local framebuffer = CreateFramebuffer(window)

--Create a world
local world = CreateWorld()

--Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)

--Load a tile from an image
local tile = CreateTile(world, 150, 150)
tile:SetColor(0,0,1)

--Set the tile position in the center of the screen
tile:MidHandle()
tile:SetPosition(framebuffer.size.x / 2, framebuffer.size.y / 2)

while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do
	
	--Rotate the tile
	tile:Turn(1)
	
	--Update the world
	world:Update()
	
	--Render the world
	world:Render(framebuffer)
end
```

We can use the [Angle](Angle.md) command to convert a 2D coordinate into a rotation.

```lua
--Get the displays
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_TITLEBAR | WINDOW_CENTER)

--Create a framebuffer
local framebuffer = CreateFramebuffer(window)

--Create a world
local world = CreateWorld()

--Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0)

--Get the screen center
local cx = framebuffer.size.x / 2
local cy = framebuffer.size.y / 2

--Load a tile from an image
local tile = LoadTile(world, "https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Assets/Materials/Sprites/nightraider.png")
tile:MidHandle()
tile:SetPosition(cx, cy)

--Main loop
while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do

	--Get the mouse position
	local mousepos = window:GetMousePosition()

	--Get the rotation
	local a = Angle(mousepos.x - cx, mousepos.y - cy)

	--Set the tile rotation
    tile:SetRotation(a)

    --Update the world
    world:Update()

    --Render the world
    world:Render(framebuffer)
end
```

Here we are taking the mouse position, subtracting the center of the screen, and then converting the resulting coordinate into an angle. When we move the mouse, the spaceship will turn to face it. 

![](https://github.com/UltraEngine/Documentation/blob/master/Images/angle.png?raw=true)

Also note that this example used the [LoadTile](LoadTile.md) function, which loads an image from a file, then uses the image width and height for the tile size.

#### Interpolation of Rotation

In our example above, the spaceship rotates instantly to point towards the mouse cursor. If we want, we can add interpolation to smooth out the motion for a better visual result. Let's try using the Mix command on the angle, like we did for position in the previous lesson:

```lua
--Get the displays
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_TITLEBAR | WINDOW_CENTER)

--Create a framebuffer
local framebuffer = CreateFramebuffer(window)

--Create a world
local world = CreateWorld()

--Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0)

--Get the screen center
local cx = framebuffer.size.x / 2
local cy = framebuffer.size.y / 2

--Load a tile from an image
local tile = LoadTile(world, "https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Assets/Materials/Sprites/nightraider.png")
tile:MidHandle()
tile:SetPosition(cx, cy)

--Main loop
while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do

	--Get the mouse position
    local mousepos = window:GetMousePosition()

	--Get the rotation
    local a = Angle(mousepos.x - cx, mousepos.y - cy)

	--Display the rotation in the window titlebar
	window:SetText(tostring(a))
	
	--Smooth the angle with linear interpolation
	local smoothangle = Mix(tile:GetRotation(), a, 0.05)

	--Rotate the tile with the angle
    tile:SetRotation(smoothangle)

    --Update the world
    world:Update()

    --Render the world
    world:Render(framebuffer)
end
```

This code mostly works, but if we move the mouse up and down on the right side of the spaceship, it will suddenly spin around, taking the longer route to get to the desired angle. This happens when it is interpolating between a value like 355 and 5. Instead of taking the short route, which is to increase the angle until it hits 360 and resets to zero, it takes the long way around the circle.

To fix this, just replace the Mix command with a special command for rotations called [MixAngle](MixAngle,md). This command is meant for use with rotations and will always take the shortest route to the desired rotation.

```lua
	--Smooth the angle with linear interpolation
	local smoothangle = MixAngle(tile:GetRotation(), a, 0.05)
```

Alternatively, we can use the angular equivalent for the Step command, [StepAngle](StepAngle,md). This will make the spaceship rotate at a constant speed until the desired angle is reached. The motion will appear more robotic, and might be good for things like turrets tracking the player:

```lua
	--Use constant motion towards the desired angle
	local smoothangle = StepAngle(tile:GetRotation(), a, 1)
```

Another handy command you may sometimes need is the [DeltaAngle](DeltaAngle.md) function. This will return the difference between two angles, always using the shortest distance around the circle.

### Displaying Text

Text objects can be created with the [CreateTile](CreateTile.md) command. To create a text tile, you must first load a font from a .ttf (True-type Font) file.

You can specify the orientation a text tile has in the optional alignment parameter. TEXT_LEFT, TEXT_CENTER, and TEXT_RIGHT will control the horizontal alignment of the text, while TEXT_TOP, TEXT_MIDDLE, and TEXT_BOTTOM control the vertical alignment. Like rectangles, text tiles by default are oriented around their upper-left corner.

This example will create a text tile with its handle in the horizontal and vertical center, place it at the center of the screen, and rotate it continuously:

```lua
--Get the displays
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_TITLEBAR | WINDOW_CENTER)

--Create a framebuffer
local framebuffer = CreateFramebuffer(window)

--Create a world
local world = CreateWorld()

--Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)

--Load a font
local font = LoadFont("Fonts/Arial.ttf")

--Create a text tile
local tile = CreateTile(world, font, "Welcome to Leadwerks 5!", 72, TEXT_CENTER | TEXT_MIDDLE)
tile:SetPosition(framebuffer.size.x / 2, framebuffer.size.y / 2)
tile:SetColor(0,1,1)

while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do

	--Rotate the tile
    tile:Turn(1)

    --Update the world
    world:Update()

    --Render the world
    world:Render(framebuffer)
end
```

Here is the result when the program is run:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/texttile.jpg?raw=true)

We can use the text alignment flags to easily fit text into a corner or on an edge, without any complicated positioning:

```lua
--Get the displays
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_TITLEBAR | WINDOW_CENTER)

--Create a framebuffer
local framebuffer = CreateFramebuffer(window)

--Create a world
local world = CreateWorld()

--Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)

--Load a font
local font = LoadFont("Fonts/Arial.ttf")

--Create a text tile in the lower-left corner
local tile1 = CreateTile(world, font, "Upper Left", 36, TEXT_LEFT | TEXT_TOP)
tile1:SetColor(1,0.25,0.25)
tile1:SetPosition(0, 0)

--Create a text tile in the lower center
local tile2 = CreateTile(world, font, "Upper Center", 36, TEXT_CENTER | TEXT_TOP)
tile2:SetColor(0.25,1,0.25)
tile2:SetPosition(framebuffer.size.x / 2, 0)

--Create a text tile in the lower-right corner
local tile3 = CreateTile(world, font, "Upper Right", 36, TEXT_RIGHT | TEXT_TOP)
tile3:SetColor(0.25,0.25,1)
tile3:SetPosition(framebuffer.size.x, 0)

--Create a text tile in the lower-left corner
local tile4 = CreateTile(world, font, "Middle Left", 36, TEXT_LEFT | TEXT_MIDDLE)
tile4:SetColor(1,0.25,0.25)
tile4:SetPosition(0, framebuffer.size.y / 2)

--Create a text tile in the lower center
local tile5 = CreateTile(world, font, "Middle Center", 36, TEXT_CENTER | TEXT_MIDDLE)
tile5:SetColor(0.25,1,0.25)
tile5:SetPosition(framebuffer.size.x / 2, framebuffer.size.y / 2)

--Create a text tile in the lower-right corner
local tile6 = CreateTile(world, font, "Middle Right", 36, TEXT_RIGHT | TEXT_MIDDLE)
tile6:SetColor(0.25,0.25,1)
tile6:SetPosition(framebuffer.size.x, framebuffer.size.y / 2)

--Create a text tile in the lower-left corner
local tile7 = CreateTile(world, font, "Lower Left", 36, TEXT_LEFT | TEXT_BOTTOM)
tile7:SetColor(1,0.25,0.25)
tile7:SetPosition(0, framebuffer.size.y)

--Create a text tile in the lower center
local tile8 = CreateTile(world, font, "Lower Center", 36, TEXT_CENTER | TEXT_BOTTOM)
tile8:SetColor(0.25,1,0.25)
tile8:SetPosition(framebuffer.size.x / 2, framebuffer.size.y)

--Create a text tile in the lower-right corner
local tile9 = CreateTile(world, font, "Lower Right", 36, TEXT_RIGHT | TEXT_BOTTOM)
tile9:SetColor(0.25,0.25,1)
tile9:SetPosition(framebuffer.size.x, framebuffer.size.y)

--Main loop
while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do

    --Update the world
    world:Update()

    --Render the world
    world:Render(framebuffer)
end
```
When this example is run, three rows and columns of text will appear, with a tile on each edge, in each corner, and in the center of the screen:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/2dtextalignment.png?raw=true)

The Tile class is meant to provide a simple way to draw 2D shapes on the screen. If you want to create more advanced user interfaces with support for DPI scaling, see the [GUI system](GUI.md).
