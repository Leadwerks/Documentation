# RenderStats

This class contains information about the rendering thread. To enable statistics recording, you must call the [World:RecordStats](World_RecordStats.md) method.

| Property | Type | Description |
| ----- | ----- | ----- |
| cameras | number | Number of cameras rendered in the previous frame, not including shadow updates.|
| cullingtime | number | Time taken to calculate current visibility set |
| instances | number | Number of instances drawn in the previous frame |
| framerate | number | Smoothed current average framerate |
| meshbatches | number | Number of mesh batches drawn in the previous frame.|
| polygons | number | Number of polygons drawn in the previous frame, including shadows |
| shaderbatches | number | Number of shader batches drawn in the previous frame |
| shadows | number | Number of shadows updated in the previous frame |
| shadowpolygons | number | Number of shadow polygons drawn in the previous frame |
| rendertime | number | CPU time taken to render the previous frame, in milliseconds |
| vertices | number | Number of vertices drawn in the previous frame |
| vram | number | Phyical device memory limit |
