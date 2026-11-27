# Entity:ProcessEvent

If it is present, this user-defined function will be called when an event is triggered that is listened for with the [Subscribe](Entity_Subscribe.md) command.

## Syntax

- bool **ProcessEvent**([Event](Event.md) event)

| Parameter | Description |
|---|---|
| event | event to respond to |

## Returns

Returns true if the event system should continue triggering listeners for this event, otherwise false should be returned.
