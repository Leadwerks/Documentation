# World Settings

The world settings dialog controls visual settings of a scene. This dialog can be accessed by selecting the **Edit > World Settings** menu item.

## Environment Settings

The environment settings panel provides controls for scene lighting.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/worldsettings.png?raw=true)

**Sun color**: If the sun color is set to black (0,0,0) no directional light will be used in the scene. Otherwise, a single directional light will appear.

**Brightness**: This is a multiplier that allows you to set colors brighter than the 255 the sun color control uses.

**Azimuth**: The sun's rotation around the Y axis, or yaw.

**Elevation**: The sun's rotation around the X axis, or pitch.

**Shadow partition**: The distance each cascaded shadow map partition extends to. You can use this to fine-tune the appearance of the sun's shadows.

**Ambient light**: A solid light level that is applied to the scene uniformly. This is usually not needed.

**Skybox**: A cubemap containing a background for the scene.

**Specular reflection**: A corresponding cubemap containing the specular reflection for the scene.

**Diffuse reflection**: A corresponding cubemap containing the diffuse reflection for the scene.

**IBL Intensity**: A multipler that controls how bright the scene specular and diffuse reflections appear.

**GI Transmission**: This controls how strong diffuse light bounces during global illumination calculation. You can use this to get a brighter or darker scene.

## Fog Settings

The fog settings panel provides control over the scene fog levels.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/worldsettings2.png?raw=true)

## Post-processing Effects

The effect panel allows you to add post-processing effects to the scene, and to change the order the effects are applied in.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/worldsettings3.png?raw=true)
