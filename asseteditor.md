# Asset Editor

Each asset file you open in the editor will open in its own window. You can have multiple assets of the same or different types open at the same time.

## Opening Assets

To access the Asset Editor, simply double-click the desired asset in the [Project Panel](assetbrowser.md). This action will open the asset in a new Asset Editor window.

![Asset Editor](https://github.com/UltraEngine/Documentation/blob/master/Images/modeleditor.png?raw=true)

## Asset-specific Views

The appearance and available features within the Asset Editor window may vary based on the type of asset you've opened.

### Model Assets

When a model file is opened, two tabs appear in the Asset Editor window. If the model includes animations, you'll find an animation bar at the bottom of the window, complete with controls for selecting and playing animations.

![Model Editor](https://github.com/UltraEngine/Documentation/blob/master/Images/modeleditor.png?raw=true)

In the Model Editor, you can also work with any embedded materials and textures packed into the model file, allowing you to select and modify these resources conveniently.

![Model Editor - Materials and Textures](https://github.com/UltraEngine/Documentation/blob/master/Images/modeleditor2.png?raw=true)

#### Colliders

In order for a 3D model to be reactive to physical collisions with other objects, it must have a collision shape set. You can assign a collision shape by selecting the top-most node in the model hierarchy. In the Physics properties, there is a drop-down box you can use to select a collider shape. The editor will attempt to choose the best size to make the collider fit the model, but you can adjust the offset, rotation, and size of the collider manually if it is necessary.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/boxcollider.png?raw=true)

A box or convex hull collider works best for most objects.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/hullcollider.png?raw=true)

The Mesh collider just uses the object's own geometry for the collision shape. This provides an exact match between visual and physical geometry, but it may not be ideal for detailed models, since more details shapes will cause the physics system to slow down. Additionally, objects using a mesh collider are always static in the world. Other objects can bump off of them, but the object using the mesh collider will remain still in the world.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/meshcollider.png?raw=true)

For more complex shapes, the convex decomposition tool may be a better choice than a mesh collider. To open the tool, select the **Tools > Convex Decomposition** menu item.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/hullcollider2.png?raw=true)

### Material Assets

For material assets, the Asset Editor's properties tab provides access to all material settings and associated textures, enabling you to fine-tune the appearance and behavior of materials.

![Material Editor](https://github.com/UltraEngine/Documentation/blob/master/Images/materialeditor.png?raw=true)

### Texture Assets

When you open a texture asset in the Asset Editor, you'll find an interface that displays all relevant texture settings. This allows you to edit and customize the properties of the texture.

![Texture Editor](https://github.com/UltraEngine/Documentation/blob/master/Images/textureeditor.png?raw=true)
