# Camera:SetVolumetricLighting

This method controls the camera volumetric lighting effect. When this effect is enabled, any lights with volumetric transmission will use a raymarching algorithm to produce a misty appearance.

## Syntax

- **SetVolumetricLighting**(boolean mode, number scale = 0.5, number stepsize = 0.25)

| Parameter | Description |
|---|---|
| mode | if true the effect is enabled, otherwise it will be disabled |
| scale | resolution scale for the effect, usually between 0.25 to 1.0 |
| stepsize | size of each ray marching step, in meters |
