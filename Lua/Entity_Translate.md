# Entity:Translate

This method repositions an entity relative to its parent orientation.

## Syntax

- **Translate**(number x, number y, number z, boolean global = true)
- **Translate**([xVec3](xVec3.md) translation, boolean global = true)

| Parameter | Description |
|---|---|
| translation, (x, y, z) | movement to apply to the entity |
| global | if set to false movement occurs relative to the parent space, otherwise world space is used |
