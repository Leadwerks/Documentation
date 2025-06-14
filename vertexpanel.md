# Vertex Panel

The vertex panel provides fine control over vertex displacement settings. By default, vertices will use the auto setting, but you can override this for more precise control if you wish.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/vertexpanel.png?raw=true)

When auto displacement is enabled, a vertex that is connected to more than one unhidden faces will have displacement disabled, to prevent cracks from forming along the edges of primitives.

In the screenshot below, the box on the left allows displacement on its edge vertices because the adjacent faces for those edges are hidden. The box on the right disables displacement on the edge vertices, to prevent cracks from forming.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/vertexautodisplacement.jpg?raw=true)
