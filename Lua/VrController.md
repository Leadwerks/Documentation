# VrController

Base class: [VrDevice](VrDevice.md)

This class handles hand-held virtual reality controllers, for a variety of hardware devices.

| Property | Type | Description |
|---|---|---|
| index | int | read-only controller index, 1 (left) or 2 (right) |
| [ButtonDown](VrController_ButtonDown.md) | Method | returns the button pressed state |
| [ButtonHit](VrController_ButtonHit.md) | Method | returns the button hit state |
| [GetTouch](VrController_GetTouch.md) | Method | returns the surface touch state |
| [GetAxis](VrController_GetAxis.md) | Method | returns the specified input axis value |
| [Rumble](VrController_Rumble.md) | Method | triggers a haptic pulse |
