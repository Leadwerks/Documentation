# Raycasting

Raycasting is an important technique in game development, used for detecting objects and interactions within a 3D environment. It allows developers to "cast" an invisible line, or ray, through the scene to determine what it intersects with.

Raycasting is widely used in game development for:

- **Object Interaction**: Checking what the player is looking at or pointing to, such as selecting objects or NPCs.
- **Shooting**: Detecting hits when firing projectiles or bullets.
- **Line-of-Sight Checks**: Verifying if an enemey can see the player.

## Commands

Leadwerks provides three methods for performing raycasts:

- **World:Pick**: Casts a ray between two specific points in the world space.
- **Camera:Pick**: Casts a ray from a screen coordinate into the 3D scene, useful for mouse picking or targeting.
- **Entity:GetVisible**: Casts a ray between two entities and returns true if nothing is hit.

The first two commands both return a [PickInfo](PickInfo.md) structure containing information about the intersection:

| Property | Type | Description |
| ----- | ----- | ----- |
| entity | [Entity](Entity.md) | picked entity |
| face | [Face](Face.md) | picked face, for brushes |
| mesh | [Mesh](Mesh.md) | picked mesh, for models |
| meshlayer | integer | index of picked mesh layer |
| meshlayerinstance | [iVec2](iVec2.md) | picked mesh layer instance coordinate |
| normal | [xVec3](xVec3.md) | picked normal |
| polygon | integer | picked polygon, for models |
| position | [xVec3](xVec3.md) | picked position |
| texcoords | [table](https://www.lua.org/manual/5.4/manual.html#6.6) | array of picked texture coordinates, for brushes or models |

## Sphere Casting (Radius Parameter)

Raycasts can include an optional radius parameter. When a non-zero radius is specified, the raycast becomes a **sphere cast**, which checks for intersections within a spherical volume. This is especially useful for detecting wider objects or simulating a more forgiving collision area.

## Closest Intersection

The World and Camera Pick methods can perform a line-of-sight test, which will return from the function as soon as the first object is intersected, or they can perform a more thorough test that finds the closest picked object. Both these methods accept an optional _closest_ parameter that uses a boolean to indicate whether the more thorough (and slower) test should be performed.

## Raycast Filter

If a filter callback is provided it will be called for each entity that is evaluated. If the callback returns true the entity will be tested, otherwise it will be skipped.

