# Raycasting

Raycasting is one of the most important tools in your toolbox as a game developer. Leadwerks has two types of raycasts. A raycast can be performed between two points in space using the World:Pick command, or a raycast can be performed from a screen coordinate using the Camera:Pick command. The raycast commands return a structure with this info:
- entity: entity that was picked. If this value is nil then the raycast did not hit anything
- position: the position the raycast intersected the entity at
- normal: the normal of the object at the intersection point
- mesh: for model and brush entities, this is the picked mesh
- meshlayer: for vegetation mesh layers, this is the picked layer index
- polygon: the index of the picked primitive in the mesh
- face: for brushes, the picked face.
- texcoords: for meshes, the texture coordinates at the picked position

Raycasts can have an optional radius value. If a non-zero radius is specified, then the raycast will be a sphere cast.

What can a raycast be used for?
- Check in front of the player to see what object they are looking at.
- shoot a bullet

