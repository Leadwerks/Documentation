# Widget.ClientSize #
This method returns the dimensions of the drawable area inside a widget, excluding any padding.

## Syntax ##
- [Vector2Int](Vector2Int.md) **ClientSize**()

## Returns ##
Returns the widget client size. This is the area inside the widget with all borders removed, inside which a child widget may be created.

## Example ##
```csharp
using System;
using UltraEngine;

class Program
{
    static void Main(string[] args)
    {
        //Get the displays
        var displays = Engine.GetDisplays();

        //Create a window
        var window = Engine.CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[0]);

        //Create User Interface
        var ui = Engine.CreateInterface(window);
        var sz = ui.root.ClientSize();

        //Create widget
        var panel = Engine.CreatePanel(50, 50, sz.x - 100, sz.y - 100, ui.root);
        panel.SetColor(0, 0, 0, 1);

        while (true)
        {
            var ev = Engine.WaitEvent();
            switch (ev.id)
            {
                case Engine.EVENT_WINDOWCLOSE:
                    return;
            }
        }
    }
}
```