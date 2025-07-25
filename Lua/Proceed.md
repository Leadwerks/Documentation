# Proceed

This function displays a message dialog box with the options "Yes", "No", and "Cancel".

## Syntax

- number **Proceed**([string](https://www.lua.org/manual/5.4/manual.html#6.4) message)
- number **Proceed**([string](https://www.lua.org/manual/5.4/manual.html#6.4) message, [string](https://www.lua.org/manual/5.4/manual.html#6.4) title)
- number **Proceed**([string](https://www.lua.org/manual/5.4/manual.html#6.4) message, [string](https://www.lua.org/manual/5.4/manual.html#6.4) title, boolean serious)

| Parameter | Description |
| --- | --- |
| message | text for the message dialog box to display |
| title | title for the message dialog box to display |
| serious | if set to true the dialog box will display a warning icon |

## Returns

If the user pressed the Yes button 1 is returned. If the user presses the cancel button 0 is returned. If the user presses the No button -1 is returned.

## Example

![](https://github.com/Leadwerks/Documentation/raw/master/Images/Proceed.png)

```lua
Print(Proceed("Do you wish to continue?", "Title", true))
```
