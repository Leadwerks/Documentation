# 3D Spatialization

This tutorial series will help you develop your 3D spatial visualization abilities, and teach you what tools are available to help you make games. Developing these skills will give you the ability to easily visualize how all games can be made.

We will cover some mathematics in the series, but not very much. It's more important to understand what the math does, rather than memorizing equations or solving problems by hand.

A notebook with graph paper is a great tool for every game developer to have with them at all times, along with a pen or pencil and ruler. These items will allow you to sketch out your ideas whenever and wherever they occur, and the physical act of drawing with your hands on paper will help you train your brain to think in 3D.

## One-dimensional Space

I like to picture numbers in a row, with negative numbers to the left, zero in the middle, and positive numbers to the right. This is called a _number line_:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/numberline.png?raw=true)

Often times we want to move from one number to another over time. Let's say we want to gradually change a value from 1 to 5.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/numberline1-5.png?raw=true)

There are two main ways we can achieve this, that will each give a difference appearance.

### Constant Motion

The [Step](Step.md) function will move a constant amount from the current value to a target value.

```lua
local n = 0
local target = 5

while n < target do
  n = Step(n, target, 1)
  Print(n)
end
```

The output of the program looks like this:

```txt
2
3
4
5
```

Each time the function runs, it is adding one to the value, until the target value is reached.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/numberline1-5_step.png?raw=true)

Because the difference between five and one equals four, it takes four even steps to reach the target value.

### Linear Interpolation

Often times in games we want to avoid sudden movements, and prefer nice smooth motion. The [Mix](Mix.md) function is great for smoothing out motion. It accepts a starting value, a target value, and a decimal number to combine the two numbers with. This type of motion is called linear interpolation.

Internally, the Mix function uses this equation:

```lua
function Mix(start, target, p)
  return start * (1.0 - p) + target * p
end
```

If the p value equals zero, then the start value is returned. If the p value is one, then the target value is returned. If the p value is 0.5, then a number halfway in between the start and target values is returned. This code, for example, will print out the numbers 1, 3, and 5:

```lua
Print(Mix(1, 5, 0))-- returns the first value
Print(Mix(1, 5, 0.5))-- returns halfway between the first and second values
Print(Mix(1, 5, 1))-- returns the second value
```

Back to our number line now. If we use the Mix function in a loop, using the returned value as the starting value the next time the function is called, we see some interesting results:

```lua
local n = 1
local target = 5

while n < target do
  n = Mix(n, target, 0.5)
  Print(n)
end
```

The first iteration of the loop prints 3, then 4, then 4.5, and so on. Each time the returned number gets closer to the target value, but it moves less and less each time until it finally reaches 5.

```txt
3.0
4.0
4.5
4.75
4.875
4.9375
4.96875
4.984375
4.9921875
4.99609375
4.998046875
4.9990234375
4.99951171875
4.999755859375
4.9998779296875
4.9999389648438
4.9999694824219
4.9999847412109
4.9999923706055
4.9999961853027
4.9999980926514
4.9999990463257
4.9999995231628
5.0
```

On a number line, the first few steps would look like the image below. Notice how each step is half the size of the previous one:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/numberline1-5_lerp.png?raw=true)

This has some interesting implications for games:
- If the target value is far away from the current value, the target value will change quickly to catch up.
- As the current value gets closer and closer to the target value, the movement slows down.

Let's put our math into action and see what constant and smooth motion look like on the screen, with this simple program. You can copy and paste this code into the Main.lua file of a new Lua project.

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

--Create a tile to show constant motion
local tile1 = CreateTile(world, 100, 100)
tile1:SetColor(0,1,0)

--Create a tile to show smooth motion
local tile2 = CreateTile(world, 100, 100)
tile2:SetColor(0,0,1)

local x1 = 0
local x2 = 0
local y = framebuffer.size.y / 2-- half the screen height
local target = 0

while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do
	
	--Move the target to the right side of the screen
	if window:KeyHit(KEY_RIGHT) then target = framebuffer.size.x - 100 end
	
	--Move the target to the left side of the screen
	if window:KeyHit(KEY_LEFT) then target = 0 end
	
	--Constant motion
	x1 = Step(x1, target, 10)
	tile1:SetPosition(x1, y - 100)
	
	--Smooth motion
	x2 = Mix(x2, target, 0.05)
	tile2:SetPosition(x2, y)
	
	--Update the world
	world:Update()
	
	--Render the world
	world:Render(framebuffer)
