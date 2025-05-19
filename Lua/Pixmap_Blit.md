# Pixmap:Blit

This method copies an area of one pixmap to another with scaling and filtering. Pixels that lie outside the area of the destination pixmap will be skipped.

## Syntax

- boolean **Blit**(number x, number y, number width, number height, [Pixmap](Pixmap.md) dest, number destx, number desty, number destwidth, number destheight, number filter = TEXTUREFILTER_LINEAR)

| Parameter | Description |
|---|---|
| x, y | source copy position |
| width, height | source copy area |
| dest | destination pixmap |
| destx, desty | destination write position |
| destwidth, destheight | destination copy area |
| filter | texture filter, can be TEXTUREFILTER_LINEAR or TEXTUREFILTER_NEAREST |
  
## Returns
  
Returns true if any pixels are written.
  
If the destination pixmap is NULL then false is returned.
  
If the destination area does not overlap the destination pixmap then false is returned.
  
If the destination pixmap format does not match this pixmap's format then false is returned.

If the pixmap block size is greater than one, as it is for compressed formats, then false is returned.

If the pixmap format does not support blitting, then false is returned.

## Example

![](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/pixmap_blit.png)

```lua
-- Load pixmap
local pixmap = LoadPixmap("https://github.com/UltraEngine/Documentation/raw/master/Assets/Materials/Brick/brickwall01.dds")

-- Convert to RGBA format if needed
if pixmap.format ~= TEXTURE_RGBA then
    pixmap = pixmap:Convert(TEXTURE_RGBA)
end

-- Copy a section of the image with scaling and filtering
local width = 50
local height = 50
pixmap:Blit(0, 0, width, height, pixmap, 156, 156, width * 4, height * 4)

-- Save and view the image
pixmap:Save(GetPath(PATH_DESKTOP) .. "/test.png")
RunFile(GetPath(PATH_DESKTOP) .. "/test.png")
```
