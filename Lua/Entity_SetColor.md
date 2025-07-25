# Entity:SetColor

This method can be used to colorize a visible entity such as a model or light.

## Syntax

- **SetColor**([Vec4](Vec4.md) color)
- **SetColor**([Vec4](Vec4.md) color, boolean recursive = false)
- **SetColor**(number r, number g, number b)
- **SetColor**(number r, number g, number b, boolean recursive = false)
- **SetColor**(number luminance)
- **SetColor**(number luminance, boolean recursive = false)

| Parameter | Description |
| ---- | ---- |
| color | RGBA color to set |
| r | red component of the color to set |
| g | green component of the color to set |
| b | blue component of the color to set |
| a | alpha component of the color to set |
| luminance | RGB brightness to set |
| recursive | if set to true the entity subhierarchy will also be affected |
