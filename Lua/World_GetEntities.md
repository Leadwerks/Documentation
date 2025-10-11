# World:GetEntities

This method returns an array of all entities in the world, with optional filter parameters.

- array **GetEntities**()
- array **GetEntities**(string field, string operation, value...)

| Property | Description |
|---|---|
| field | the name of a field to check |
| operation | the operation to perform. This can be set to "==", "~=", "<", ">", "<=", or ">="
| value | the value to compare the entity field value to |

# Remarks

You can provide any number of arguments, in sets of three. Each three arguments will be used to test the values attached to an entity, using the specified operation.

For example, if you wanted to retrieve all entities in the world with a health value greater than zero, you would do this:
```lua
world:GetEntities("health", ">", 0)
```

If you wanted to retrieve all entities in the world with a health value greater than zero, that were carrying a weapon, you would do this:
```lua
world:GetEntities("health", ">", 0, "weapon", "~=", nil)
```

