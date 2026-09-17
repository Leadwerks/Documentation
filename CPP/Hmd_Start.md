# Hmd::Start

This method starts a VR session.

## Syntax

- bool **Start**(shared_ptr<[Framebuffer](Framebuffer.md)\> framebuffer)

| Parameter | Description |
|---|---|
| framebuffer | framebuffer to mirror the display to |

## Returns

Returns true if the HMD is capable of starting a new session.

## Remarks

At the time of this writing, SteamVR cannot start a new OpenXR session on a different framebuffer once a previous session has started and ended. This is a bug in SteamVR and has been reported to Valve.
