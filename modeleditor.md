# Model Editor

When a model file is opened, two tabs appear in the Asset Editor window. If the model includes animations, you'll find an animation bar at the bottom of the window, complete with controls for selecting and playing animations.

![Model Editor](https://github.com/UltraEngine/Documentation/blob/master/Images/modeleditor.png?raw=true)

In the Model Editor, you can also work with any embedded materials and textures packed into the model file, allowing you to select and modify these resources conveniently.

![Model Editor - Materials and Textures](https://github.com/UltraEngine/Documentation/blob/master/Images/modeleditor2.png?raw=true)

## Convert Textures to DDS

Often times models that come in glTF and FBX format will use PNG and sometimes JPG files for textures. These image files are slow-loading because mipmaps have to be generated at load time. They also use more video memory because they get stored in an uncompressed pixel format in memory. You can optimize these models by selecting the **Tools > Convert Texture to DDS** menu item. This will convert all image files into optimized DDS textures using the appropriate compression format for each image. The resulting texture files will load faster and usually use less video memory.

When you are done with this step, save the model as a Leadwerks MDL file, since other model file formats may not support DDS textures.

## Colliders

In order for a 3D model to be reactive to physical collisions with other objects, it must have a collision shape set. You can assign a collision shape by selecting the top-most node in the model hierarchy. In the Physics properties, there is a drop-down box you can use to select a collider shape. The editor will attempt to choose the best size to make the collider fit the model, but you can adjust the offset, rotation, and size of the collider manually if it is necessary.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/boxcollider.png?raw=true)

A box or convex hull collider works best for most objects.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/hullcollider.png?raw=true)

The Mesh collider just uses the object's own geometry for the collision shape. This provides an exact match between visual and physical geometry, but it may not be ideal for detailed models, since more details shapes will cause the physics system to slow down. Additionally, objects using a mesh collider are always static in the world. Other objects can bump off of them, but the object using the mesh collider will remain still in the world.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/meshcollider.png?raw=true)

For more complex shapes, the convex decomposition tool may be a better choice than a mesh collider. To open the tool, select the **Tools > Convex Decomposition** menu item. A window will open with many settings you can adjust to get the right shape. The resulting collider will be made of multiple objects, but each object will be a convex hull shape. With a little experimentation you can get a collider shape that matches the mesh geometry closely but isn't too complex.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/hullcollider2.png?raw=true)

Since the resulting collider is made of convex hulls, the object will be physically reactive in the world.

When you are done adjusting the collision shape, save the model as a Leadwerks .mdl file. Other model file formats do not support collider shapes.

## Mesh Reduction

The model editor interface includes a tool for reducing mesh detail. To access this tool, select the **Tools > Mesh Reduction** menu item. When this tool is active, a wireframe overlay will be displayed on the model, for easy viewing of the mesh topology.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/lod0.png?raw=true)

The slider at the top of the window allows you to adjust the detail, to try to reach a desired number of polygons.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/lod1.png?raw=true)

Once you have reduced the mesh to your liking, you can press the **Apply** button to apply your changes to the base model, or press **Add LOD** to add the reduced detail mesh as a new level-of-detail model. LODs are reduced detail versions of a model that are swapped out when the viewer is further away, since not as much detail is visible from a distance. Using models with LODs can help improve rendering performance and framerates in complex scenes with many detailed objects.

When you are done adding LODs, save the model as a Leadwerks .mdl file. Other model file formats do not support LODs.

## Imposters

You can generate an imposter for any 3D model, but these are usually used with trees. An imposter is a set of images drawn from one direction that are adjusted based on the angle between the object and the viewer. This can reduce complex objects to just a single plane made up of two triangles, greatly increasing the rendering performance of large scenes with many objects.

To run this operation, select the **Tools > Generate Imposter** menu item. It may take a few moments to complete the task. The resulting imposter mesh will be added as the last LOD shown in the model hierarchy. The editor will save three array textures, storing the base color, normals, and metallic-roughness values for each pixel, when viewed from a series of different angles.

![Asset Editor](https://github.com/UltraEngine/Documentation/blob/master/Images/imposter_color.png?raw=true) 
![Asset Editor](https://github.com/UltraEngine/Documentation/blob/master/Images/imposter_normal.png?raw=true) 
![Asset Editor](https://github.com/UltraEngine/Documentation/blob/master/Images/imposter_orm.png?raw=true)

When you are done adding an imposter, save the model as a Leadwerks .mdl file. Other model file formats do not support this feature.
