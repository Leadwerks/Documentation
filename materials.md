# Physically-based Materials

Ultra Engine employs physically-based rendering (PBR) to achieve next-generation visual quality with realistic lighting. PBR combines various material and environmental settings to create realistic surface appearances.

## Embedded Model Materials

Model materials in Ultra Engine are embedded in the model file, and can be modified in the [asset window](asseteditor.md). Standalone material files are only needed for brushes, terrain, and sprites.

## Creating Materials

PBR materials are a complex blend of data layers compacted into different color channels and stored in various pixel formats. The easiest way to create PBR materials is by leveraging the editor's ability to automatically generate materials from textures.

To get started, you can obtain free PBR images from websites like [ambientCG](https://www.ambientcg.com) and [Polyhaven](https://www.polyhaven.com). In this example, we will use a texture set featuring a rusted metallic surface.

1. [Download the texture pack](https://github.com/UltraEngine/Documentation/raw/master/Assets/Materials/pbrtextures.zip) and extract its contents into your Ultra Engine project. The extracted images will look like this:

   ![Texture Pack](https://github.com/UltraEngine/Documentation/blob/master/Images/pbrtextures.png?raw=true)

2. In the Ultra Engine editor, navigate to this folder in the [asset browser](assetbrowser.md). Right-click on the file *MetalPlates013_1K-PNG_Color.png*, select the *Generate Material* menu item, and wait for the editor to identify the different image files, combine channels, and compress the images into optimized texture files.

   ![Material Generation](https://github.com/UltraEngine/Documentation/blob/master/Images/pbrgenmaterial.png?raw=true)

3. Open the resulting material file to observe how the textures have been combined, creating a surface with appealing variations in reflectivity and appearance. You can now delete the original PNG files if you wish, since they are no longer needed.

   ![Generated Material](https://github.com/UltraEngine/Documentation/blob/master/Images/pbrgenmaterial2.png?raw=true)

The material generation algorithm performs the following steps:

- The base/diffuse map is converted into an optimized BC7 format and saved as a DDS file.
- The normal map is converted into an optimized BC5 format and saved as a DDS file. BC5 removes the Z-axis from the normal to make room for more data on the other two components, with the Z-axis reconstructed in the fragment shader. BC5 is the only compressed texture format suitable for normal maps.
- If available, the metalness and roughness maps are combined into the green and blue channels of a single texture and saved in BC7 format. If a metalness map is found, the material's metalness setting is set to 1.0.
- If an ambient occlusion map is present and a metalness roughness map exists, the ambient occlusion data is packed into the red channel of the metalness/roughness map. Otherwise, the ambient occlusion map will be saved as a single texture in BC4 format for compressing single-channel images.
- If a displacement map is found, it will be saved in an uncompressed single-channel image. Texture compression should not be used with displacement maps.

The table below shows the optimal layout for material texture data:

| Index | Name | Format | R | G | B | A |
|---|---|---|---|---|---|---|
| 0 | base | BC7 | base red | base green | base blue | base alpha |
| 1 | normal | BC5 | nx | ny | -- | -- |
| 2, 5 | occlusion / roughness / metallic | BC7 | ambient occlusion | roughness | metalness | -- |
| 3 | displacement | R8 | height | -- | -- | -- |
| 4 | emission | BC7 | emission red | emission green | emission blue | -- |
| 5 | occlusion (alone) | BC4 | ambient occlusion | -- | -- | -- |

While manually adjusting these settings would be very time-consuming, the built-in material generation tool can create optimized materials from raw images in seconds. You can modify the suffixes used by the material generation feature in the program options, specifically in the *Material Generation* settings.

   ![Material Generation Settings](https://github.com/UltraEngine/Documentation/blob/master/Images/genmatsettings.png?raw=true)

## Material Settings

The most crucial settings for PBR materials are *roughness* and *metalness*.

### Roughness

The *roughness* setting indicates the microsurface roughness of a material. When a metal/roughness map is present, the roughness setting acts as a multiplier, usually set to 1.0 (100%). If there's no metallic roughness map, this setting alone controls the surface's roughness.

### Metalness

The *metalness* setting reflects the metallic properties of a material. Like roughness, when a metal/roughness map is present, the metalness setting acts as a multiplier, typically set to 1.0 (100%). If there's no metallic roughness map, this setting alone determines the material's metallic appearance.

It's important to note that the more metallic a surface is, the more it relies on the surrounding environment for reflections. A completely metallic material without environment maps will appear black.

In practice, most basic materials without metal/roughness maps will use 100% roughness and 0% metalness.

## PBR Lighting

Ultra Engine achieves direct lighting through point, spot, directional, and box lights, each utilizing a different lighting equation to simulate light sources with texture-based shadows (shadow maps). Highly metallic objects are less affected by direct lighting because of their high reflectivity, primarily reflecting the environment.

Indirect lighting is accomplished with a combination of world environment textures and local environment probes. Since PBR materials accurately reflect their surroundings, having high-quality reflection data is essential.

Reflections play a significant role in physically-based materials. Without diffuse and specular environment maps set for the world, materials may appear dark.

   ![No Reflection](https://github.com/UltraEngine/Documentation/blob/master/Images/pbrnone.jpg?raw=true)

When you add diffuse and specular reflection maps to the world, the scene becomes more vibrant but the lighting lacks depth because only the sky color is reflected.

   ![Reflection Added](https://github.com/UltraEngine/Documentation/blob/master/Images/pbrsky.jpg?raw=true)

To achieve the best results, combine diffuse and specular reflection maps for the world with environment probes for indoor spaces.

   ![Best Results](https://github.com/UltraEngine/Documentation/blob/master/Images/pbrprobe.jpg?raw=true)

Optimal reflection data results in stunning and realistic visuals for your games.
