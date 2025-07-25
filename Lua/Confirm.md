# Confirm

This function displays a message dialog box with the options "OK" and "Cancel".

[![](https://github.com/Leadwerks/Documentation/raw/master/Images/Confirm.png)](https://github.com/Leadwerks/Documentation/raw/master/Images/Confirm.png)

## Syntax

- int **Confirm**([string](https://www.lua.org/manual/5.4/manual.html#6.4) message)
- int **Confirm**([string](https://www.lua.org/manual/5.4/manual.html#6.4) message, [string](https://www.lua.org/manual/5.4/manual.html#6.4) title)
- int **Confirm**([string](https://www.lua.org/manual/5.4/manual.html#6.4) message, [string](https://www.lua.org/manual/5.4/manual.html#6.4) title, boolean serious)

| Parameter | Description |
| --- | --- |
| message | text for the message dialog box to display |
| title | title for the message dialog box to display |
| serious | if set to true the dialog box will display a warning icon |

## Returns

If the user pressed the OK button 1 is returned. If the user presses the cancel button 0 is returned.

## Example

```lua
Print(Confirm("Are you sure you want to do that?", "Title", true))
```
