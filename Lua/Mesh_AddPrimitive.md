# Mesh:AddPrimitive

Base class: [Mesh](Mesh.md)

This method add a single line, triangle, or quad to the mesh.

## Syntax

- number **AddPrimitive**(number a, number b)
- number **AddPrimitive**(number a, number b, number c)
- number **AddPrimitive**(number a, number b, number c, number d)

| Parameter | Description |
|---|---|
| a, b, c, d | vertex indices |

## Returns

Returns the index of the new primitive.

## Remarks

THe number of arguments must match the mesh primitive type.
