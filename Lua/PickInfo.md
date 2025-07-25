# PickInfo

This class contains information from the results of a ray cast.

| Property | Type | Description |
| ----- | ----- | ----- |
| entity | [Entity](Entity.md) | picked entity |
| face | [Face](Face.md) | picked face, for brushes |
| mesh | [Mesh](Mesh.md) | picked mesh, for models |
| meshlayer | integer | index of picked mesh layer |
| meshlayerinstance | [iVec2](iVec2.md) | picked mesh layer instance coordinate |
| normal | [xVec3](xVec3.md) | picked normal |
| polygon | integer | picked polygon, for models |
| position | [xVec3](xVec3.md) | picked position |
| texcoords | [table](https://www.lua.org/manual/5.4/manual.html#6.6) | array of picked texture coordinates, for brushes or models |
