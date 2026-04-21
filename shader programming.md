# Shader Programming

Leadwerks provides a robust shader programming system and integrated development environment for authoring and debugging shaders. Shaders are written using the [GLSL](https://registry.khronos.org/OpenGL/specs/gl/GLSLangSpec.4.50.pdf) shader programming language.

## GBuffer Layout

| Index | Format | R | G | B | A |
|---|---|---|---|---|---|
| 0 | R11G11B10A | albedo.r | albedo.g | albedo.b | -- |
| 1 | R10G10B10A4 | normal.x | normal.y | normal.z | flags |
| 2 | RGBA8 | occlusion | roughness | metalness | emission |

## Transparency Buffer Layout

| Index | Format | R | G | B | A |
|---|---|---|---|---|---|
| 0 | R11G11B10A | albedo.r | albedo.g | albedo.b | -- |
| 1 | R10G10B10A4 | normal.x | normal.y | normal.z | flags |
| 2 | RGBA8 | occlusion | roughness | metalness | emission |
