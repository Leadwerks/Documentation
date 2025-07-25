# CreateTile

This function creates a new tile for 2D drawing. Tiles can be rectangles or text.

## Syntax

- [Tile](Tile) **CreateTile**([Camera](Camera) camera, number width, number height)
- [Tile](Tile) **CreateTile**([Camera](Camera) camera, number width, number height, boolean wireframe)
- [Tile](Tile) **CreateTile**([Camera](Camera) camera, [Vec2](Vec2) size)
- [Tile](Tile) **CreateTile**([Camera](Camera) camera, [Vec2](Vec2) size, boolean wireframe)
- [Tile](Tile) **CreateTile**([Camera](Camera) camera, [Font](Font) font, string text)
- [Tile](Tile) **CreateTile**([Camera](Camera) camera, [Font](Font) font, string text, number fontsize, number alignment, number linespacing)

| Parameter | Description |
|---|---|
| camera | camera the tile will appear on |
| size, width, height | size of a rectangle tile |
| wireframe | if set to true a line rectangle will be created, otherwise a solid rectangle will be created |
| font | font to create a text tile with |
| fontsize | font size to create a text tile with |
| alignment | text alignment, can be any combination of TEXT_LEFT, TEXT_CENTER, TEXT_RIGHT, TEXT_TOP, TEXT_MIDDLE, and TEXT_BOTTOM |
| linespacing | text spacing between multiple lines of text |

## Returns

Returns a new tile.
