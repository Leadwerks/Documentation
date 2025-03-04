# SetStat

Namespace: [Steamworks](Steamworks.md)

This function sets a user statitics value for this game.

## Syntax

- boolean **SetStat**([string](https://www.lua.org/manual/5.4/manual.html#6.4) key, number value)

| Parameter | Description |
|---|---|
| key | name of user statistic to set |
| value | value to set |

## Returns

Returns true if the user statistic is successfully stored, otherwise false is returned.

## Example

```lua
-- Initialize Steam
if not Steamworks.Initialize() then
    RuntimeError("Steamworks failed to initialize.")
    return
end

-- Retrieve the current value
local value = Steamworks.GetStat("NumWins")
Print(value)

-- Set a new value
Steamworks.SetStat("NumWins", 105)

-- Shutdown Steam
Steamworks.Shutdown()
```
