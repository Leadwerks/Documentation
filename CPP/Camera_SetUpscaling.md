# Camera::SetUpscaling

This method controls the optional camera upscaling feature. Upscaling works by rendering to a low-resolution image and then applying techniques to increase the image detail. This can provide a significant increase in rendering performance, with only a small loss of visual quality.

## Syntax

- void **SetUpscaling**(UpscalingQuality mode)
- void **SetUpscaling**(float scale, float sharpen = 0.2)

| Parameter | Description |
|---|---|
| mode | this can be UPSCALE_PERFORMANCE, UPSCALE_BALANCED, UPSCALE_QUALITY, UPSCALE_ULTRAQUALITY, or UPSCALE_NATIVE |
| scale | the upscaling factor, between 1.0 and 2.0 |
| sharpen | the sharpening factor, between 0.0 and 2.0 |

## Remarks

The scale value controls the amount of upsampling. Higher values will cause a lower-resolution image to be rendered to, increasing performance.

The scale value should be combined with the [Camera::SetTextureLodBias](Camera_SetTextureLodBias.md) command, according quality settings displayed in the table below.

| Setting | Scale	| Mip bias |
|---|---|---|
| Ultra quality | 1.3 | -0.38 |
| Quality | 1.53 | -0.58 |
| Ultra quality | 1.7 | -0.79 |
| Ultra quality | 2.0 | -1.0 |

Native resolution (upscaling disabled) would use a scale of 1.0 and a texture LOD bias of 0.0.

If an UpscalingQuality constant is provided, the texture LOD bias will be set automatically.

The sharpen value uses 0.0 for max sharpening. Higher values will use less sharpening. Values above 2.0 will not be detectable.
