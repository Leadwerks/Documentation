# Shader Programming

Leadwerks provides a robust shader programming system and integrated development environment for authoring and debugging shaders. Shaders are written using the [GLSL](https://registry.khronos.org/OpenGL/specs/gl/GLSLangSpec.4.50.pdf) shader programming language.

## GBuffer Layout

| Index | Format | R | G | B | A |
|---|---|---|---|---|---|
| 0 | R11G11B10F | albedo.r | albedo.g | albedo.b | -- |
| 1 | R10G10B10A2 | normal.x | normal.y | normal.z | flags |
| 2 | RGB | emission | roughness | metalness | -- |
| 3 | RG | color blend | normal blend | -- | -- |

Albedo and emission are combined into a single color in the first color attachment. The emission term in color attachment 2 indicates what percentage of the color should be treat as albedo, with the rest treated as additive emission. This allows the renderer to pack more data into a smaller memory size.

One of four possible decal layer values are store in the alpha channel of the first (0) color attachment. This controls which decals can appear on which objects.

The alpha channel of the second color attachment (1) can store two bitwise flags defined in "Common/Constants.glsl", and can be any combination of the following flags:

| Flag | Description |
|---|---|
| PIXELFLAGS_BACKFACING | indicates that the pixel faces away from the camera, for two-sided materials |
| PIXELFLAGS_IGNORENORMALS | indicates that normals should be ignored in the lighting calculation |

### Depth / Stencil Attachment

In addition to the color buffers, a depth/stencil texture using format DEPTH24_STENCIL8 is also attached.

The stencil buffer is used for some optimization, and also controls which decals appear on which surfaces, as set with the [Entity::SetDecalLayers](Entity_SetDecalLayers.md) command.

| Bit | Description |
|---|---|
| 0 | This is always set for any pixel that is drawn, and distinguishes between a pixel that requires lighting and the empty background |
| 1 | Indicates the terrain blend feature is in use at this pixel |
| 2 | Unused |
| 3 | Unused |
| 4 | Indicates that decal layer 0 is active at this pixel |
| 5 | Indicates that decal layer 1 is active at this pixel |
| 6 | Indicates that decal layer 2 is active at this pixel |
| 7 | Indicates that decal layer 3 is active at this pixel |

## Transparency Buffer Layout

The transparency buffer uses a similar but larger buffer. Some textures from the gbuffer may also be attached and written to, depending on the current settings.

| Index | Format | R | G | B | A |
|---|---|---|---|---|---|
| 0 | RGBA16F | albedo.r | albedo.g | albedo.b | alpha |
| 1 | R10G10B10A4 | normal.x | normal.y | normal.z | alpha |
| 2 | R32F | Z-position | -- | -- | -- |
| 3 | RG | IOR | roughness | -- | _alpha_* |

If screen-space reflections are enabled, an additional color attachment will be written to.

| Index | Format | R | G | B | A |
|---|---|---|---|---|---|
| 4 | Luminance | Reflectivity | -- | -- | _alpha_* |

If screen-space reflections are enabled *and* the material depth mask is enabled, then the following additional color attachments will also be written to. These are the same textures used in the GBuffer, and their values will be overwritten before screen-space reflections are rendered.

| Index | Format | R | G | B | A |
|---|---|---|---|---|---|
| 5 | R10G10B10A4 | normal.x | normal.y | normal.z |  _alpha_* |
| 6 | RGBA | -- | roughness | -- |  _alpha_* |
| 7 | R11G11B10F | albedo.r | albedo.g | albedo.b |  _alpha_* |

*Although some color attachments do not store an alpha component, the alpha value should still be written by the shader for blending to work correctly.

## Vertex Inputs

The following inputs are available for all vertex shaders. You shader should include the file "Shaders/Common/VertexLayout.glsl" to access these.

The vertex data structure packs a lot of data into just 36 bytes. Some data is adjusted based on current settings. For example, meshes that use vertex skinning will have vertex colors removed to save space. However, you can always rely on these inputs providing appropriate values when authoring shaders.

| Name | Type | Description |
|---|---|---|
| vec3 | VertexPosition | Position in local space, with three 32-bit floats |
| vec2 | VertexTexCoords | Vertex texture coordinate stored in two 32-bit floats |
| vec2 | VertexLightmapCoords | Vertex lightmap coordinates, normalized short values |
| vec3 | VertexNormal | Vertex normal extracted from QTangent quaternion |
| vec3 | VertexTangent | Vertex tangent extracted from QTangent quaternion |
| vec3 | VertexBitangent | Vertex bitangent extracted from QTangent quaternion |
| vec4 | VertexColors | Vertex colors, stored as normalized bytes |
| uvec4 | VertexBoneIndices | Vertex bone indices, stored as unsigned bytes |
| vec4 | VertexBoneWeights | Vertex bone weights, stored as normalized bytes |
| float | VertexDisplacement | Vertex dispacement value, stored in a 16-bit float |
| vec2 | VertexMaterialWeights | Vertex material weights for multi-material surfaces, stored as normalized bytes |

The actual vertex data structure passed to the shader is extremely compact:

| Name | Type | Elements | Description |
|---|---|---|---|
| position | float | 3 | vertex position in local space |
| texcoords | float | 2 | vertex texture coordinates |
| lightmapcoords | unsigned short | 2 | vertex texture coordinates for lightmaps or other uses |
| qtangent | signed char | 4 | encoded normal, tangent, and bitangent values |
| boneindices | unsigned char | 4 | bone indices for mesh skinning, or vertex displacement |
| boneweights | unsigned char | 4 | values can be used for bone weights, vertex colors, or material weights |

## Vertex Outputs

The following values are output from the vertex shader, and are available across all shader stages.

| Name | Type | Interpolation | Description |
|---|---|---|---|
| EntityIndex | uint | flat | Entity index |
| EntityFlags | uint | flat |  Entity flags |
| Position |vec3 | smooth | Position in global space |
| TexCoords | vec4 | smooth | Texture and lightmap coordinates |
| TBN | mat3 | smooth | Tangent, bitangent, normal matrix |
| Displacement | float | smooth | Dispacement value |
| Color | vec4 | smooth | Entity color |
| EmissionColor | vec3 | smooth | Entity emission color |
| MaterialWeights | vec2 | smooth | Material weights for multi-material surfaces |

## Built-in Uniforms

The following uniform values are available in all shaders that declare them, or include the file "Common/Uniforms.glsl".

| Name | Type | Description |
|---|---|---|
| IBLIntensoty | float | Intensity of the specular and diffuse environment maps |
| CameraPosition | vec3 | Global position of the current camera |
| CurrentTime | uint | Current time in milliseconds |
| CameraMatrix | mat4 | 4x4 matrix of the current camera |
| CameraNormalMatrix | mat3 | 3x3 matrix of the current camera |
| AmbientLight | vec3 | world ambient lighting level |

## Shader Programming Tips

### Varying and Uniform Locations

**Never** explicitly number varyings or uniforms:
```glsl
in layout(location = 0) vec4 Position;
in layout(location = 1) vec4 TexCoords;
```
Any mismatches between your numbering in shader stages can cause shaders to silently fail. Instead, let the shader compiler match the varyings by name:
```glsl
in vec4 Position;
in vec4 TexCoords;
```

### Fragment Shader Output Locations

**Always** explicitly number fragment shader outputs. Some graphics hardware won't write the the right color attachment without this:
```glsl
out layout(location = 0) vec4 fragColor;
out layout(location = 1) vec4 fragNormal;
out layout(location = 2) vec4 fragData;
```

### Data Arrays

**Don't** declare data in large arrays in your code:
```glsl
int pattern[64] = {
    0, 32,  8, 40,  2, 34, 10, 42, 
    48, 16, 56, 24, 50, 18, 58, 26, 
    12, 44,  4, 36, 14, 46,  6, 38,  
    60, 28, 52, 20, 62, 30, 54, 22, 
    3, 35, 11, 43,  1, 33,  9, 41,  
    51, 19, 59, 27, 49, 17, 57, 25,
    15, 47,  7, 39, 13, 45,  5, 37,
    63, 31, 55, 23, 61, 29, 53, 21 };
```
This can cause some integrated graphics to run very slowly. Instead, use a texture to pass data to the shader.
