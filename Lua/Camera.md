# Camera

Base class: [Entity](Entity.md)

The camera class is an entity used to render the world.

## Properties

| Property             | Type     | Description                                          |
| -------------------- | -------- | ---------------------------------------------------- |
| [AddPostEffect](Camera_AddPostEffect.md)    | Method   | Adds a post-processing effect to the post-processing effects stack.     |
| [ClearPostEffects](ClearPostEffects.md)    | Method   | Clears the post-processing effects stack.     |
| [Pick](Camera_Pick.md)    | Method   | performs a raycast at the specified screen coordinates     |
| [Project](Camera_Project.md)    | Method   | projects a position from world to screen space     |
| [Render](Camera_Render.md)    | Method   | refreshes a camera view, for non-realtime cameras     |
| [SetBackfaceCulling](Camera_SetBackfaceCulling.md)    | Method   | overrides the backface culling mode of all objects     |
| [SetClearMode](Camera_SetClearMode.md)    | Method   | controls color and depth clearing     |
| [SetDepthPrepass](Camera_SetDepthPrepass.md)    | Method   | sets the camera depth pre-pass mode     |
| [SetFov](Camera_SetFov.md)    | Method   | sets the camera field of view     |
| [SetProjectionMode](Camera_SetProjectionMode.md) | Method | sets the camera projection mode |
| [SetRealtime](Camera_SetRealtime.md)    | Method   | sets realtime rendering mode     |
| [SetRefraction](Camera_SetRefraction.md)    | Method   | enables or disables transparency refraction     |
| [SetRenderTarget](Camera_SetRenderTarget.md)    | Method   | for render-to-texture     |
| [SetTessellation](Camera_SetTessellation.md)    | Method   | sets camera tessellation density     |
| [SetZoom](Camera_SetZoom.md)    | Method   | sets the camera zoom     |
| [UnProject](Camera_UnProject.md)    | Method   | unprojects a position from screen to world space     |
| [CreateCamera](CreateCamera.md)    | Function | creates a new camera entity     |
