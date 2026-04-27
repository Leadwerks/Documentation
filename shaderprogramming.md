# Shader Programming

Leadwerks provides a robust shader programming system and integrated development environment for authoring and debugging shaders. Shaders are written using the [GLSL](https://registry.khronos.org/OpenGL/specs/gl/GLSLangSpec.4.50.pdf) shader programming language.

## GBuffer Layout

| Index | Format | R | G | B | A |
|---|---|---|---|---|---|
| 0 | R11G11B10F | albedo.r | albedo.g | albedo.b | -- |
| 1 | R10G10B10A2 | normal.x | normal.y | normal.z | flags |
| 2 | RGBA | occlusion | roughness | metalness | emission |

When the terrain-mesh blending feature is enabled, an additional color attachment will be present:

| Index | Format | R | G | B | A |
|---|---|---|---|---|---|
| 3 | RG | color blend | normal blend | -- | -- |

Albedo and emission are combined into a single color in the first color attachment. The emission term in color attachment 2 indicates what percentage of the color should be treat as albedo, with the rest treated as additive emission.

One of four possible decal layer values are store in the alpha channel of the first (0) color attachment. This controls which decals can appear on which objects.

The alpha channel of the second color attachment (1) can store two bitwise flags defined in "Common/Constants.glsl", and can be any combination of the following flags:

| Flag | Description |
|---|---|
| PIXELFLAGS_BACKFACING | indicates that the pixel faces away from the camera, for two-sided materials |
| PIXELFLAGS_IGNORENORMALS | indicates that normals should be ignored in the lighting calculation |

## Transparency Buffer Layout


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

If screen-space reflections are enabled *and* the material depth mask is enabled, then the following additional color attachments will also be written to.

| Index | Format | R | G | B | A |
|---|---|---|---|---|---|
| 5 | R10G10B10A4 | normal.x | normal.y | normal.z |  _alpha_* |
| 6 | RGBA | occlusion | roughness | metalness |  _alpha_* |
| 7 | R11G11B10F | albedo.r | albedo.g | albedo.b |  _alpha_* |

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

