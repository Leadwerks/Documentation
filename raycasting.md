# Raycasting

Raycasting is a fundamental technique in game development, used for detecting objects and interactions within a 3D environment. It allows developers to "cast" an invisible line, or ray, through the scene to determine what it intersects with, enabling features like aiming, object selection, and collision detection.

Leadwerks provides three methods for performing raycasts:

- **World:Pick**: Casts a ray between two specific points in the world space.
- **Camera:Pick**: Casts a ray from a screen coordinate into the 3D scene, useful for mouse picking or targeting.
- **Entity:GetVisible**: Casts a ray between two entities and returns true if nothing is hit.

The first two commands both return a [PickInfo](PickInfo.md) structure containing information about the intersection:

- **entity**: The object hit by the ray. If `nil`, the ray did not hit anything.
- **position**: The exact point in space where the ray intersects the entity.
- **normal**: The surface normal at the intersection point, useful for determining how to respond to the hit.
- **mesh**: For model or brush entities, the specific mesh that was intersected.
- **meshlayer**: For vegetation or layered meshes, the index of the layer hit.
- **polygon**: The index of the primitive (triangle or face) within the mesh that the ray hit.
- **face**: For brush entities, the specific face that was intersected.
- **texcoords**: Texture coordinates at the intersection point, useful for texture-based effects.

### Sphere Casting (Radius Parameter)

Raycasts can include an optional radius parameter. When a non-zero radius is specified, the raycast becomes a **sphere cast**, which checks for intersections within a spherical volume. This is especially useful for detecting wider objects or simulating a more forgiving collision area.

### Common Uses of Raycasting

Raycasting is versatile and widely used in game development for:

- **Object Interaction**: Checking what the player is looking at or pointing to, such as selecting objects or NPCs.
- **Aiming & Shooting**: Detecting hits when firing projectiles or bullets.
- **Collision Detection**: Ensuring characters and objects don't pass through each other.
- **Environmental Queries**: Determining surfaces for placement or physics interactions.
- **Line-of-Sight Checks**: Verifying if an NPC can see the player.

By leveraging raycasting, developers can create interactive and immersive gameplay experiences with precise control over object detection and interaction.

---

Would you like me to add any specific examples or diagrams to illustrate these concepts?
