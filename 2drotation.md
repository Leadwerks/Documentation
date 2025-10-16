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
