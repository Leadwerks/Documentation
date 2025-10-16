# 3D Spatialization

This tutorial series will help you develop your 3D spatial visualization abilities, and teach you what tools are available to make 3D objects move around. Developing these skills will give you the ability to easily visualize how all games can be made.

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
```
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

We can use the Mix function as a general smoothing technique. In the example below, the arrow keys will move the green box left and right. The blue box will follow along the same horizontal position, using the Mix function to smoothly interpolate between its current position and its destination.

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

## Two-dimensional Space

Things get even more interesting when we add a second dimension on our number line, the Y axis. We can position objects using both the X and Y coordinate, but we can also rotate objects in 2D space, and we can also create 2D vectors.

### Rotation

Every point in 2D space besides the origin (0, 0) can form an angle. We can easily get the angle of any 2D coordinate with the [Angle](Angle.md) function. This always returns a value between 0 and 360.

A coordinate directly to the right of the origin like (1, 0) has an angle of 0 degrees. A coordinate directly above the origin, like (0, 1), has an angle of 90 degrees.

We can rotate an object just by adding a small amount to its current angle each frame.

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

--Get the screen center
local center = Vec2(framebuffer.size.x / 2, framebuffer.size.y / 2)

--Create a tile to show constant motion
local tile = CreateTile(world, 100, 100)
tile:SetColor(0,0,1)
tile:SetHandle(-50, -50)
tile:SetPosition(center.x, center.y)

while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do
	
	local mousepos = window:GetMousePosition()
	a = Angle(mousepos.x - center.x, mousepos.y - center.y)
	tile:SetRotation(a)
	
	--Update the world
	world:Update()
	
	--Render the world
	world:Render(framebuffer)
end
```

![](https://github.com/UltraEngine/Documentation/blob/master/Images/2dangle.gif?raw=true)

Just like motion, we can create smooth rotation using the Mix command. However, if you move the mouse all the way around the tile, you will see that a problem arises:

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

--Get the screen center
local center = Vec2(framebuffer.size.x / 2, framebuffer.size.y / 2)

--Create a tile to show constant motion
local tile = CreateTile(world, 100, 100)
tile:SetColor(0,0,1)
tile:SetHandle(-50, -50)
tile:SetPosition(center.x, center.y)

local a = 0
local target = 0

while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do
	
	--Get the mouse position
	local mousepos = window:GetMousePosition()
	
	--Get the new target angle and display it in the window titlebar
	target = Angle(mousepos.x - center.x, mousepos.y - center.y)
	window:SetText(tostring(Round(target)))
	
	--Calculate smooth rotation and apply it to the tile
	a = Mix(a, target, 0.1)
	tile:SetRotation(a)
	
	--Update the world
	world:Update()
	
	--Render the world
	world:Render(framebuffer)
end
```
The problem is that the target angle is crossing the edge of 0 / 360, and the interpolation starts moving in the wrong direction. We can fix this by using the [MixAngle](MixAngle.md) function, which always uses the shortest distance between two angles.

To fix this, just replace this line of code:
```lua
	a = Mix(a, target, 0.1)
```
with this one:
```lua
	a = MixAngle(a, target, 0.1)
```
This will provide nice smooth rotation that goes all the way around the box, always taking the shortest distance to the target angle.

### 2D Vectors

A vector is a line with a starting point and an end point. Vectors may seem simple, but they are surprisingly powerful once you know how to use them.

In Leadwerks, we have a [Vec2](Vec2.md) class that can represent either a 2D coordinate or a 2D vector with its starting point at the origin (0, 0).

#### Vector Addition and Subtraction

#### Vector Multiplication and Division

#### Inverting a Vector

We can make a vector point in the exact opposite direction just by multiplying its X and Y coordinates by negative one:

```lua
--Points to the right and up
v = Vec2(1, 1)

--Invert the vector
v = -v

--Points to the left and down (-1, -1)
Print(tostring(v.x)..", "..tostring(v.y))
```

#### Vector Length

The length of a vector is calculated with something called the Pythagorean theorum that the ancient Egyptians discovered while programming ancient computer games. If we treat the X and Y coordinate of a Vec2 object as the sides of a triangle, the length of the vector between that coordinate and the origin can be calculated like the hypotenuse (the long side) of a triangle:

Fortunately, we have a built-in function that does this, called [Vec2:Length](Vec2_Length.md).

```lua
v = Vec2(3, 4)

local len = v:Length()

Print(len)
```

#### Normalize

Sometimes we want a vector to have a length of exactly 1.0. The [Vec2:Normalize](Vec2_Normalize.md) method will do this:

```lua
v = Vec2(3, 4)

v = v:Normalize()

Print(tostring(v.x)..", "..tostring(v.y))
Print(v:Length())
```

If we want the vector to have some other length, we can just normalize it and then multiply it by the number we want.

```lua
v = Vec2(3, 4)

v = v:Normalize()
v = v * 2

Print(tostring(v.x)..", "..tostring(v.y))
Print(v:Length())
```

#### Distance to Point

If we

#### Dot Product

The dot product is a function that tells us how alike two vectors are. The dot product of two identical vectors is 1.0. The dot product of two vectors that point in the exact opposite directions is -1.0. The dot product of two vectors that are perpindular (form a 90 degree angle) is 0.0.

