# World::Pick #
This method performs a raycast on the world.

## Syntax ##
- bool Pick(const double x0, const double y0, const double z0, const double x1, const double y1, const double z1, PickInfo& pick, const double radius = 0.0, const bool closest = false, const CollisionType collisiontype = COLLISION_NONE)
- bool Pick(const [dVec3](dVec3.md)& p0, const [dVec3](dVec3.md)& p1, PickInfo& pick, const double radius = 0.0, const bool closest = false, const CollisionType collisiontype = COLLISION_NONE)

### Parameters ###
|   |   |
| --- | --- |
| **x0** | x component of the ray start position |
| **y0** | y component of the ray start position |
| **z0** | z component of the ray start position |
| **x1** | x component of the ray end position |
| **y1** | y component of the ray end position |
| **z1** | z component of the ray end position |
| **p0** | ray start position, in local space |
| **p1** | ray end position, in local space |
| **pickinfo** | structure containing information about the ray intersection result |
| **radius** | if greater than zero a swept sphere intersection test will be performed |
| **closest** | if set to true the closest intersected point will be found, otherwise the routine will return on the first hit |
| **recursive** | if set to true the entity subhierarchy will be tested |
| **collisiontype** | optional collision type filter |

## Returns ##
Returns true if the ray intersects any objects, otherwise false is returned.