# Entity:SetEmissionColor

This method can be used to set the emission color of a visible entity such as a model or light.

## Syntax

- **SetEmissionColor**([Vec3](Vec3.md) color)
- **SetEmissionColor**([Vec3](Vec3.md) color, boolean recursive = false)
- **SetEmissionColor**(number r, number g, number b)
- **SetEmissionColor**(number r, number g, number b, boolean recursive = false)
- **SetEmissionColor**(number luminance)
- **SetEmissionColor**(number luminance, boolean recursive = false)

| Parameter | Description |
| ---- | ---- |
| color | RGBA color to set |
| r | red component of the color to set |
| g | green component of the color to set |
| b | blue component of the color to set |
| luminance | RGB brightness to set |
| recursive | if set to true the entity subhierarchy will also be affected |

## Remarks

Emission color will only be visible if the object's material has an emission texture.
