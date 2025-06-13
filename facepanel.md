# Face Panel

The Face Panel provides properties and controls for the selected brush faces within your scene. The panel will be visible when you activate the Face tool in the left side bar.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/facepanel.png?raw=true)

## Texture Mapping

Within the Face Panel, you'll find several parameters that are crucial for manipulating the texture mapping of the selected brush faces:

- Offset: The offset parameter allows you to control the position of the texture mapping on the selected face. Adjusting this parameter shifts the texture relative to the face, enabling precise texture placement.

- Scale: The scale parameter governs the scale of the texture mapping on the selected face. This scale factor works in conjunction with the brush mapping scale set in the program settings within the Options Window. The brush scale factor, specified in texels per meter, is multiplied by the scale factor presented in the Face Panel interface. This combination permits fine-grained control over the size and tiling of textures on the brush faces.

## Texture Alignment

The Face Panel also provides alignment options that simplify the task of aligning textures to the geometry of the brush:

- Alignment Buttons: These buttons offer various alignment options for your textures, allowing you to align them to specific edges, center them on the face, or fit them snugly to the brush face's boundaries. This level of control ensures that your textures blend seamlessly with the brush geometry, enhancing the overall visual appeal of your map.

- Unify Faces: By checking the "Unify Faces" checkbox, you can instruct the texture alignment process to treat all coplanar faces as a single surface. This simplifies the alignment of textures across multiple connected faces, creating a more cohesive and uniform appearance.

The Face Panel empowers you to manage and fine-tune texture mapping on your brush faces, enhancing the visual quality of your map and streamlining the texturing process.

## Edges

If the edge size setting is set to be greater than zero, the face will have a skirt of polygons added around its perimeter. This is useful for both bevelled edges and tessellation with displacement.

## Bevels

You can set a face to use smooth bevelled edges, using a technique called edge-turn normals.

You can see the difference in the two objects below. The first box has sharp edges, with the bevel feature disabled.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/sharpedges.png?raw=true)

The second image shows the same box with the edge size set to 4 cm and bevels enabled for each face.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/softedges.png?raw=true)

Edges will only be bevelled if both the adjacent faces have the bevel setting enabled. In the image below, the top and left faces have bevels enabled, but the face on the right does not. The edge between the top and left faces is rounded, but the other visible edges are sharp.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/bevelexample.jpg?raw=true)

When used appropriately, bevelled edges are an easy way to give your scene a more professional look.

## Subdivision

Faces can be subdivided with the Subdivision setting. This is useful for material painting, which operates on a per-vertex level.

![](https://github.com/Leadwerks/Documentation/blob/master/Images/subd.png?raw=true)

Face subdivision is also useful when tessellation is in use. The GPU tessellation shader has a limited number of times it can subdivide polygons on the GPU, so you should try to keep a vertex spacing of about one meter across faces if a material tessellation with will be used.

Subdivision works with faces that have any number of sides.

![](https://github.com/Leadwerks/Documentation/blob/master/Images/subd2.png?raw=true)

## Materials

The materials list allows you to view all materials that are in use on the selected faces. Usually only one material will appear in the list, but multiple materials can be added and blended on a per-vertex basis with the [Material Painter](materialpainter.md) tool. The face panel allows you to inspect faces closely to see exactly which materials they are using, and perform additional fine-tuning if needed.
