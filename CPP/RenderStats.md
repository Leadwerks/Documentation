# RenderStats #
This class contains information about the rendering thread. To enable statistics recording, you must call the [World::RecordStats](World_RecordStats.md) method.

| Property | Type | Description |
| ----- | ----- | ----- |
|		 cameras | int | Number of cameras rendered in the previous frame, not including shadow updates.|
|		 instances | int | Number of instances drawn in the previous frame |
|		 framerate | int | Smoothed current average framerate |
|    meshbatches | int | Number of mesh batches drawn in the previous frame.|
|		 polygons | int | Number of polygons drawn in the previous frame, including shadows |
|		 pipelines | int | Number of shader batches drawn in the previous frame |
|		 shadows | int | Number of shadows updated in the previous frame |
|		 shadowpolygons | int | Number of shadow polygons drawn in the previous frame |
|		 rendertime | int | CPU time taken to render the previous frame, in milliseconds |
|		 vertices | int | Number of vertices drawn in the previous frame |

