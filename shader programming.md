# Shader Programming

Leadwerks provides a robust shader programming system and integrated development environment for authoring and debugging shaders. Shaders are written using the [GLSL](https://registry.khronos.org/OpenGL/specs/gl/GLSLangSpec.4.50.pdf) shader programming language.

## GBuffer Layout

| Index | Format | R | G | B | A |
|---|---|---|---|---|---|
| 0 | R11G11B10 | albedo.r | albedo.g | albedo.b | -- |
| 1 | R10G10B10A4 | normal.x | normal.y | normal.z | flags |
| 2 | RGBA8 | occlusion | roughness | metalness | emission |
| 3 | RG8 | color blend | normal blend | -- | -- |

Albedo and emission are combined into a single color in the first color attachment. The emission term in color attachment 2 indicates what percentage of the color should be treat as albedo, with the rest treated as additive emission.

## Transparency Buffer Layout


| Index | Format | R | G | B | A |
|---|---|---|---|---|---|
| 0 | R11G11B10 | albedo.r | albedo.g | albedo.b | _alpha_* |
| 1 | R10G10B10A4 | normal.x | normal.y | normal.z | alpha |
| 2 | R32F | depth | -- | -- | -- |
| 3 | RGB8 | IOR | roughness | optical density | _alpha_* |
| 4 | R8 | flags | -- | -- | -- |
| 5 | R10G10B10A4 | normal.x | normal.y | normal.z | flags |
| 6 | RGBA8 | occlusion | roughness | metalness | emission |

Textures 5 and 6 are the color attachments 1 and 2 from the main GBuffer. These will only be written to when screen-space reflection is enabled.

Although color attachments 0 and 3 do not store an alpha component, the alpha value should still be written by the shader for blending to work correctly.

## Vertex Inputs

The following inputs are available for all vertex shaders. You shader should include the file "Shaders/Common/VertexLayout.glsl" to access these.

The vertex data structure packs a lot of data into just 36 bytes.

| | |
|---|---|
| vec3 | VertexPosition |
| vec2 | VertexTexCoords |
| vec2 | VertexLightmapCoords |
| vec3 | VertexTangent |
| vec3 | VertexNormal |
| vec3 | VertexBitangent |
| float | VertexDisplacement |
| uvec4 | VertexBoneIndices |
| vec4 | VertexBoneWeights |
| vec4 | VertexMaterialWeights |
| vec4 | VertexColors |