end
```

Press the left and right keys to move the target value to the either side of the screen, and watch how the two boxes move. Although they both start and stop in the same position, their motion looks very different. The green box moves at a constant speed, while the blue cube snaps like a rubber band, then slows down gradually.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/motion.gif?raw=true)

We can use the Mix function as a general smoothing technique. In the example below, the arrow keys will move the green box left and right.

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

--Create a tile to show constant motion
local tile1 = CreateTile(world, 100, 100)
tile1:SetColor(0,1,0)
tile1:MidHandle()
tile1:SetPosition(framebuffer.size.x / 2, framebuffer.size.y / 2 - 50, 0)

--Create a tile to show smooth motion
local tile2 = CreateTile(world, 100, 100)
tile2:SetColor(0,0,1)
tile2:MidHandle()
tile2:SetPosition(framebuffer.size.x / 2, framebuffer.size.y / 2 + 50, 0)

local y = framebuffer.size.y / 2-- half the screen height

while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do
	
	--Move the green tile to the right
	if window:KeyDown(KEY_RIGHT) then tile1:SetPosition(tile1.position.x + 10, tile1.position.y) end
	
	--Move the green tile to the left
	if window:KeyDown(KEY_LEFT) then tile1:SetPosition(tile1.position.x - 10, tile1.position.y) end
	
	--Make the blue tile follow the green tile, with smooth motion
	local x = Mix(tile2.position.x, tile1.position.x, 0.05)
	tile2:SetPosition(x, tile2.position.y)
	
	--Update the world
	world:Update()
	
	--Render the world
	world:Render(framebuffer)
end
```

When we run this code, the blue box will follow along the same horizontal position, using the Mix function to smoothly interpolate between its current position and its destination.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/smoothmotion.gif?raw=true)

## Two-dimensional Space

Now we are going to add a second dimension to our number line, in the form of a second number line going up and down. A 2D number line is called a grid. Each coordinate on the grid has two numbers that indicate the X (horizontal) and Y (vertical) position. In the grid below, I have marked one coordinate in each quadrant of the grid. You can see how the sign of each number in a 2D coordinate indicates which side of the horizontal or vertical line the coordinate is on.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/2dgrid.png?raw=true)

The center of the grid, coordinate (0, 0), is called the _origin_. If you hear something like "distance to the origin" it just means "distance to the center of the grid".

If we apply the second dimension to our previous example, we can make one box smoothly follow another. Run this code and use the left, right, up, and down keys to move the object around the screen.

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

--Create a tile to show constant motion
local tile1 = CreateTile(world, 100, 100)
tile1:SetColor(0,1,0)
tile1:MidHandle()
tile1:SetPosition(framebuffer.size.x / 2, framebuffer.size.y / 2, 0)

--Create a tile to show smooth motion
local tile2 = CreateTile(world, 100, 100)
tile2:SetColor(0,0,1)
tile2:MidHandle()
tile2:SetPosition(tile1.position)

while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do
	
	--Move the green tile to the right
	if window:KeyDown(KEY_RIGHT) then tile1:SetPosition(tile1.position.x + 10, tile1.position.y) end
	
	--Move the green tile to the left
	if window:KeyDown(KEY_LEFT) then tile1:SetPosition(tile1.position.x - 10, tile1.position.y) end
		
	--Move the green tile up
	if window:KeyDown(KEY_UP) then tile1:SetPosition(tile1.position.x, tile1.position.y - 10) end
	
	--Move the green tile down
	if window:KeyDown(KEY_DOWN) then tile1:SetPosition(tile1.position.x, tile1.position.y + 10) end
	
	--Make the blue tile follow the green tile, with smooth motion
	local x = Mix(tile2.position.x, tile1.position.x, 0.05)
	local y = Mix(tile2.position.y, tile1.position.y, 0.05)
	
	--Position the blue tile
	tile2:SetPosition(x, y)
	
	--Update the world
	world:Update()
	
	--Render the world
	world:Render(framebuffer)
end
```

You might have noticed that we are adding 10 to the Y position when we press the down key, and subtracting 10 when we press the up key. This is because screen coordinates are flipped upside-down compared to how we would draw them on a piece of paper. This will be explained in more detail in the next lesson.

Here you can see the motion working on both the X and Y axes:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/2dsmoothmotion.gif?raw=true)

This gives me an idea! Let's replace the blue tile with an image of a spaceship.

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

local x = framebuffer.size.x / 2
local y = framebuffer.size.y / 2

--Load a tile from an image
local tile = LoadTile(world, "https://raw.githubusercontent.com/Leadwerks/Documentation/refs/heads/master/Assets/Materials/Sprites/nightraider.png")
tile:MidHandle()
tile:SetPosition(x, y)

while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do
	
	--Move right
	if window:KeyDown(KEY_RIGHT) then x = x + 10 end
	
	--Move left
	if window:KeyDown(KEY_LEFT) then x = x - 10 end
		
	--Move up
	if window:KeyDown(KEY_UP) then y = y - 10 end
	
	--Move down
	if window:KeyDown(KEY_DOWN) then y = y + 10 end
	
	--Make the blue tile follow the green tile, with smooth motion
	smoothx = Mix(tile.position.x, x, 0.1)
	smoothy = Mix(tile.position.y, y, 0.1)
	
	--Position the blue tile
	tile:SetPosition(smoothx, smoothy)
	
	--Update the world
	world:Update()
	
	--Render the world
	world:Render(framebuffer)
end
```

When we run the code, we can use the arrow keys to move the spaceship around the screen.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/2dspaceship.gif?raw=true)

The space ship has nice smooth motion, exactly like what you would see in a game!
