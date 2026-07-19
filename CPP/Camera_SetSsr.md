# Camera::SetSsr

This method controls the camera screen-space reflection settings.

## Syntax

- **SetSsr**(bool mode, float scale = 0.75, float stepsize = 0.01, float stepdelta = 1.1, int maxsteps = 100, bool reflecttransparency = false)

| Parameter | Description |
|---|---|
| mode | enables or disables the effect |
| scale | resolution of the screen-space reflection buffer, between 0.5 and 1.0 |
| stepsize | starting step distance of the ray march, in meters |
| stepdelta | a multiplier to increase the ray march distance each step |
| maxsteps | maximum number of ray march steps |
| reflecttransparency | if set to true, transparent surfaces with depth mask disabled will appear in reflections |

The quality settings used by Leadwerks Editor are shown below.

| Quality | scale | stepsize | stepdelta | maxsteps |
|---|---|---|---|---|
| Low | 0.5 | 0.02 | 1.2 | 50 |
| Medium | 0.75 | 0.01 | 1.1 | 100 |
| High | 1.0 | 0.005 | 1.0 | 200 |
