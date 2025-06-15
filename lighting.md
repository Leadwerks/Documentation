# Lighting

There are two types of lighting in Leadwerks. Direct lighting is fully dynamic, using shadow maps to display moving shadows that change as objects move. Indirect lighting simulates bounce lighting around the scene, and is static, which provides the best performance possible.

## Direct Lighting

Direct lighting in Leadwerks 5 includes several types of light sources that can be placed within the scene to illuminate objects dynamically. These lights interact with objects in real-time, casting shadows that adapt as the scene changes.

### Point Lights

Point lights emit light equally in all directions from a single point in space, similar to a bare light bulb or a torch. They store their shadow data in a cube shadow map, requiring six passes to be rendered any time the shadow is updated.

### Spot Lights

Spot lights simulation a flashlight or streetlight, with defined cone angles at which the light starts to fade out, and when the light cone terminates completely. Spot lights are relatively cheaper to render than points lights because they only require the surrounding area to be drawn in a single pass.

### Box Lights

Box lights are good for simulating a directional light in an enclosed area, like light streaming in a window. Box lights are relatively cheaper to render than points lights because they only require the surrounding area to be drawn in a single pass.

### Directional Lights

A directional lights simulates the sun or the moon. Cascaded shadow maps are used to draw the directional light shadow in several partitions distributed around the viewer.

Each scene in the editor can display a single directional light. The properties of the light can be controlled in the [world settings](worldsettings.md) interface.

## Indirect Lighting

Indirect lighting is achieved through the use of volumeitric environment probes. Each environment probe renders two cubemaps, for specular and diffuse reflections, and distributes the reflection over a box area.
