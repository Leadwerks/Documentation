# Entity

Base class: [Object](Object.md)

This class serves as the foundation for all 3D objects in a world. It provides a common set of properties and methods that are shared by all 3D objects, including terrain, lights, 3D models, and other types of objects.

| Property | Type | Description |
|---|---|---|
| extra | [Object](Object.md) | user-defined object |
| kids | vector<shared_ptr<[Entity](Entity.md)\> \> | read-only array of child entities |
| matrix | [xMat4](xMat4.md) | read-only 4x4 matrix |
| name | [WString](WString.md) | entity name |
| omega | [xVec3](xVec3.md) | read-only angular velocity |
| parent | [Entity](Entity.md) | entity parent |
| position | [xVec3](xVec3.md) | read-only position |
| properties | [table](https://github.com/UltraEngine/tableplusplus) | user-defined properties |
| quaternion | [xQuat](xQuat.md) | read-only rotation |
| rotation | [xVec3](xVec3.md) | read-only Euler rotation |
| scale | [xVec3](xVec3.md) | read-only scale |
| tags | set<[WString](WString.md)> | read-only container of tags |
| velocity | [xVec3](xVec3.md) | read-only linear velocity |
| [AddComponent](Entity_AddComponent.md) | Method | adds an entity component |
| [AddForce](Entity_AddForce.md) | Method | apply linear force to the entity |
| [AddPointForce](Entity_AddPointForce.md) | Method | apply linear force at a specific point |
| [AddTag](Entity_AddTag.md) | Method | adds a tag |
| [AddTorque](Entity_AddTorque.md) | Method | apply torque to the entity |
| [AlignToVector](Entity_AlignToVector.md) | Method | aligns an axis to a vector |
| [Attach](Entity_Attach.md) | Method | attaches the entity to a bone or navigation agent |
| [ClearTags](Entity_ClearTags.md) | Method | removes all tags |
| [Copy](Entity_Copy.md) | Method | duplicates the entity |
| [EmitSound](Entity_EmitSound.md) | Method | plays a sound at the entity's position |
| [FindChild](Entity_FindChild.md) | Method | searches for a child by name |
| [GetAirborne](Entity_GetAirborne.md) | Method | returns the airborne state of a player |
| [GetAngularVelocity](Entity_GetAngularVelocity.md) | Method | returns the entity angular velocity |
| [GetBounds](Entity_GetBounds.md) | Method | returns an axis-aligned bounding box |
| [GetCollider](Entity_GetCollider.md) | Method | returns the physics collider |
| [GetComponent](Entity_GetComponent.md) | Method | gets an entity component |
| [GetCollisionType](Entity_GetCollisionType.md) | Method | returns the collision type |
| [GetColor](Entity_GetColor.md) | Method | returns the entity color |
| [GetCrouched](Entity_GetCrouched.md) | Method | returns the crouched state of a player |
| [GetDecalLayers](Entity_GetDecalLayers.md) | Method | gets the decal filtering flags |
| [GetDistance](Entity_GetDistance.md) | Method | calculates distance to another entity |
| [GetHidden](Entity_GetHidden.md) | Method | returns the entity hide state |
| [GetMass](Entity_GetMass.md) | Method | returns the entity mass |
| [GetMatrix](Entity_GetMatrix.md) | Method | returns the entity 4x4 matrix |
| [GetParent](Entity_GetParent.md) | Method | returns the parent entity |
| [GetPhysicsMode](Entity_GetPhysicsMode.md) | Method | gets the entity physics behavior |
| [GetPickMode](Entity_GetPickMode.md) | Method | returns the entity pick mode |
| [GetPosition](Entity_GetPosition.md) | Method | returns the entity position |
| [GetRotation](Entity_GetRotation.md) | Method | returns the entity Euler rotation |
| [GetQuaternion](Entity_GetQuaternion.md) | Method | returns the entity rotation |
| [GetScale](Entity_GetScale.md) | Method | returns the entity scale |
| [GetUuid](Entity_GetUuid.md) | Method | returns the entity's unique identifier |
| [GetVelocity](Entity_GetVelocity.md) | Method | returns the entity linear velocity |
| [GetWorld](Entity_GetWorld.md) | Method | returns the world the entity resides in |
| [Instantiate](Entity_Instantiate.md) | Method | creates an instanced copy of the entity |
| [Listen](Entity_Listen.md) | Method | uses the entity for sound spatialization |
| [Move](Entity_Move.md) | Method | moves the entity |
| [Point](Entity_Point.md) | Method | points one entity at another |
| [RecordCollisions](Entity_RecordCollisions.md) | Method | enables collision recording |
| [RemoveTag](Entity_RemoveTag.md) | Method | removes a tag |
| [SetAngularVelocity](Entity_SetAngularVelocity.md) | Method |sets the entity angular velcoty |
| [SetCollider](Entity_SetCollider.md) | Method | sets the entity physics collider |
| [SetCollisionType](Entity_SetCollisionType.md) | Method | sets the entity collision type |
| [SetColor](Entity_SetColor.md) | Method | sets the entity color |
| [SetDamping](Entity_SetDamping.md) | Method | sets the entity physics damping |
| [SetDecalLayers](Entity_SetDecalLayers.md) | Method | sets the decal filtering flags |
| [SetElasticity](Entity_SetElasticity.md) | Method | sets the entity physics elasticity |
| [SetFriction](Entity_SetFriction.md) | Method | sets the entity physics friction |
| [SetFog](Entity_SetFog.md) | Method | controls whether distance fog affects the entity |
| [SetHidden](Entity_SetHidden.md) | Method | hides or shows the entity |
| [SetInput](Entity_SetInput.md) | Method | handles controls for player movement |
| [SetMass](Entity_SetMass.md) | Method | sets the entity physical mass |
| [SetMaterial](Entity_SetMaterial.md) | Method | applies a material to the entity |
| [SetMatrix](Entity_SetMatrix.md) | Method | sets the entity 4x4 matrix |
| [SetNavObstacle](Entity_SetNavObstacle.md) | Method | controls whether the entity interacts with navigation meshes |
| [SetParent](Entity_SetParent.md) | Method | parents one entity to another |
| [SetPhysicsMode](Entity_SetPhysicsMode.md) | Method | sets the entity physics behavior |
| [SetPosition](Entity_SetPosition.md) | Method | sets the entity position in local or global space |
| [SetRotation](Entity_SetRotation.md) | Method | sets the entity rotation in local or global space |
| [SetScale](Entity_SetScale.md) | Method | sets the entity scale |
| [SetShadows](Entity_SetShadows.md) | Method | determines whether the entity casts a shadow |
| [SetVelocity](Entity_SetVelocity.md) | Method | sets the entity linear velocity |
| [Staticize](Entity_Staticize.md) | Method | permanently makes an entity static |
| [Sync](Entity_Sync.md) | Method | resets rendering interpolation |
| [Translate](Entity_Translate.md) | Method | translates the entity position in local or global space |
| [Turn](Entity_Turn.md) | Method | turns the entity in local or global space |
| [UpdateBounds](Entity_UpdateBounds.md) | Method | updates the entity bounding boxes |

















