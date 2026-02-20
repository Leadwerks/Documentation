# Camera:SetMouseLook

Thie command enables mouse looking behavior for a camera. Low-latency mouse input running in the rendering thread will be anbled, for machines that support this feature.

## Syntax

- **SetMouseLook**(boolean mode, number lookspeed = 0.1f, number smoothing = 1.0f, boolean invertmouse = false, [Vec2](Vec2.md) pitchlimits = Vec2(-90.0f,90.0f) )

| Parameter | Description | 
|---|---|
| mode | set to true to enable mouse looking behavior |
| lookspeed | camera look speed |
| smoothing | camera look smoothness |
| invertmouse | set to true to invert the mouse Y axis |
| pitchlimits | minimum and maximum camera pitch |
