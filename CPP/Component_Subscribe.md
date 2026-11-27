# Component::Subscribe

This method adds a listener that will call the [ProcessEvent](Component_ProcessEvent.md) method when the specified event occurs.

## Syntax

- void **Subscribe**(const EventId id, shared_ptr<[Widget](Widget.md)\> source),  shared_ptr<[Object](Object.md)\> extra = NULL)

| Parameter | Description |
|---|---|
| id | event ID to listen for, or EVENT_NONE to listen for all events |
| source | event source to listen for, or NULL for events emitted from any source |
| callback | function to call when event is triggered |
| extra | extra object to pass to the callback function |
