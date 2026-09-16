# Hmd

Base class: [VrDevice](VrDevice.md)

The Hmd (head-mounted display) class provide access to virtual reality features.

| Property | Type | Description |
| --- | --- | --- |
| controllers | const array<shared_ptr<[VrController](VrController.md)>, 2>& | left and right hand controllers |
| [SetOffset](Hmd_SetOffset.md) | Method | sets an offset position and rotation |
| [Start](Hmd_Start.md) | Method | starts a VR session |
| [Stop](Hmd_Stop.md) | Method | stops a VR session |
| [GetHmd](GetHmd.md) | Function | returns the user's head-mounted display |
