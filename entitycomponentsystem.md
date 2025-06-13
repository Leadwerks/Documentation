# Entity Component System

The Leadwerks entity component system allows you to assign behaviors and attributes to 3D objects in your scene. Each component contains values that can be modified in the editor, and functions that will execute code at key points in the game loop. Components can be used to add enemy behavior, movement, sound, and a variety of other behaviors and attributes.

An entity may have one or more components attached to it:

- Entity
  - Component 1
  - Component 2
  - Component 3
 
One entity may only have one instance of any specific component attached to it; you may not add the same component twice to the same entity.

Components are stored in source code files located in one of the subfolders found in the Source/Components directory.

## Creating Components

To create a new component, press the '+' button at the top of the [scene panel](mapbrowser.md) interface, and select the **Add Component** popup menu item. A dialog will appear that allows you to enter a name for the component and select the group it belongs in.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/newcomponent.png?raw=true)
