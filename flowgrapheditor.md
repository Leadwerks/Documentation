# Flowgraph Editor

The flowgraph editor provides an interface for visual editor of scene events. This tool is accessed by pressing the **Flowgraph Editor** button in the left-side bar.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/flowgraph.png?raw=true)

## Adding Entities to the Flowgraph

You can click and drag any object from the [scene tree](mapbrowser.md) into the flowgraph window to make it accessible in the flowgraph interface.

The purpose of the flowgraph editor is to connect inputs and outputs between [components](entitycomponentsystem.md), so you really only want to add entities to the flowgraph editor if they have components you want to connect.

All the components that are attached to an entity will appear on the block that represents the object. Functions that can act as inputs are listed on the left side of the block. Function that can act as outputs are lsited on the right side of the block.

## Connecting Entities

To connect two objects, click the mouse left button on an output function, drag the mouse, and release the mouse button over an input function to create a connection. 

![](https://github.com/UltraEngine/Documentation/blob/master/Images/flowgraphconnect.png?raw=true)

You can remove connections by clicking on the input function, dragging the connection away, and releasing the mouse while it is hovered over an empty area.

When the game is run and the input function is executed, it will trigger the output function. The exact behavior of these functions depends on the code contained in the component.

## Removing Entities

You can remove an entity from the flowgraph by right-clicking on it and select the **Remove** popup menu.
