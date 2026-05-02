# Shader Uniforms

## Camera Settings

| Name                          | Type                         | Description                                     |
|----------------------------------------|------------------------------|------------------------------------------------|
| CameraPosition            | vec3                         | Position of the camera                         |
| CameraRange               | vec2                         | Camera near and far range                      |
| CameraZoom               | float                        | Camera zoom level                              |
| CameraProjectionMode       | int                          | Camera projection mode                         |
| CameraTessellation        | float                        | Camera tessellation factor                     |
| CameraMatrix              | mat4                         | Camera transformation matrix                   |
| CameraNormalMatrix        | mat3                         | Normal matrix for camera transformations       |
| InverseCameraMatrix       | mat4                         | Inverse of the camera matrix                     |
| InverseCameraNormalMatrix  | mat3                         | Inverse normal matrix for camera transformations |
| InverseCameraProjectionMatrix | mat4                      | Inverse of the camera projection matrix        |
| CameraProjectionMatrix    | mat4                         | Camera projection matrix                       |

## Render Settings

| Name                          | Type                         | Description                                     |
|----------------------------------------|------------------------------|------------------------------------------------|
| MaterialIndex            | uvec3                        | Material index                                 |
| TextureFlags              | uint                         | Texture flags                                  |
| TextureLodBias           | float                        | Texture Level of Detail bias                    |
| BaseTextureLodBias       | float                        | Base texture LOD bias                           |
| SelectionColor            | vec4                         | Selection color                                |
| DisplayScale             | float                        | Display scale                                  |
| BlendMode                 | uint                         | Blend mode                                     |
| RenderFlags               | uint                         | Render flags                                   |
| RenderTween              | float                        | Render tween (animation factor)                |
| DrawViewport              | ivec4                        | Draw viewport (x, y, width, height)            |
| BufferSize                        | vec2                         | Buffer size (derived from DrawViewport)        |
| ToneMappingMode              | int                          | Tone mapping mode                              |
| RenderMode                   | int                          | Render mode                                    |

## Environment Settings

| Name                          | Type                         | Description                                     |
|----------------------------------------|------------------------------|------------------------------------------------|
| AmbientLight              | vec3                         | Ambient light color                            |
| IBLIntensity             | float                        | Image-based lighting intensity                 |
| SkyColor                   | vec3                         | Sky color                                      |
| BackgroundColor             | vec4                         | Background color                               |

## Fog Settings

| Name                          | Type                         | Description                                     |
|----------------------------------------|------------------------------|------------------------------------------------|
| FogColor                   | vec4                         | Fog color                                      |
| FogRange                   | vec2                         | Fog range (near and far)                       |
| FogAngles                  | vec2                         | Fog angles (directional)                       |
| FogDensity                 | float                        | Fog density                                    |

## Sea Settings

| Name                          | Type                         | Description                                     |
|----------------------------------------|------------------------------|------------------------------------------------|
| SeaLevel             | float                         | Background color                               |
| SeaMaterial              | uint                         | Ambient light color                            |
| SeaWaveAmplitude             | float                        | Image-based lighting intensity                 |
| SeaWaveSpeed                   | float                         | Sky color                                      |
| SeaWaveIterations             | int                         | Background color                               |

## Miscellaneous

| Name                          | Type                         | Description                                     |
|----------------------------------------|------------------------------|------------------------------------------------|
| CurrentTime               | uint                         | Current time in milliseconds                     |
| PassIndex                    | int                          | Current rendering pass index, for point lights and VR                    |
