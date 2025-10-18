# LoadTile

This function loads a tile from an image file. The image will be applied to the tile and its dimensions will be used for the tile size.

## Syntax

- [Tile](Tile,md) **LoadTile**([Camera](Camera.md) camera, string path, number flags = LOAD_DEFAULT)
- [Tile](Tile,md) **LoadTile**([World](World.md) world, string path, number flags = LOAD_DEFAULT)

| Parameter | Description |
|--|--|
| camera | camera to create the tile on |
| world | world to create the tile in |
| path | file path to load | 
| flags | optional load flags |

## Returns

Returns a new tile, or NULL if the image cannot be loaded.
