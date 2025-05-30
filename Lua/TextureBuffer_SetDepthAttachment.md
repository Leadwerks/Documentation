# TextureBuffer:SetDepthAttachment

This method sets a texture buffer's depth texture.

## Syntax

- boolean **SetDepthAttachment**([Texture](Texture.md) texture)

| Parameter | Description |
|---|---|
| texture | depth attachment to set |

## Returns

Returns true of the depth attachment is set, otherwise false is returned.

## Remarks

The specified texture must use a renderable depth format.

The specified texture must have been created with the TEXTURE_BUFFER flag.

The specified texture must be the same dimensions as the texture buffer.
