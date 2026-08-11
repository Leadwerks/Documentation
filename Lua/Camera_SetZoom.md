# Camera:SetZoom

This method sets the camera zoom factor.

## Syntax

- **SetZoom**(number zoom)

## Parameters

| Parameter | Description |
| --- | --- |
| zoom | camera zoom factor |

## Remarks

The default camera zoom is 1.0.

For cameras that use perspective projection, a zoom value of 1.0 gives the camera a 90 degree vertical field of view, meaning it can see up 45 degrees and down 45 degrees. This is a little bit wide for most first-person games, which should use a field of view around 70. The field of view is calculated by the screen height, as this gives a more consistent appearance when switching between standard and ultra-wide screens.

For orthographic cameras, a zoom value of 1.0 means that a 1x1x1 meter box will appear one pixel tall and one pixel wide onscreen. A zoom value of 2.0 will make the box appear 2x2 pixels onscreen.
