# Terrain

Base class: [Entity](Entity.md)

Ultra Engine supports a powerful heightmap terrain system for rendering large landscapes. Multiple terrains can be created and positioned, with up to 256 different materials applied to any single terrain.

| Property | Type | Description |
|-----|-----|-----|
| heightmap | [Pixmap](Pixmap.md) | read-only pixmap containing terrain elevation data |
| material | [Material](Material.md) | read-only material containing height and normal textures |
| resolution | [iVec2](iVec2.md) | read-only terrain resolution |
| [AddLayer](Terrain_AddLayer.md) | Method | adds a new terrain material layer |
| [Fill](Terrain_Fill.md) | Method | paints the terrain with the specified material layer |
| [GetElevation](Terrain_GetElevation.md) | Method | returns the scaled terrain height |
| [GetHeight](Terrain_GetHeight.md) | Method | returns the heightmap height at the specified point |
| [GetLayers](Terrain_GetLayers.md) | Method | returns the layers in use at the specified point |
| [GetLayerWeight](Terrain_GetLayerWeight.md) | Method | returns the weight of the layer at the specified point |
| [GetLayerHeightConstraints](Terrain_GetLayerHeightConstraints.md) | Method | returns the layer height contraints |
| [GetLayerMapping](Terrain_GetLayerMapping.md) | Method | returns the layer texture mapping mode |
| [GetLayerMaterial](Terrain_GetLayerMaterial.md) | Method | returns the material used by this layer |
| [GetLayerSlopeConstraints](Terrain_GetLayerSlopeConstraints.md) | Method | returns the layer slope constraints |
| [GetNormal](Terrain_GetNormal.md) | Method | returns the normal of the terrain at the specified position |
| [GetSlope](Terrain_GetSlope.md) | Method | returns the slope of the terrain at the specified position |
| [GetTileHidden](Terrain_GetTileHidden.md) | Method | gets the visibility of a single terrain tile |
| [LoadHeightmap](Terrain_LoadHeightmap.md) | Method | loads a heightmap from a file |
| [SetBasemapSize](Terrain_SetBasemapSize.md) | Method | sets the terrain basemap resolution |
| [SetHeight](Terrain_SetHeight.md) | Method | sets the terrain height at the specified point |
| [SetLayerHeightConstraints](Terrain_SetLayerHeightConstraints.md) | Method | sets the terrain layer height constraints |
| [SetLayerMapping](Terrain_SetLayerMapping.md) | Method | sets the terrain layer texture mapping mode |
| [SetLayerScale](Terrain_SetLayerScale.md) | Method | sets the terrain layer texture mapping scale |
| [SetLayerSlopeConstraints](Terrain_SetLayerSlopeConstraints.md) | Method | sets the layer slope constraints |
| [SetLayerWeight](Terrain_SetLayerWeight.md) | Method | sets the layer to be used at the specified point |
| [SetTileHidden](Terrain_SetTileHidden.md) | Method | hides or shows a single terrain tile |
| [CreateTerrain](CreateTerrain.md) | Function | creates a new terrain entity |
