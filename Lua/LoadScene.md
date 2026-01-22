# LoadScene

This command loads a scene from a file path or stream.

## Syntax

- [Scene](Scene.md) **LoadScene**([World](World.md) world, [string](https://www.lua.org/manual/5.4/manual.html#6.4) path)
- [Scene](Scene.md) **LoadScene**([World](World.md) world, [string](https://www.lua.org/manual/5.4/manual.html#6.4) path, number flags = LOAD_DEFAULT)
- [Scene](Scene.md) **LoadScene**([World](World.md) world, [string](https://www.lua.org/manual/5.4/manual.html#6.4) path, number flags = LOAD_DEFAULT, extra = nil)
- [Scene](Scene.md) **LoadScene**([World](World.md) world, [Stream](Stream.md) stream, [Stream](Stream.md) binstream)
- [Scene](Scene.md) **LoadScene**([World](World.md) world, [Stream](Stream.md) stream, [Stream](Stream.md) binstream, number flags = LOAD_DEFAULT)
- [Scene](Scene.md) **LoadScene**([World](World.md) world, [Stream](Stream.md) stream, [Stream](Stream.md) binstream, number flags = LOAD_DEFAULT, extra = nil)

## Returns

If the scene is successfully loaded a new map is returned, otherwise NULL is returned.
