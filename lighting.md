# Lighting

There are two types of lighting in Leadwerks. Direct lighting is fully dynamic, using shadow maps to display moving shadows that change as objects move. Indirect lighting simulates bounce lighting around the scene, and is static, which provides the best performance possible.

## Direct Lighting

Direct lighting in Leadwerks 5 includes several types of light sources that can be placed within the scene to illuminate objects dynamically. These lights interact with objects in real-time, casting shadows that adapt as the scene changes.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/sunlight.jpg?raw=true)

### Point Lights

Point lights emit light equally in all directions from a single point in space, similar to a bare light bulb or a torch. They store their shadow data in a cube shadow map, requiring six passes to be rendered any time the shadow is updated.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/pointlight.jpg?raw=true)

### Spot Lights

Spot lights simulation a flashlight or streetlight, with defined cone angles at which the light starts to fade out, and when the light cone terminates completely. Spot lights are relatively cheaper to render than points lights because they only require the surrounding area to be drawn in a single pass.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/spotlight.jpg?raw=true)

### Box Lights

Box lights are good for simulating a directional light in an enclosed area, like light streaming in a window. Box lights are relatively cheaper to render than points lights because they only require the surrounding area to be drawn in a single pass.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/boxlight.jpg?raw=true)

### Directional Lights

A directional lights simulates the sun or the moon. Cascaded shadow maps are used to draw the directional light shadow in several partitions distributed around the viewer.

Each scene in the editor can display a single directional light. The properties of the light can be controlled in the [world settings](worldsettings.md) interface.

## Indirect Lighting

Indirect lighting is achieved through the use of volumeitric environment probes. Each environment probe renders two cubemaps, for specular and diffuse reflections, and distributes the reflection over a box area.

To update indirect lighting, select the **Tools > Build Global Illumination** menu item.

In the scene below, the reflected indirect lighting is visible inside the structure, which looks unnaturally bright.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/probe1.jpg?raw=true)

We can improve the appearance by adding an environment probe in the enclosed area, with the edges aligned to the interior walls. All pixels inside the probe's volume will use the environment probe cubemap for indirect lighting.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/probe2.jpg?raw=true)

This looks better, but there is a sharp line on the floor where the environment probe volume begins. We can soften this boundary by adjusting the padding values in the probe settings, available in the [scene panel](mapbriwser.md),

![](https://github.com/UltraEngine/Documentation/blob/master/Images/probe4.jpg?raw=true)

You can adjust the padding on each edge of the probe volume individually, for fine control over the probe's appearance. Use this to transition more smoothly between indoor and outdoor areas, or to blend the border region between two probe volumes.

The brightness of indirect lighting can be further adjusted with the **GI Transmission** setting found in the [world settings](worldsettings.md) dialog.
