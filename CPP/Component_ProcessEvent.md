# Component::ProcessEvent

This method can be overridden to respond to events listened for with the [Listen](Component_Subscribe.md) method.

## Syntax

- bool **ProcessEvent**(const [Event](Event)& event)

| Parameter | Description |
|---|---|
| event | event to respond to |

## Returns

Return true if the event system should continue calling event listeners and add the event to the event queue retrieved by [WaitEvent](WaitEvent), otherwise false should be returned.
