# LoadScene

This command loads a scene from a file path or stream.

## Syntax

- shared_ptr<[Scene](Scene.md)> LoadScene(shared_ptr<[World](World.md)> world, const [WString](WString.md)& path, const [LoadFlags](Constants.md) flags = LOAD_DEFAULT)
- shared_ptr<[Scene](Scene.md)> LoadScene(shared_ptr<[World](World.md)> world, shared_ptr<[Stream](Stream.md)> stream, shared_ptr<[Stream](Stream.md)> binstream, const [LoadFlags](Constants.md) flags = LOAD_DEFAULT)

## Returns

If the scene is successfully loaded a new scene object is returned, otherwise NULL is returned.
