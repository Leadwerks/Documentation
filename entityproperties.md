# Entity Properties

The lower half of the [scene panel](scenepanel.md) displays properties for all selected objects.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/entityproperties.png?raw=true)

All entities display the object name and have the following properties in common.

## Transform Properties

**Position**: 3D position in space, in centimeters

**Rotation**: Euler rotation, in degrees

**Scale**: Entity scale

## Appearance Properties

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

