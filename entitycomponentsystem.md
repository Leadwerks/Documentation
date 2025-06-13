# Entity Component System

The Leadwerks entity component system allows you to assign behaviors and attributes to 3D objects in your scene. Each component contains values that can be modified in the editor, and functions that will execute code at key points in the game loop. Components can be used to add enemy behavior, movement, sound, and a variety of other behaviors and attributes.

An entity may have one or more components attached to it:

- Entity
  - Component 1
  - Component 2
  - Component 3
 
One entity may only have one instance of any specific component attached to it; you may not add the same component twice to the same entity.

Components are stored in source code files located in one of the subfolders found in the Source/Components directory.

## Adding Components

To add a component to an entity, press the **Add Component** button at the bottom of the [scene panel](mapbrowser.md).

![](https://github.com/UltraEngine/Documentation/blob/master/Images/addcomponent.png?raw=true)

A dialog will appear that shows a list of components to choose from, separated into categories.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/addcomponent2.png?raw=true)

Double-click on the component you want to add, and it will appear as a new group in the entity properties.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/addcomponent3.png?raw=true)

## Creating New Components

To create a new component, press the '+' button at the top of the [scene panel](mapbrowser.md) interface, and select the **Add Component** popup menu item. A dialog will appear that allows you to enter a name for the component and select the group it belongs in.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/newcomponent.png?raw=true)

Press the **OK** button to create the new component, and a new code file will be added in the appropriate directory, along with an associated JSON file.

### C++ Projects

If your project uses C++, then the new .cpp and .h file will be automatically inserted into your Visual Studio project, so they will be included in the game next time you compile it.
