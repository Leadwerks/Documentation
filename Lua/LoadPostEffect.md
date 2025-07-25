# LoadPostEffect

This function loads a post-processing effect from a file.

## Syntax

- [PostEffect](PostEffect.md) **LoadPostEffect**([string](https://www.lua.org/manual/5.4/manual.html#6.4) path)
- [PostEffect](PostEffect.md) **LoadPostEffect**([string](https://www.lua.org/manual/5.4/manual.html#6.4) path, number flags)

| Parameter | Description |
|-----------|-------------|
| path      | file name to load |
| flags     | optional load flags |

## Returns

Returns the loaded post-processing effect if successful, otherwise `nil` is returned.
