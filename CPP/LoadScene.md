# LoadScene

This command loads a scene from a file path or stream.

## Syntax

- shared_ptr<[Scene](Scene.md)> **LoadScene**(shared_ptr<[World](World.md)> world, const [WString](WString.md)& path, const LoadFlags flags = LOAD_DEFAULT, shared_ptr<[Object](Object.md)> extra = NULL)
- shared_ptr<[Scene](Scene.md)> **LoadScene**(shared_ptr<[World](World.md)> world, shared_ptr<[Stream](Stream.md)> stream, shared_ptr<[Stream](Stream.md)> binstream, const LoadFlags flags = LOAD_DEFAULT, shared_ptr<[Object](Object.md)> extra = NULL)

## Returns

If the scene is successfully loaded a new map is returned, otherwise NULL is returned.
