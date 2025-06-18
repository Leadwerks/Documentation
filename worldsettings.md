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

**Color**: Fog color.

**Density**: Maximum fog alpha blend value.

**Start range**: Distance at which the fog first appears.

**End range**: Distance at which the fog reaches its maximum density.

**Start angle**: Angle in the sky at which the fog begins to fade.

**End angle**: Angle in the sky at which the fog disappears.

## Post-processing Effects

The effect panel allows you to add post-processing effects to the scene, and to change the order the effects are applied in.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/worldsettings3.png?raw=true)

The following post-processing effects are provided:

  - Autoexposure – Adjusts scene brightness dynamically for consistent lighting.
  - Bloom – Creates a glow around bright areas for a luminous effect.
  - Depth of Field (DOF) – Blurs objects based on distance to focus attention.
  - Gaussian Blur – Softens the entire image or regions smoothly.
  - Godrays – Light beams radiate through obstacles, adding drama.
  - Grayscale – Converts the scene to black-and-white.
  - SSAO – Adds subtle shadows in corners and contact points for depth.
  - Tonemapping – Balances HDR colors for natural or cinematic look.
  - Volumetric Lighting – Simulates light scattering through particles like fog.
