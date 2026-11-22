# Camera::SetVolumetricLighting

This method controls the camera volumetric lighting effect. When this effect is enabled, any lights with volumetric transmission will use a raymarching algorithm to produce a misty appearance.

## Syntax

- void **SetVolumetricLighting**(const bool mode, const float scale = 0.5f, const float stepsize = 0.25f)

| Parameter | Description |
|---|---|
| mode | if true the effect is enabled, otherwise it will be disabled |
| scale | resolution scale for the effect, usually between 0.25 to 1.0 |
| stepsize | size of each ray marching step, in meters |
