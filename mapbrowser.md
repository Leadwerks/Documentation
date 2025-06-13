# Scene Browser

The Map Browser is an essential component of Ultra Engine's user interface, providing a streamlined approach to managing and inspecting the elements of your 3D scene.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/mapbrowser.png?raw=true)

Here's an in-depth look at its features and functionality:

## Scene Hierarchy Display
The top half of the Map Browser presents a hierarchical view of your scene, making it easy to navigate through the various elements that compose your 3D environment. This hierarchy represents the relationship between different objects, offering a visual representation of the structure of your scene.

### Object Properties Panel
The bottom half of the Map Browser is dedicated to displaying the properties of the selected objects. This Properties Panel dynamically updates to provide you with insights into the characteristics and settings of the currently selected object, facilitating efficient object customization.

### Environment Properties
When you select the root scene node, the Properties Panel showcases the environment properties. These settings allow you to control critical world-level configurations, including ambient light levels, gravity, and the environment maps utilized for background visuals and the handling of specular and diffuse reflections.

### Entity Properties
When an entity is selected within the hierarchy, the Properties Panel will reveal the entity's properties.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/entityproperties.png?raw=true)

These properties are categorized into three main sections:

- **Transform**: This section manages the object's positioning, rotation, and scaling within the scene.

- **Appearance**: Here, you can fine-tune the visual aspects of the entity, such as materials, textures, and shaders.

- **Physics**: For entities requiring physical interaction, the Physics category provides options to configure attributes like mass, friction, and collision behavior.

## Adding Components

To extend the functionality of a selected entity, you can use the "Add Component" button located at the bottom of the Properties Panel. This feature enables you to attach additional components to the entity, each of which comes with its set of editable properties. Components enhance the versatility and capabilities of entities, allowing you to create complex and interactive objects.

The Map Browser and its associated Properties Panel are integral tools for managing the elements of your 3D scene, providing a clear visual representation of your project's structure and enabling efficient customization and optimization.
