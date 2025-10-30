# Planes

A plane is like an infinite surface rotated in any direction that divides th entire universe into two pieces. Everything is in the world is either in front of, behind, or exactly on the plane's surface.

You might not use planes directly when developing games, but they are an extremely powerful tool for solving difficult geometric problems, so it's good to know what they can do. Planes have two superpowers that are very useful for games:

- We can calculate the distance between any point in 3D space and the plane's surface.
- We can determine the intersection point of a line in 3D space with the plane.

A plane is defined as a normal and a distance to the origin:

| Member | Description |
|---|---|
| x | X component of the plane normal |
| y | Y component of the plane normal |
| z | Z component of the plane normal |
| d | distance to the origin |

Note that the distance to the plane is considered "distance in front of the plane". If the origin is behind the plane, the distance value will be nagative.

## Plane Constructors

There are several ways we can construct a plane:
- From a normal and a distance to the origin.
- From any point on the plane, and a normal.
- From three points on a triangle.

```lua
--From a normal and a distance to the origin:
local p1 = Plane(0, 1, 0, 2)-- nx, ny, nz, d

--From a point and a normal:
local p2 = Plane(Vec3(0,-2,0), Vec3(0,1,0))-- point, normal

--From a triangle (three points on the plane)
local p3 = Plane(Vec3(0,-2,0), Vec3(0,-2,1), Vec3(1,-2,0))-- A, B, C

--Display the results
Print(tostring(p1.x)..", "..tostring(p1.y)..", "..tostring(p1.z)..", "..tostring(p1.d))
Print(tostring(p2.x)..", "..tostring(p2.y)..", "..tostring(p2.z)..", "..tostring(p2.d))
Print(tostring(p3.x)..", "..tostring(p3.y)..", "..tostring(p3.z)..", "..tostring(p3.d))
```

## Plane-point Distance

The [Plane:DistanceToPoint](Plane_DistanceToPoint.md) method allows us to easily retrieve the closest distance between a point in 3D space and the plane's surface.
- If the plane-point distance is _greater than zero_, the point is in front of the plane.
- If the plane-point distance is _less than zero_, the point is behind the plane.
- If the plane-point distance is _zero_, the point lies exactly on the plane.

For example, if we want to determine if the camera is above or below water level, we can use a plane like so:

```
local p = Vec3(0, 3, 0)
local waterplane = Plane(0, 1, 0, -2)-- the plane is two meters above the origin, so the origin is behind it, and distance is negative
local d = waterplane:DistanceToPoint(p)

if d > 0 then
  Print("Above water")
else
  Print("Below water")
end
```

Here is an example showing how many objects can be tested to see if they are in front of or behind the plane:

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
camera:SetRotation(35,0,0)
camera:Move(0,0,-7)

--Create the ground
ground = CreateBox(world, 10, 1, 10)
ground:SetPosition(0, -0.5, 0)
ground:SetColor(0.5)

--Add some objects to the scene
balls = {}
for n = 1, 20 do
	ball = CreateSphere(world)
	ball:SetPosition(Random(-5,5), 0, Random(-5,5))
	table.insert(balls, ball)	
end

--Define the plane
a = 45
p = Plane(Sin(a), 0, Cos(a), 0)

--Create a visual mesh for the plane. This will create a rectangular mesh that is flat on the XZ axis
planemesh = CreatePlane(world, 15, 3)

--Create a transparent double-sided material for the mesh
mtl = CreateMaterial()
mtl:SetTransparent(true)
mtl:SetColor(1,1,1,0.5)
mtl:SetBackFaceCullMode(false)
planemesh:SetMaterial(mtl)

--Main loop
while not window:KeyDown(KEY_ESCAPE) and not window:Closed() do

	a = a + 0.25
	
	--Apply the rotation to the plane
	p.x = Sin(a)
	p.z = Cos(a)
    
	--ALign the Y axis of the plane mesh to the plane normal
	planemesh:SetRotation(0, a, 0)
	planemesh:Turn(90,0,0)
	planemesh:SetPosition(0,1,0)
	planemesh:Move(0,0,-p.d)
	
	for n = 1, #balls do		
		if p:DistanceToPoint(balls[n].position) > 0 then
			balls[n]:SetColor(0,1,0)
		else
			balls[n]:SetColor(1,0,0)			
		end		
	end
	
    --Update the world
    world:Update()
	
    --Render the world
    world:Render(framebuffer)
	
end
```
When you run the example, you may notice that objects are changing color while they are still intersecting the plane. This is because the object position is being tested, and radius of the sphere is not being considered. If you want to make a test that tells if any part of the sphere is in front of the plane, you can just add this code to modify the plane distance by the sphere radius, right before the main loop:

```lua
--Add the sphere radius to the plane distance to offset it
p.d = p.d + 0.5
```

## Plane-line Intersection

We can determine the intersection point between a plane and a 3D line in space with the [Plane:IntersectsLine](Plane_IntersectsLine.md) method. This will tell us if the line intersects the plane, and if so, what the exact intersection point is. Note that a line will not ever intersect a plane under a few conditions:
- If the line is parallel to the plane (runs alongside it), the line will never intersect the plane.
- If a line segment is being tested, instead of an infinite line, it may not intersect the plane.



## Convex Volumes

Things get interesting when we start using multiple planes. Before we get ahead of ourselves, lets define what convex and concave shapes are.

A convex shape doesn't have any parts of the shaoe that point inwards. A concave shape has part that point inwards, _like a cave_. As usual, it's easies to explain this with pictures:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/convexconcave.png?raw=true)

We can form convex shapes out of a series of planes, and the volume that lies behind each plane will form the shape. This is the basis of constructive solid geometry, which is useful as a level design tool.

Let's consider a field of objects divided by a plane. Objects behind the plane will be shown in green. Object in front of the plane will be shown in read. The plane divides the field in two:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/planedistance1.png?raw=true)

Something interesting happens if we take these objects and apply another plane, discarding the objects in front, and keeping the ones behind the second plane:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/planedistance2.png?raw=true)

If we add a third plane we can complete the shape. All objects that are behind each plane are within the shape, and everything else marked in red it outside the shape:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/planedistance3.png?raw=true)

This is exactly how the engine handles frustum culling, which determines whether each objects is visible within the camera's field of view.

You may notice that some of the circles intersect the planes. The plane-point distance does not account for a sphere's radius, but if we want to, we can simply subtract the sphere's radius from the plane distance component, and it will give us the right result:

```lua
--Sphere center
v = Vec3(0,1,0)

--Sphere radius
r = 3

--Plane points up, 2 meters below the origin
p = Plane(0,1,0,2)

--Plane-point distance
d = p:DistanceToPoint(v)
Print(d)

--Plane-sphere distance
p.d = p.d - r
d = p:DistanceToPoint(v)
Print(d)
```
