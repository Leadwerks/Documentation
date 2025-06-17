# Entity Properties

The lower half of the [scene panel](scenepanel.md) displays properties for all selected objects.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/entityproperties.png?raw=true)

## General Properties

All entities display the object name and have the following properties in common.

### Transform Properties

**Position**: 3D position in space, in centimeters

**Rotation**: Euler rotation, in degrees

**Scale**: Entity scale

### Appearance Properties

**Color**: RGBA entity color

**Brightness**: A color intensity factor that can be used to increase brightness beyond the 255 limit the color properties uses.

**Emission**: Entity emission color. This will only be visible when a material with an emission texture is in use.

**Cast shadows**: If enabled, the entity will cast shadows.

**Static reflection**: If enabled, the entity will appear in reflection probe cubemaps when they are rendered.

**Hidden**: If enabled, the entity will be invisible and have no collision.

**Static**: If enabled, the entity will be made static when the scene is loaded in the game.

**Texture offset**: This provides a UV offset for scrolling the texture coordinates.

**Texture scale**: This provides a UV scale for resizing the texture coordinates.

**Tags**: Comma-separated list of tags that can be used together with the [World::GetTaggedEntities](World_GetTaggedEntities) command.

**Render layers**: Bitwise flag value indicating the entity render layers.

**Decal layers**: Bitwise flag value indicating the entity decal layers.

**View range**: The maximum distance the entity is visible from.

### Physics Properties

**Mass**: entity mass, in kilograms.

**Collision type**: entity collision type.

**Pick mode**: entity pick mode, can be mesh, collider, or none.

**Friction**: entity static and kinetic friction values.

**Damping**: entity linear and angular damping values.

**Elasticity**: entity "bounciness" value.

**Nav obstacle**: if set to true, the entity's collider will contribute to any navigation meshes that are built.

**Gravity**: if set to true the entity will be affected by gravity.

## Type-specific Properties

Some entities have special properties that only appear for that type of object.

### Camera Properties

**Range**: camera near and far range.

**Field of view**: camera FOV value, in degrees.

**Clear color**: camera background color used if no skybox is set.

### Light Properties

**Range**: near and far light range. The near range is used for the camera when a shadow map is rendered.

**Shadowmap size**: shadow map resolution the light uses, if it casts a shadow.

**Falloff mode**: Light falloff mode, can be linear or inverse square, for a more abrupt falloff.

**Cone angles**: for spotlights, this controls the cone angle at which the cone begins to fade in, and the cone angle at which it reaches maximum brightness.

### Navigation Mesh Properties

**Tiles**: number of navmesh tiles, in the X and Z directions.

**Tile resolution**: number of along each edge of a tile.

**Voxel size**: size of each voxel, in meters.

**Height**: maximum height of the navmesh.

**Max edge length**: Maximum edge length that is allowed to form, for navmesh polygons.

**Agent radius**: radius of the navigation agent the navmesh is meant to be used with.

**Agent height**: height of the navigation agent the navmesh is meant to be used with.

**Step height**: maximum steppable height, for stairs and other features.

**Max slope**: maximum slope the navigation agents can walk up, in degrees.

### Probe Properties

**Fade lower**: distance over which the edge of each axis in the negative direction fades in, in centimeters.

**Fade upper**: distance over which the edge of each axis in the positive direction fades in, in centimeters.

### Sprite Properties

**View mode**: sprite view mode, can be default or billboard.

**Size**: sprite size.
