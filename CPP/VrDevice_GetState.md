# VRDevice::GetState

This method returns the current state of the device.

## Syntax

VrDeviceState **GetState**()

## Returns

This method can return VRDEVICESTATE_INACTIVE, VRDEVICESTATE_STARTING, VRDEVICESTATE_IDLE, or VRDEVICESTATE_ACTIVE.

VRDEVICESTATE_INACTIVE is returned if the device is not detected.

VRDEVICESTATE_STARTING is returned if the device is an [Hmd](Hmd.md) and is currently starting up.

VRDEVICESTATE_IDLE is returned for devices that are detected but not currently in use by the player.

VRDEVICESTATE_ACTIVE is returned for devices that are currently in use by the player.
