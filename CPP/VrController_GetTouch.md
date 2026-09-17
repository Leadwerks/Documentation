# VrController:GetTouch

This method gets the current touch state of the controller.

## Syntax

- bool **GetTouch**(VrTouchSurface surface)

| Parameter | Description |
|---|---|
| surface | can be VRTOUCH_PRIMARY, VRTOUCH_SECONDARY, VRTOUCH_TRIGGER, or VRTOUCH_THUMBSTICK |

## Returns

Returns true if the specified surface is touched, otherwise false is returned.
