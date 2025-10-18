# CreateTile

This function creates a new tile for 2D drawing. Tiles can be rectangles or text.

## Syntax

- [Tile](Tile) **CreateTile**([Camera](Camera) camera, number width, number height, boolean wireframe = false)
- [Tile](Tile) **CreateTile**([Camera](Camera) camera, [Vec2](Vec2) size, boolean wireframe = false)
- [Tile](Tile) **CreateTile**([Camera](Camera) camera, [Font](Font) font, string text, number fontsize = 14, number alignment = TEXT_LEFT, number linespacing = 1.5)
- [Tile](Tile) **CreateTile**([World](World) world, number width, number height, boolean wireframe = false)
- [Tile](Tile) **CreateTile**([World](World) world, [Vec2](Vec2) size, boolean wireframe = false)
- [Tile](Tile) **CreateTile**([World](World) world, [Font](Font) font, string text, number fontsize = 14, number alignment = TEXT_LEFT, number linespacing = 1.5)

| Parameter | Description |
|---|---|
| camera | camera the tile will appear on |
| world | world the tile will appear in, rendered last after all cameras are drawn |
| size, width, height | size of a rectangle tile |
| wireframe | if set to true a line rectangle will be created, otherwise a solid rectangle will be created |
| font | font to create a text tile with |
| fontsize | font size to create a text tile with |
| alignment | text alignment, can be any combination of TEXT_LEFT, TEXT_CENTER, TEXT_RIGHT, TEXT_TOP, TEXT_MIDDLE, and TEXT_BOTTOM |
| linespacing | text spacing between multiple lines of text |

## Remarks

The text alignment flags can be used to control the orientation of the text around the tile handle. The default orientation is top-left.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/textalignment.png?raw=true)

## Returns

Returns a new tile.
