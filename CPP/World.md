# World

Base class: [Object](Object.md)

The world class is a container for entities.

| Property | Type | Description |
|---|---|---|
| animationstats     | [AnimationStats](AnimationStats.md)    | animation system statistics                                                  |
| collisions | const vector<[Collision](Collision.md)\>& | read-only list of collisions recorded in previous physics update |
| frequency | const int& | read-only update frequency |
| physicsstats | [PhysicsStats](PhysicsStats.md) | physics statistics |
| renderstats | [RenderStats](RenderStats.md) | rendering statistics |
| [ClearCollisionResponses](World_ClearCollisionResponses.md) | Method | clears all collision responses |
| [GetAmbientLight](World_GetAmbientLight.md) | Method | returns the ambient light color |
| [GetCollisionResponse](World_GetCollisionResponse.md) | Method | returns the collision response for collisions between the specified collision types |
| [GetEntitiesInArea](World_GetEntitiesInArea.md) | Method | returns an array of entities that intersect the specified bounding box |
| [GetTaggedEntities](World_GetTaggedEntities.md) | Method | returns an array of entities with the specified tag |
| [GetTime](World_GetTime.md)           | Method                          | returns the current time for this frame             |
| [Pick](World_Pick.md) | Method | performs a raycast |
| [RecordStats](World_RecordStats.md) | Method | enables statistics recording |
| [Render](World_Render.md) | Method | renders the world |
| [SetAmbientLight](World_SetAmbientLight.md) | Method | sets the ambient light color |
| [SetCollisionResponse](World_SetCollisionResponse.md) | Method | sets the collision response for collisions between the specified collision types |
| [SetEnvironmentMap](World_SetEnvironmentMap.md) | Method | sets the skybox or specular and diffuse reflection maps |
| [SetGravity](World_SetGravity.md) | Method | sets the world gravity force |
| [SetIblIntensity](World_SetIblIntensity.md) | Method | adjusts the strength of environment map reflections |
| [Update](World_Update.md) | Method | updates physics, pathfinding, and other systems |
| [CreateWorld](CreateWorld.md) | Function | creates a new world |
