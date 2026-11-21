# Camera::SetVolumetricLighting

This method controls the camera volumetric lighting effect. When this effect is enabled, any lights with volumetric transmission will use a raymarching algorithm to produce a misty appearance.

## Syntax

- **SetVolumetricLighting**(const bool mode, const float quality)

| Parameter | Description |
|---|---|
| mode | if true the effect is enabled, otherwise it will be disabled |
| quality | resolution scale for the effect, usually between 0.25 to 1.0 |
