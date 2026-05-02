# Shader Uniforms

## Camera Settings

| Name                          | Type                         | Description                                     |
|----------------------------------------|------------------------------|------------------------------------------------|
| CameraMatrix              | mat4                         | Camera transformation matrix                   |
| CameraNormalMatrix        | mat3                         | Normal matrix for camera transformations       |
| CameraProjectionMatrix    | mat4                         | Camera projection matrix                       |
| InverseCameraMatrix       | mat4                         | Inverse of the camera matrix                     |
| InverseCameraNormalMatrix  | mat3                         | Inverse normal matrix for camera transformations |
| InverseCameraProjectionMatrix | mat4                      | Inverse of the camera projection matrix        |
| CameraPosition            | vec3                         | Position of the camera                         |
| CameraRange               | vec2                         | Camera near and far range                      |
| CameraZoom               | float                        | Camera zoom level                              |
| CameraProjectionMode       | int                          | Camera projection mode                         |

## Render Settings

| Name                          | Type                         | Description                                     |
|----------------------------------------|------------------------------|------------------------------------------------|
| MaterialIndex            | uvec3                        | Material index                                 |
| TextureFlags              | uint                         | Texture flags                                  |
| TextureLodBias           | float                        | Texture Level of Detail bias                    |
| BaseTextureLodBias       | float                        | Base texture LOD bias                           |
| SelectionColor            | vec4                         | Selection color                                |
| DisplayScale             | float                        | Display scale                                  |
| AmbientLight              | vec3                         | Ambient light color                            |
| IBLIntensity             | float                        | Image-based lighting intensity                 |
| SkyColor                   | vec3                         | Sky color                                      |
| BackgroundColor             | vec4                         | Background color                               |
| MeshDisplacementScale    | float                        | Mesh displacement scale                        |
| BlendMode                 | uint                         | Blend mode                                     |
| RenderFlags               | uint                         | Render flags                                   |
| RenderTween              | float                        | Render tween (animation factor)                |
| DrawViewport              | ivec4                        | Draw viewport (x, y, width, height)            |
| BufferSize                        | vec2                         | Buffer size (derived from DrawViewport)        |
| ToneMappingMode              | int                          | Tone mapping mode                              |
|  CameraTessellation        | float                        | Camera tessellation factor                     |
| RenderMode                   | int                          | Render mode                                    |

## Fog Settings

| Name                          | Type                         | Description                                     |
|----------------------------------------|------------------------------|------------------------------------------------|
| FogColor                   | vec4                         | Fog color                                      |
| FogRange                   | vec2                         | Fog range (near and far)                       |
| FogAngles                  | vec2                         | Fog angles (directional)                       |
| FogDensity                 | float                        | Fog density                                    |

## Miscellaneous

| Name                          | Type                         | Description                                     |
|----------------------------------------|------------------------------|------------------------------------------------|
| CurrentTime               | uint                         | Current time in milliseconds                     |
| PassIndex                    | int                          | Current rendering pass index, for point lights and VR                    |
