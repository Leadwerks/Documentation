# Shader Programming

Leadwerks provides a robust shader programming system and integrated development environment for authoring and debugging shaders. Shaders are written using the [GLSL](https://registry.khronos.org/OpenGL/specs/gl/GLSLangSpec.4.50.pdf) shader programming language.

## GBuffer Layout

| Index | Format | R | G | B | A |
|---|---|---|---|---|---|
| 0 | R11G11B10F | albedo.r | albedo.g | albedo.b | -- |
| 1 | R10G10B10A2 | normal.x | normal.y | normal.z | flags |
| 2 | RGBA8 | occlusion | roughness | metalness | emission |

When the terrain-mesh blending feature is enabled, an additional color attachment will be present:

| Index | Format | R | G | B | A |
|---|---|---|---|---|---|
| 3 | RG8 | color blend | normal blend | -- | -- |

Albedo and emission are combined into a single color in the first color attachment. The emission term in color attachment 2 indicates what percentage of the color should be treat as albedo, with the rest treated as additive emission.

One of four possible decal layer values are store in the alpha channel of the first (0) color attachment. This controls which decals can appear on which objects.

The alpha channel of the second color attachment (1) can store two bitwise flags. Currently these are unused.

## Transparency Buffer Layout


| Index | Format | R | G | B | A |
|---|---|---|---|---|---|
| 0 | R11G11B10F | albedo.r | albedo.g | albedo.b | _alpha_* |
| 1 | R10G10B10A4 | normal.x | normal.y | normal.z | alpha |
| 2 | R32F | depth | -- | -- | -- |
| 3 | RG | IOR | roughness | -- | _alpha_* |
| 4 | Luminance | Reflectivity | -- | -- | _alpha_* |

If the material depth mask is enabled *and* screen-space reflections are enabled, then the following additional color attachments will also be written to.

| Index | Format | R | G | B | A |
|---|---|---|---|---|---|
| 5 | R10G10B10A4 | normal.x | normal.y | normal.z |  _alpha_* |
| 6 | RGBA8 | occlusion | roughness | metalness |  _alpha_* |
| 7 | R10G10B10A4 | albedo.r * 0.25 | albedo.g * 0.25 | albedo.b * 0.25 |  _alpha_* |

Textures 5 and 6 are the color attachments 1 and 2 from the main GBuffer. These will only be written to when screen-space reflection is enabled.

Although color attachments 0 and 3 do not store an alpha component, the alpha value should still be written by the shader for blending to work correctly.

In addition to the color buffers, a depth/stencil texture using format DEPTH24_STENCIL8 is also attached.

The stencil buffer is used for some optimization, and also controls which decals appear on which surfaces, as set with the [Entity::SetDecalLayers](Entity_SetDecalLayers.md) command.

| Bit | Description |
|---|---|
| 0 | This is always set for any pixel that is drawn, and distinguishes between a pixel that requires lighting and the empty background |
| 1 | Reserved |
| 2 | Reserved |
| 3 | Reserved |
| 4 | Indicates that decal layer 0 is active at this pixel |
| 5 | Indicates that decal layer 1 is active at this pixel |
| 6 | Indicates that decal layer 2 is active at this pixel |
| 7 | Indicates that decal layer 3 is active at this pixel |

## Vertex Inputs

The following inputs are available for all vertex shaders. You shader should include the file "Shaders/Common/VertexLayout.glsl" to access these.

The vertex data structure packs a lot of data into just 36 bytes.

| | |
|---|---|
| vec3 | VertexPosition |
| vec2 | VertexTexCoords |
| vec2 | VertexLightmapCoords |
| vec3 | VertexTangent |
| vec3 | VertexBitangent |
| vec3 | VertexNormal |
| float | VertexDisplacement |
| uvec4 | VertexBoneIndices |
| vec4 | VertexBoneWeights |
| vec4 | VertexMaterialWeights |
| vec4 | VertexColors |

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

