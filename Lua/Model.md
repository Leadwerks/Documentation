# Model

Base class: [Entity](Entity.md)

The model class is used for visible 3D objects. Models can be loaded from files or created from scratch.

Ultra Engine natively supports loading and saving of models in the [glTF](https://www.khronos.org/gltf/) and Wavefront OBJ file formats. Other model formats can be loaded via the [plugin](Plugin.md) system.

| Property | Type | Description |
|---|---|---|
| lods | [Lod](Lod.md)[] | read-only array of Lods |
| skeleton | [Skeleton](Skeleton.md)[] | read-only skeleton object |
| [AddMesh](Model_AddMesh.md) | Method | adds a new mesh to the model |
| [AddLod](Model_AddLod.md) | Method | adds a new level-of-detail to the model |
| [Animate](Model_Animate.md) | Method | animates the model |
| [Clear](Model_Clear.md) | Method | removes all meshes |
| [Collapse](Model_Collapse.md) | Method | collapses the model hierarchy |
| [CountAnimationFrames](CountAnimationFrames.md) | Method | returns the number of frames in an animation |
| [CountAnimations](CountAnimations.md) | Method | returns the number animation sequences |
| [GetAnimationSpeed](GetAnimationSpeed.md) | Method | returns the speed of an animation |
| [GetAnimationName](GetAnimationName.md) | Method | returns the name of an animation |
| [Save](Model_Save.md) | Method | saves the model to a file |
| [SetLodDistance](Model_SetLodDistance) | Method | sets the base Lod distance factor |
| [SetSkeleton](Model_SetSkeleton) | Method | allows models to share a single skeleton |
| [UpdateNormals](Model_UpdateNormals.md) | Method | calculates new mesh normals |
| [CreateBox](CreateBox.md) | Function | creates a new box model |
| [CreateCone](CreateCone.md) | Function | creates a new cone model |
| [CreateCubeSphere](CreateCubeSphere.md) | Function | creates a new sphere model |
| [CreateCylinder](CreateCylinder.md) | Function | creates a new cylinder model |
| [CreateModel](CreateModel.md) | Function | creates a new model |
| [CreatePlane](CreatePlane.md) | Function | creates a new plane model |
| [CreateSphere](CreateSphere.md) | Function | creates a new sphere model |
| [LoadModel](LoadModel.md) | Function | loads a model from a file |
