# VrController::ButtonHit

This method gets the button hit state.

## Syntax

- bool **ButtonHit**(const VrControllerButton button)

| Parameter | Description |
|---|---|
| button | can be VRBUTTON_PRIMARY, VRBUTTON_SECONDARY, VRBUTTON_GRIP, or VRBUTTON_THUMBSTICK |

## Returns

Returns true if the specified button has been pressed since the last call to this method, otherwise false is returned.
