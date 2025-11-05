# Axis-aligned Bounding Boxes

An axis-aligned bounding box (AABB) is a 3D box with volume. It is defined as having width, height, depth, a center position, and minimum and maximum extents.

www.youtube.com/watch?v=fZV4UD_6rRI

In Leadwerks this is handled with the [Aabb](Aabb.md) class, which has these members:

| Member | Type | Description |
|---|---|---|
| min | [Vec3](Vec3.md) | minimum extents of the bounding box |
| max | [Vec3](Vec3.md) | maximum extents of the bounding box |
| center | [Vec3](Vec3.md) | center position of the bounding box |
| size | [Vec3](Vec3.md) | size of the bounding box |
| radius | number | distance from the center of the box to any corner |

![](https://github.com/UltraEngine/Documentation/blob/master/Images/aabb.png?raw=true)

Axis-aligned bounding boxes are often used as a rough intersection test before more detailed calculations are made. In many cases this allows us to skip more expensive calculations on objects we know don't undersect the bounding box. "Axis-aligned" just means the box can't be rotated, which simplies a lot of calculations and makes them more efficient.

To define a bounding box, we just need to specify the minimum and maximum extents of the box, and the rest will be calculated automatically. The other members of the bounding box will be calculated automatically.

```lua
local aabb = Aabb(-2, -1, -1, 2, 1, 1)
Print(aabb.min)
Print(aabb.max)
Print(aabb.center)
Print(aabb.size)
Print(aabb.radius)
```

Here is the printed result when this code is run:

```txt
-2, -1, -1
2, 1, 1
0, 0, 0
4, 2, 2
2.44948983192443848
```

We can modify an Aabb at any time, but we need to remember to call the [Aabb:Update](Aabb_Update.md) method any time we do this. This method will calculate the center, size, and radius from the minimum and maximum extents.

```lua
--Create a bounding box around the origin
local aabb = Aabb(-1, -1, -1, 1, 1, 1)
Print(aabb.center)

--Shift the box to the right by 100 meters
aabb.min.x = 99
aabb.max.x = 101
Print(aabb.center)--Stil prints "0, 0, 0"

--Update the box center, size, and radius from the minimum and maximum extents
aabb:Update()

Print(aabb.center)--Prints the new center
```

## AABB Intersection Tests

We have several methods that can perform intersection tests using AABBs. Because these operations are very efficient, it's okay to use them many times without worrying about their impact on performance.

| Method | Description |
|---|---|
| [IntersectsPoint](Aabb_IntersectsPoint.md) | Tests the intersection of the box and a point in 3D space |
| [IntersectsAabb](Aabb_IntersectsAabb.md) | Tests the intersection of the box and another axis-aligned bounding box |
| [IntersectsLine](Aabb_IntersectsLine.md) | Tests the intersection of the box and a line in 3D space |
| [IntersectsPlane](Aabb_IntersectsPlane.md) | Tests the intersection of the box and a plane |

## Entity Bounds

Each entity has three bounding boxes we can retrieve, using the [Entity:GetBounds](Entity_GetBounds,md) method.

- The *local* bounding box encloses the entity, in its own local coordinate system.
- The *global* bounding box encloses the entity, in global space.
- The *recursive* bounding box encloses the entity and all of its children, in global space.

This example shows how entity bounding boxes can be tested to see if the objects intersect:

```lua
--Get the displays
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_TITLEBAR | WINDOW_CENTER)

--Create a framebuffer
local framebuffer = CreateFramebuffer(window)

--Create a world
local world = CreateWorld()
world:SetAmbientLight(1)

--Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:Move(0,0,-4)

--Create two boxes
local box1 = CreateBox(world)
box1:SetPosition(-1,0,0)

local box2 = CreateBox(world)
box2:SetPosition(1,0,0)

--Main loop
while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do
	
	local speed = 0.02
	if window:KeyDown(KEY_RIGHT) then box2:Move(speed,0,0) end
	if window:KeyDown(KEY_LEFT) then box2:Move(-speed,0,0) end
	if window:KeyDown(KEY_UP) then box2:Move(0,speed,0) end
	if window:KeyDown(KEY_DOWN) then box2:Move(0,-speed,0) end
	
	bounds1 = box1:GetBounds(BOUNDS_GLOBAL)
	bounds2 = box2:GetBounds(BOUNDS_GLOBAL)
	
	if bounds1:IntersectsAabb(bounds2, 0) then
		box1:SetColor(1,0,0)
		box2:SetColor(1,0,0)
	else
		box1:SetColor(0,1,0)
		box2:SetColor(0,1,0)		
	end
	
    --Update the world
    world:Update()
	
    --Render the world
    world:Render(framebuffer)
	
end
```

Entity bounding boxes can sometimes be a little bigger than they need to be to perfectly enclose the entire object, but they will never be smaller. If two entity bounding boxes intersect, the entities might intersect, but if their bounding boxes don't undersect, then they definitely don't intersect at all. We can see this in action if we replace the box creation code in the previous example with two spheres:

```lua
--Create two spheres
local box1 = CreateSphere(world)
box1:SetPosition(-1,0,0)

local box2 = CreateSphere(world)
box2:SetPosition(1,0,0)
```
