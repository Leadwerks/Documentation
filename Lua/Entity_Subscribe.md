# Entity:Subscribe

This function sets a callback function that will be executed when an event occurs.

## Syntax

- **Subscribe**(number id, [Widget](Widget.md) source, function callback, [Object](Object.md) extra = nil)

| Parameter | Description |
|---|---|
| id | event ID to listen for, or EVENT_NONE to listen for all events |
| source | event source to listen for, or nil for events emitted from any source |
| callback | function to call when event is triggered |
| extra | extra object to pass to the callback function |

## Remarks

Internally, this function will store a weak pointer to the event source and a shared pointer to the extra field.

If the callback function returns false no more callbacks will be executed and no event will be added to the event queue.
