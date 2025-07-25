# TextureBuffer

Base class: [Object](Object.md)

This class is used for render-to-texture operations.

| Property | Type | Description |
|---|---|---|
| size | [iVec2](iVec2.md) | read-only dimensions |
| textures | [Texture](Texture.md)[8] | read-only texture attachments |
| [CountColorAttachments](TextureBuffer_CountColorAttachments.md) | Method | returns the number of color attachments |
| [GetColorAttachment](TextureBuffer_GetColorAttachment.md) | Method | returns the color attachment |
| [GetDepthAttachment](TextureBuffer_GetDepthAttachment.md) | Method | returns the depth attachment |
| [GetSize](TextureBuffer_GetSize.md) | Method | returns the texture buffer dimensions |
| [SetColorAttachment](TextureBuffer_SetColorAttachment.md) | Method | sets the color render texture |
| [SetDepthAttachment](TextureBuffer_SetDepthAttachment.md) | Method | sets the depth render texture |
| [CreateTextureBuffer](CreateTextureBuffer.md) | Function | returns a new texturebuffer object |
