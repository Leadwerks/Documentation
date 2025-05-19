# Widget.SetShape

This method sets the widget position and height.

## Syntax

- void **SetShape**(int x, int y, int width, int height)
- void **SetShape**([iVec2](iVec2.md) position, [iVec2](iVec2.md) size)

| Parameter | Description |
| --- | --- |
| x | X component of the widget position |
| y | Y component of the widget position |
| width | X component of the widget size |
| height | Y component of the widget size |
| position | widget position to set |
| size | widget size to set |

## Example

```csharp
using UltraEngine;

class Program
{
    static void Main(string[] args)
    {
        //Get the displays
        var displays = GetDisplays();

        //Create a window
        var window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[0]);

        //Create User Interface
        var ui = CreateInterface(window);
        var sz = ui.root.ClientSize();

        //Create widget
        var panel = CreatePanel(50, 50, sz.x - 100, sz.y - 100, ui.root);
        panel.SetColor(0, 0, 0, 1);

        //Set the shape
        panel.SetShape(10, 10, 200, 200);

        while (true)
        {
            var ev = WaitEvent();
            switch (ev.id)
            {
                case EVENT_WINDOWCLOSE:
                    return 0;
                    break;
            }
        }
        return 0;
    }
}
```