# Notify

This function displays a message box.

## Syntax

- **Notify**([string](https://www.lua.org/manual/5.4/manual.html#6.4) message)
- **Notify**([string](https://www.lua.org/manual/5.4/manual.html#6.4) message, [string](https://www.lua.org/manual/5.4/manual.html#6.4) title)
- **Notify**([string](https://www.lua.org/manual/5.4/manual.html#6.4) message, [string](https://www.lua.org/manual/5.4/manual.html#6.4) title, boolean serious)

| Parameter | Description |
| ----- | ----- |
| message | message to display in the message box |
| title | optional title of the message box window | 
| serious | If set to true a warning icon will be displayed |

## Example

![](https://github.com/Leadwerks/Documentation/raw/master/Images/Notify.png)

```lua
Notify("Hello, world!", "Title", true)
```
