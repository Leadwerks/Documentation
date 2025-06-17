# Entity Properties

The lower half of the [scene panel](scenepanel.md) displays properties for all selected objects.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/entityproperties.png?raw=true)

Certainly! Here's the formatted list of properties, all structured in markdown tables similar to the transform properties at the beginning:

## Transform Properties

| Property | Description |
|------------|--------------|
| Position | 3D position in space, in centimeters |
| Rotation | Euler rotation, in degrees |
| Scale | Entity scale |

### Appearance Properties

| Property | Description |
|------------|--------------|
| Color | RGBA entity color |
| Brightness | A color intensity factor that can be used to increase brightness beyond the 255 limit the color properties use |
| Emission | Entity emission color. Visible when using a material with an emission texture |
| Cast shadows | If enabled, the entity will cast shadows |
| Static reflection | If enabled, the entity appears in reflection probe cubemaps when rendered |
| Hidden | If enabled, the entity is invisible and has no collision |
| Static | If enabled, the entity will be made static when the scene loads |
| Texture offset | UV offset for scrolling the texture coordinates |
| Texture scale | UV scale for resizing the texture coordinates |
| Tags | Comma-separated list of tags for use with World::GetTaggedEntities |
| Render layers | Bitwise flag indicating the entity's render layers |
| Decal layers | Bitwise flag indicating the entity's decal layers |
| View range | Max distance the entity is visible from |

### Physics Properties

| Property | Description |
|------------|--------------|
| Mass | Entity mass in kilograms |
| Collision type | Entity collision type |
| Pick mode | Mesh, collider, or none |
| Friction | Static and kinetic friction values |
| Damping | Linear and angular damping values |
| Elasticity | Bounciness value |
| Nav obstacle | If true, collider contributes to navigation meshes |
| Gravity | If true, affected by gravity |

## Type-specific Properties

### Camera Properties

| Property | Description |
|------------|--------------|
| Range | Near and far range of the camera |
| Field of view | Camera FOV in degrees |
| Clear color | Background color if no skybox is set |

### Light Properties

| Property | Description |
|------------|--------------|
| Range | Near and far light range; near used for shadow map rendering |
| Shadowmap size | Resolution of the shadow map if casting shadows |
| Falloff mode | Linear or inverse square falloff |
| Cone angles | For spotlights: fade-in cone angle and maximum brightness cone angle |

### Navigation Mesh Properties

| Property | Description |
|------------|--------------|
| Tiles | Number of navmesh tiles in X and Z |
| Tile resolution | Number of units along each tile edge |
| Voxel size | Size of each voxel in meters |
| Height | Max height of the navmesh |
| Max edge length | Max allowed edge length for navmesh polygons |
| Agent radius | Navigation agent radius |
| Agent height | Navigation agent height |
| Step height | Max height for stairs and steps |
| Max slope | Max slope in degrees that agents can walk up |

### Particle Properties

| Property | Description |
|------------|--------------|
| Particle count | Number of particles |
| Emission shape | Shape of particle emission: ellipsoid or box |
| Emission area | Dimensions of emission shape |
| Burst frequency | How often particles are emitted |
| Burst quantity | Particles per burst |
| Start color | Initial particle color |
| End color | Final particle color |
| Velocity | Particle velocity |
| Acceleration | Particle acceleration |
| Size | Particle size (X and Y) |
| Radius | Start and end radius of particles |
| Turbulence | Change in velocity each step |
| Rotation speed | Speed of particle rotation |
| Alignment | Billboard or velocity alignment |

### Probe Properties

| Property | Description |
|------------|--------------|
| Fade lower | Fading distance in negative axis, in centimeters |
| Fade upper | Fading distance in positive axis, in centimeters |

### Sprite Properties

| Property | Description |
|------------|--------------|
| View mode | Default or billboard |
| Size | Sprite size |
