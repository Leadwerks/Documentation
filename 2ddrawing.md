# 2D Drawing

In this lesson we will learn about 2D drawing and screen orientation, with a focus on the spatial characteristics of screen coordinates and 2D tile objects.

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

## Tile Orientation

By default, a tile's position is oriented around its upper-left corner. This way if you position a tile at (0, 0) it will be visible in the top-left corner of the screen.

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

--Set the position in the upper-left corner of the screen
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

![](https://github.com/UltraEngine/Documentation/blob/master/Images/tilelowerleft.png?raw=true)

You can use this code to place the tile in the exact center of the screen, but you must remember to subtract half the width and height from the coordinate:

```lua
tile:SetPosition(framebuffer.size.x / 2 - tile.size.x / 2, framebuffer.size.y / 2 - tile.size.y / 2)
```

Optionally, we can add an offset to the tile handle so that it is oriented around a different point, using the [Tile:SetHandle](Tile_SetHandle.md) command. This can be used to shift the tile over so that it is oriented around its center:

```lua
tile:SetHandle(-tile.size.x / 2, -tile.size.y / 2)
tile:SetPosition(framebuffer.size.x / 2, framebuffer.size.y / 2)
```

The [Tile:MidHandle](Tile_MidHandle) command will automatically set the center of the tile as its handle, without the need to specify any parameters:

```lua
tile:MidHandle()
tile:SetPosition(framebuffer.size.x / 2, framebuffer.size.y / 2)
```

This command is also handy when we are using rotation, because we usually want a tile to rotate around its own center:

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

--Set the position in the lower-left corner of the screen
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
