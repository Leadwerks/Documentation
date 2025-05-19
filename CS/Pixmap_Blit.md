# Pixmap.Blit

This method copies an area of one pixmap to another with scaling and filtering. Pixels that lie outside the area of the destination pixmap will be skipped.

## Syntax

- bool **Blit**(int x, int y, int width, int height, [Pixmap](Pixmap.md) dest, int destx, int desty, int destwidth, int destheight)

| Parameter | Description |
|---|---|
| x, y | source copy position |
| width, height | source copy area |
| dest | destination pixmap |
| destx, desty | destination write position |
| destwidth, destheight | destination copy area |
  
## Returns
  
Returns true if any pixels are written.
  
If the destination pixmap is NULL then false is returned.
  
If the destination area does not overlap the destination pixmap then false is returned.
  
If the destination pixmap format does not match this pixmap's format then false is returned.

If the pixmap block size is greater than one, as it is for compressed formats, then false is returned.

If the pixmap format does not support blitting, then false is returned.

## Example

![](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/pixmap_blit.png)

```csharp
using System;
using UltraEngine;

class Program
{
    static void Main(string[] args)
    {
        // Load pixmap
        var pixmap = LoadPixmap("https://github.com/UltraEngine/Documentation/raw/master/Assets/Materials/Brick/brickwall01.dds");

        // Convert to RGBA format if needed
        if (pixmap.format != TextureFormat.RGBA) pixmap = pixmap.Convert(TextureFormat.RGBA);

        // Copy a section of the image with scaling and filtering
        int width = 50;
        int height = 50;
        pixmap.Blit(0, 0, width, height, pixmap, 156, 156, width * 4, height * 4);

        // Save and view the image
        pixmap.Save(GetPath(PathType.Desktop) + "/test.png");
        RunFile(GetPath(PathType.Desktop) + "/test.png");
    }
}
```
