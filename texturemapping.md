# Texture Mapping

www.youtube.com/watch?v=PKcLxcp1O2s

Leadwerks provides tools to easily adjust texture mapping on primitives.

## Texture Lock

When the texture lock setting is disabled, texture mapping on primitives will stay aligned to the world when an object moves.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/textureunlock.gif?raw=true)

When the texture lock setting is enabled, texture mapping on primitives will stay aligned to an object when it moves.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/texturelock.gif?raw=true)

## Face Panel

When the face tool is select, the face panel will become available in the right-side panel. Within the face panel, you'll find several properties that control the texture mapping of the selected brush faces:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/facepanel.png?raw=true)

- **Offset**: The offset parameter allows you to control the position of the texture mapping on the selected face. Adjusting this parameter shifts the texture relative to the face, enabling precise texture placement.

- **Scale**: The scale parameter governs the scale of the texture mapping on the selected face. This scale factor works in conjunction with the brush mapping scale set in the program settings within the Options Window. The brush scale factor, specified in texels per meter, is multiplied by the scale factor presented in the Face Panel interface. This combination permits fine-grained control over the size and tiling of textures on the brush faces.

- **Rotation**: This allows you to rotate the texture around, to align it in a different direction.

## Texture Alignment

The Face Panel also provides alignment options that simplify the task of aligning textures to the geometry of the brush:

- Alignment Buttons: These buttons offer various alignment options for your textures, allowing you to align them to specific edges, center them on the face, or fit them snugly to the brush face's boundaries. This level of control ensures that your textures blend seamlessly with the brush geometry, enhancing the overall visual appeal of your map.

- Unify Faces: By checking the "Unify Faces" checkbox, you can instruct the texture alignment process to treat all coplanar faces as a single surface. This simplifies the alignment of textures across multiple connected faces, creating a more cohesive and uniform appearance.
