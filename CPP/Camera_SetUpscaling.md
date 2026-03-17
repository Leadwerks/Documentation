# Camera::SetUpscaling

This method controls the optional camera upscaling feature. Upscaling works by rendering to a low-resolution image and then applying techniques to increase the image detail. This can provide a significant increase in rendering performance, with only a small loss of visual quality.

## Syntax

- void **SetUpscaling**(float scale, float sharpen = 0.2)

| Parameter | Description |
|---|---|
| scale | the upscaling factor, between 1.0 and 2.0 |
| sharpen | the sharpening factor, between 0.0 and 2.0 |

## Remarks

The scale value controls the amount of upsampling. Higher values will cause a lower-resolution image to be rendered to, increasing performance. A scale value of 1.0 disables upscaling.

The scale value should be combined with the [Camera::SetTextureLodBias](Camera_SetTextureLodBias.md) command, according quality settings displayed in the table below.

| Setting | Scale	| Mip bias |
|---|---|---|
| Ultra quality | 1.3 | -0.38 |
| Wuality | 1.53 | -0.58 |
| Ultra quality | 1.7 | -0.79 |
| Ultra quality | 2.0 | -1.0 |

The sharpen value uses 0.0 for max sharpening. Higher values will use less sharpening. Values above 2.0 will not be detectable.
