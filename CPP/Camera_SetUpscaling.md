# Camera::SetUpscaling

This method controls the optional camera upscaling feature. Upscaling works by rendering to a low-resolution image and then applying techniques to increase the image detail. This can provide a significant increase in rendering performance, with only a small loss of visual quality.

## Syntax

- void **SetUpscaling**(float scale)

| Parameter | Description |
|---|---|
| scale | the upscaling factor, between 1.0 and 2.0 |

## Remarks

The scale value controls the amount of upsampling. Higher values will cause a lower-resolution image to be rendered to, increasing performance.

Native resolution (upscaling disabled) uses a scale of 1.0.
