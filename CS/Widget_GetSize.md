# Widget.GetSize

This method returns the dimensions of the widget. To retrieve the area inside the widget excluding any padding, use the [ClientSize](Widget_ClientSize.md) method.

## Syntax

- [Vector2](iVec2.md) **GetSize**()

## Returns

Returns the widget size.

## Example

```csharp
using System;
using UltraEngine;

public class Program
{
    public static void Main(string[] args)
    {
        // Get the displays
        var displays = GetDisplays();

        // Create a window
        var window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[0], WINDOW_TITLEBAR | WINDOW_RESIZABLE);

        // Create User Interface
        var ui = CreateInterface(window);
        var sz = ui.root.ClientSize();

        // Create widget
        var panel = CreatePanel(50, 50, sz.x - 100, sz.y - 100, ui.root, PANEL_BORDER);
        panel.SetLayout(1, 1, 1, 1);

        sz = panel.ClientSize();
        var label = CreateLabel("", 0, 0, sz.x, sz.y, panel, LABEL_CENTER | LABEL_MIDDLE);
        label.SetLayout(1, 1, 1, 1);

        while (true)
        {
            var ev = WaitEvent();
            switch (ev.id)
            {
                case EVENT_WINDOWCLOSE:
                    return;
                case EVENT_WINDOWSIZE:
                    sz = panel.GetSize();
                    label.SetText(sz.x.ToString() + " x " + sz.y.ToString());
                    break;
            }
        }
    }
}
```