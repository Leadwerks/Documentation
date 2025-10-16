# CreateTile

This function creates a new tile for 2D drawing. Tiles can be rectangles or text.

## Syntax

- shared_ptr<[Tile](Tile)\> **CreateTile**(shared_ptr<[Camera](Camera)> camera, const float width, const float height, const bool wireframe = false)
- shared_ptr<[Tile](Tile)\> **CreateTile**(shared_ptr<[Camera](Camera)> camera, const [Vec2](Vec2)& size, const bool wireframe = false)
- shared_ptr<[Tile](Tile)\> **CreateTile**(shared_ptr<[Camera](Camera)> camera, shared_ptr<[Font](Font)> font, const [WString](WString)& text, const int fontsize = 14, const TextAlignment alignment = TEXT_LEFT, const float linespacing = 1.5f)
- shared_ptr<[Tile](Tile)\> **CreateTile**(shared_ptr<[World](World)> world, const float width, const float height, const bool wireframe = false)
- shared_ptr<[Tile](Tile)\> **CreateTile**(shared_ptr<[World](World)> world, const [Vec2](Vec2)& size, const bool wireframe = false)
- shared_ptr<[Tile](Tile)\> **CreateTile**(shared_ptr<[World](World)> world, shared_ptr<[Font](Font)> font, const [WString](WString)& text, const int fontsize = 14, const TextAlignment alignment = TEXT_LEFT, const float linespacing = 1.5f)

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

## Returns

Returns a new tile.
