# Pixmap:CopyRect

This method copies an area of one pixmap to another. Pixels that lie outside the area of the destination pixmap will be skipped.

## Syntax

- bool **CopyRect**(const int x, const int y, const int width, const int height, [Pixmap](Pixmap.md) dst, const int dx, const int dy)

| Parameter | Description |
|---|---|
| x, y | source copy position |
| width, height | source copy area |
| dst | destination pixmap |
| dx, dy | destination write position |
  
## Returns
  
Returns true if any pixels are copied.
  
If the destination pixmap is NULL then false is returned.
  
If the destination area does not overlap the destination pixmap then false is returned.
  
If the destination pixmap format does not match this pixmap's format then false is returned.

If the pixmap uses a compressed format, such as DXT1 / BC1, DXT5 / BC3, etc., then the source and destination position and the area must be evenly divisible by the block size (4), or false is returned.

If the pixmap uses BC6H or BC7 compression then false is returned.

## Example

```lua
--Load image
local pixmap = LoadPixmap("https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets/Materials/scifiwall.jpg")

--Convert to RGBA if not already
if pixmap.format ~= TEXTURE_RGBA then
    pixmap = pixmap:Convert(TEXTURE_RGBA)
end

--Let's make some changes :D
pixmap:CopyRect(0,0,256,256,pixmap,256,256)

--Save uncompressed DDS file
SaveTexture("MODIFIED.dds", TEXTURE_2D, {pixmap}, 1, SAVE_DEFAULT)

--Convert to compressed format
pixmap = pixmap:Convert(TEXTURE_BC1)

--We specify blocks, not pixels. Blocks are 4x4 squares.
pixmap:CopyRect(0,0,64,64,pixmap,64,64)

--Save
SaveTexture("COMPRESSED+MODIFIED.dds", TEXTURE_2D, {pixmap}, 1, SAVE_DEFAULT)

OpenDir(CurrentDir() .. "/MODIFIED.dds")
```
