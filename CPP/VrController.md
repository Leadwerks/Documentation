# VrController

Base class: [VrDevice](VrDevice.md)

This class handles hand-held virtual reality controllers, for a variety of hardware devices.

| Property | Type | Description |
|---|---|---|
| index | int | read-only controller index, 0 (left) or 1 (right) |
| [ButtonDown](VrController_ButtonDown.md) | Method | returns the button pressed state |
| [ButtonHit](VrController_ButtonHit.md) | Method | returns the button hit state |
| [ButtonTouched](VrController_ButtonTouched.md) | Method | returns the button touch state |
| [GetAxis](VrController_GetAxis.md) | Method | returns the specified input axis value |
| [Rumble](VrController_Rumble.md) | Method | triggers a haptic pulse |
