# 3D Models

www.youtube.com/watch?v=PNzHP8Oo7Lo

Leadwerks can load 3D models from Khronos glTF, Wavefront OBJ formats, as well as its own proprietary MDL format. FBX files can be converted to MDL format in the editor.

## Downloading 3D Models

You can download a variety of game-ready 3D models in the [downloads manager](downloadsmanager.md).

## Importing 3D Models

To import a 3D model into your project, simply copy all files into your game's folder or subfolders. glTF, WAV, and Leadwerks MDL files can be immediately opened by double-clicking on them in the [project panel](assetbrowser). You can convert FBX files to Leadwerks MDL format by right-clicking on the file thumbnail and selecting the **Convert to MDL** popup menu.

## Adding a Model to the Scene

To insert an instance of a model into your scene, just click and hold on the file thumbnail with the **left mouse button**. Drag and mouse into any of the viewports and release the mouse button when you are hovered over the spot you wish to place the model.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/addmodel.gif?raw=true)

## Editing Models

You can double-click on a model file icon to open it in the [model editor](modeleditor.md). This interface provides a variety of tools to adjust model files. You can save the model when you are done editing, to overwrite the original file and store your changes.

Typically, your workflow should involve moving 3D models from other file formats and resaving as Leadwerks MDLs, as this format supports many features others do not.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/modeleditor.gif?raw=true)

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

