# LoadTile

This function loads a tile from an image file. The image will be applied to the tile and its dimensions will be used for the tile size.

## Syntax

- shared_ptr<[Tile](Tile,md)\> **LoadTile**(shared_ptr<[Camera](Camera.md)\> camera, [WString](WString.md) path, LoadFlags flags = LOAD_DEFAULT)
- shared_ptr<[Tile](Tile,md)\> **LoadTile**(shared_ptr<[World](World.md)\> world, [WString](WString.md) path, LoadFlags flags = LOAD_DEFAULT)

| Parameter | Description |
|--|--|
| camera | camera to create the tile on |
| world | world to create the tile in |
| path | file path to load | 
| flags | optional load flags |

## Returns

Returns a new tile, or NULL if the image cannot be loaded.
