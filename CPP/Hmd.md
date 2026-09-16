# Hmd

Base class: [VrDevice](VrDevice.md)

The Hmd (head-mounted display) class provide access to virtual reality features.

| Property | Type | Description |
| --- | --- | --- |
| cameras | array<shared_ptr<[Camera](Camera.md)>, 2> | read-only left and right eye cameras |
| controllers | array<shared_ptr<[VrController](VrController.md)>, 2> | read-only left and right hand controllers |
| [GetRefreshRate](Hmd_GetRefreshRate.md) | Method | returns the headset refresh rate |
| [SetOffset](Hmd_SetOffset.md) | Method | sets an offset position and rotation |
| [Start](Hmd_Start.md) | Method | starts a VR session |
| [Stop](Hmd_Stop.md) | Method | stops a VR session |
| [GetHmd](GetHmd.md) | Function | returns the user's head-mounted display |

