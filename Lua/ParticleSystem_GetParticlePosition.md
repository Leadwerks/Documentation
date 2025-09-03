# ParticleSystem::GetParticlePosition

This method returns the position of the particle after the most recent call to [World::Update](World_Update.md).

## Syntax

- [Vec3](Vec3.md) **GetParticlePosition**(number index)

## Remarks

Particle physics are updated asynchronously. A call to [ParticleSystem::SetParticlePosition](ParticleSystem_SetParticlePosition) will have no immediate effect on the return value of this method.
