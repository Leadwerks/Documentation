# LoadTexture

This function loads a texture from a file path or stream.

## Syntax

- shared_ptr<[Texture](Texture.md)\> LoadTexture(const [WString](WString.md)& path, const LoadFlags flags = LOAD_DEFAULT)
- shared_ptr<[Texture](Texture.md)\> LoadTexture(shared_ptr<[Stream](Stream.md)\>,const LoadFlags flags = LOAD_DEFAULT)

| Parameter | Description |
|---|---|
| path | file path to load the pixmap from |
| stream | stream to load the pixmap from |
| flags | optional load flags |

## Returns

Returns the loaded texture, or NULL if no pixmap was loaded.

## Example

```c++

```
