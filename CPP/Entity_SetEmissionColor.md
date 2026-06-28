# Entity::SetEmissionColor

This method can be used to set the emission color of a visible entity such as a model or light.

## Syntax

- void **SetEmissionColor**([Vec3](Vec3.md) color)
- void **SetEmissionColor**([Vec3](Vec3.md) color, bool recursive = false)
- void **SetEmissionColor**(float r, float g, float b)
- void **SetEmissionColor**(float r, float g, float b, bool recursive = false)
- void **SetEmissionColor**(float luminance)
- void **SetEmissionColor**(float luminance, bool recursive = false)

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
