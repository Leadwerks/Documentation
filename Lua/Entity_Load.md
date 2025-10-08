# Entity:Load

This function is called when a component is loaded from a file or copied.

## Syntax

- boolean **Load**([table](https://www.lua.org/manual/5.4/manual.html#6.6) properties, [Stream](Stream.md) binstream, [Scene](Scene.md) scene, number flags, extra)

| Parameter | Description |
|---|---|
| properties | component properties |
| binstream | stream of binary data |
| scene | map that is being loaded |
| flags | map load flags |
| extra | user-defined value |

## Returns

Returns true if the component is successfully loaded, otherwise false is returned.
