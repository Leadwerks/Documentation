# Vegetation

The vegetation tool lets you paint trees, plants, rocks, and other items onto a landscape to quickly create entire forests. It can be accessed by selecting the [Terrain Panel](terrainpanel.md) and then selecting the **Vegetaion** tool in the Tool drop-down box.

Like terrain materials, vegetation is separated into separate layers, each with its own properties. Each layer can contain one or more variations. These are usually different versions of a model that help to create a more random look to the scene and prevent repetition. The variations are randomly selected by the vegetation system.

## Adding Vegetation Layers

To add a new vegation layer to the terrain, press the **Add** button at the bottom of the vegetation panel. Select the **Add Layer** popup menu. An file open dialog will appear, allowing you to browse to and select a model file to use for the vegetation layer. If you select multiple model files with the file open dialog, each model will be added as a variation in the new layer.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/vegetationlayer.png?raw=true)

Once the vegetation layer is added, you can begin painting it onto the landscape. With the vegetation layer or a variation selected in the list, click and hold the left mouse button on the terrain. Drag the mouse across the terrain to create instances of your layer.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/vegetationpaint.png?raw=true)

If you hold the **Control** key while painting, the vegetation tool will act as an eraser to remove instances from the terrain.

## Layer Properties

Each vegetation layer has the following adjustable properties.

**Name**: The name displayed in the vegetation layer list.

**Seed**: A random seed for calculating the orientation of instances. You can change this value to produce a different orientation for all instances in the layer.

**Density**: The average distance between instances in the layer. You can use this to spread instances apart, or pack them more tightly together.

**Min slope**: The minimum terrain slope, in degrees, above which instances can appear. This can be used to only make cliff rocks appear on the sides of hills, for example.

**Max slope**: The maximum terrain slope, in degrees, below which instances can appear. This can be used to prevent grass from growing on the side of a cliff, for example.

**Min height**: The minimum terrain height, in meters, above which vegetation instances can appear. This can prevent plants from growing underwater, for example.

**Max height**: The maximum terrain height, in meters, below which vegetation instances can appear. This can be used to create a tree line, above which no trees can grow.

## Variation Properties

Each vegetation layer variation has the following properties that can be adjusted independently from other layer variations.

**Model**: Selects the model to use for the variation.

**Alignment**: You can choose center (the default) mode, per-vertex, or rotate to normal.

The per-vertex mode is useful for making grass align precisely to the terrain.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/vegetationvertexalignment.jpg?raw=true)

The rotate-to-normal model is useful for making rocks rotate to the slope of the terrain they are resting on.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/vegetationnormalalignment.jpg?raw=true)

**Pick mode**: Controls the pick mode of the instances, for ray casting operations.

**Weight**: A percentage value indicating how likely this variation is to appear. This can be used to ensure that a very unique variation of a model that stands out a lot will get used less frequently. The weights of all layer variations will be normalized automatically.

**LOD range**: This provides control over the distances at which the instances will change LODs, if the model contains multiple levels of detail.

**View range**: This controls the maximum distance beyond which the instances will disappear from view.

**Shadow**: This can be used to enable or disable shadows on the model.

**Collision**: This indicates whether the instances are collidable with physics. To be interactive, the model must also include a collider.

**Nav obstacle**: This indicates whether instances of the model interact with the navigation mesh system. To be interactive, the model must also include a collider.
