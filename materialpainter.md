# Material Painter

The material painter tool allows you to paint materials across level geometry to add detail and make the scene more interesting.

To access this tool, select the Material Painter button in the left-side bar. The tool options will appear in the right-side panel.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/materialpainter.png?raw=true)

The interface for this tool is relatively simple, with controls for the tool radius and strength. 

Currently, material painting is only supported on primitives that are created in the editor.

You can choose to paint on all surfaces, only the selected surfaces, or only the first surface you pick when you press down the mouse button.

To begin paint, press the **Browse** button and select a material to use. You can paint on level geometry by clicking and holding the left mouse button as you move the mouse.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/materialpaint1.jpg?raw=true)

Materials are painted per vertex. By default, primitive objects are created with the only vertices in their corners. You can increase the subdivision of a face using the [Face Tool](facepanel.md), which will give you more vertices to work with, so that you can create a more interesting appearance.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/materialpaint2.jpg?raw=true)

Painted materials work with tessellation and displacement. If a material uses displacement, and tessellation is enabled in the user options, then painted materials will produce geometry details popping out of a surface, which can look incredible.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/materialpaint3.jpg?raw=true)

By default, displacement is disabled on edge vertices, to prevent cracks from forming. If needed you can adjust this behavior in the [Vertex Panel](vertexpanel.md).
