# VrDevice::GetPose

This method retrieves a device pose. This is a predefined point of interest on the physical device.

## Syntax

- [Mat4](Mat4.md) **GetPose**(VrPose pose, bool adjusted = true)

| Parameter | Description |
|---|---|
| pose | can be VRPOSE_EYELEFT or VRPOSE_EYERIGHT for headsets, or VRPOSE_GRIP or VRPOSE_AIM for controllers |
| adjusted | if set to true, the current HMD offset will be considered, otherwise the real-world orientation will be returned |

## Returns

Returns a 4x4 matrix describing the requested pose.
