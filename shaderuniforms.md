# Shader Uniforms

## Camera Settings

| Name                          | Type                         | Description                                     |
|----------------------------------------|------------------------------|------------------------------------------------|
| uniform mat4 CameraMatrix              | mat4                         | Camera transformation matrix                   |
| uniform mat3 CameraNormalMatrix        | mat3                         | Normal matrix for camera transformations       |
| uniform mat4 CameraProjectionMatrix    | mat4                         | Camera projection matrix                       |
| uniform mat4 InverseCameraMatrix       | mat4                         | Inverse of the camera matrix                     |
| uniform mat3 InverseCameraNormalMatrix  | mat3                         | Inverse normal matrix for camera transformations |
| uniform mat4 InverseCameraProjectionMatrix | mat4                      | Inverse of the camera projection matrix        |
| uniform vec3 CameraPosition            | vec3                         | Position of the camera                         |
| uniform vec2 CameraRange               | vec2                         | Camera near and far range                      |
| uniform float CameraZoom               | float                        | Camera zoom level                              |
| uniform int CameraProjectionMode       | int                          | Camera projection mode                         |

## Render Settings

| Name                          | Type                         | Description                                     |
|----------------------------------------|------------------------------|------------------------------------------------|
| uniform uvec4 MaterialIndex            | uvec4                        | Material index                                 |
| uniform uint TextureFlags              | uint                         | Texture flags                                  |
| uniform float TextureLodBias           | float                        | Texture Level of Detail bias                    |
| uniform float BaseTextureLodBias       | float                        | Base texture LOD bias                           |
| uniform vec4 SelectionColor            | vec4                         | Selection color                                |
| uniform float DisplayScale             | float                        | Display scale                                  |
| uniform vec3 AmbientLight              | vec3                         | Ambient light color                            |
| uniform float IBLIntensity             | float                        | Image-based lighting intensity                 |
| uniform vec3 SkyColor                   | vec3                         | Sky color                                      |
| uniform vec4 BackgroundColor             | vec4                         | Background color                               |
| uniform float MeshDisplacementScale    | float                        | Mesh displacement scale                        |
| uniform uint BlendMode                 | uint                         | Blend mode                                     |
| uniform uint RenderFlags               | uint                         | Render flags                                   |
| uniform float RenderTween              | float                        | Render tween (animation factor)                |
| uniform ivec4 DrawViewport              | ivec4                        | Draw viewport (x, y, width, height)            |
| vec2 BufferSize                        | vec2                         | Buffer size (derived from DrawViewport)        |
| uniform int ToneMappingMode              | int                          | Tone mapping mode                              |
| uniform float CameraTessellation        | float                        | Camera tessellation factor                     |
| uniform int RenderMode                   | int                          | Render mode                                    |

## Fog Settings

| Name                          | Type                         | Description                                     |
|----------------------------------------|------------------------------|------------------------------------------------|
| uniform vec4 FogColor                   | vec4                         | Fog color                                      |
| uniform vec2 FogRange                   | vec2                         | Fog range (near and far)                       |
| uniform vec2 FogAngles                  | vec2                         | Fog angles (directional)                       |
| uniform float FogDensity                 | float                        | Fog density                                    |

## Miscellaneous

| Name                          | Type                         | Description                                     |
|----------------------------------------|------------------------------|------------------------------------------------|
| uniform uint CurrentTime               | uint                         | Current time in milliseconds                     |
| uniform int PassIndex                    | int                          | Current rendering pass index, for point lights and VR                    |
