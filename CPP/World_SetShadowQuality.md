# World::SetShadowQuality

- void **SetShadowQuality**(float quality)

| Parameter | Description |
|---|---|
| quality | this setting will scale the shadow resolution of all lights in the world, and decrease their depth offsets accordingly. The table below shows suggested values that are also used in the editor. |

Lights use a 1024 x 1024 shadow map size by default, so if a quality setting of 2.0 is used, the default shadow map size is increased to 2048 x 2048.

| Quality | Scale | Description |
|---|---|---|
| 0.5 | 50% | Low |
| 1.0 | 100% | Medium |
| 2.0 | 200% | High |

Any value greater than zero can be used, but take caution that higher quality settings may cause the GPU to run out of video memory, and values that result in power-of-two shadowmap sizes are preferred.
