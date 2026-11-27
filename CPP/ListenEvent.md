# ListenEvent

This function sets a callback function that will be executed when an event occurs.

## Syntax

- void **ListenEvent**(const EventId id, shared_ptr<[Object](Object.md)\> source, bool callback(const [Event](Event.md)& event, shared_ptr<[Object](Object.md)\> extra),  shared_ptr<[Object](Object.md)\> extra = NULL)

| Parameter | Description |
|---|---|
| id | event ID to listen for, or EVENT_NONE to listen for all events |
| source | event source to listen for, or NULL for events emitted from any source |
| callback | function to call when event is triggered |
| extra | extra object to pass to the callback function |

## Remarks

Internally, this function will store a weak pointer to the event source and a shared pointer to the extra field.

If the callback function returns false no more callbacks will be executed and no event will be added to the event queue.

## Example

The first example shows another way to quit the program when the window is closed:

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

bool EventCallback(const Event& ev, shared_ptr<Object> extra)
{
    exit(0);
}

int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = GetDisplays();

    //Create window
    auto window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[0]);

    //Create user interface
    auto ui = CreateInterface(window);

    ListenEvent(EVENT_WINDOWCLOSE, window, EventCallback);

    while (true)
    {
        WaitEvent();
    }
    return 0;
}
```

The example below demonstrates how an event listener can be used for custom resizing behavior:

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

bool EventCallback(const Event& ev, shared_ptr<Object> extra)
{
    auto panel = extra->As<Widget>();
    iVec2 sz = panel->GetParent()->ClientSize();
    panel->SetShape(50, 50, sz.x - 100, sz.y - 100);
    panel->SetText(String(sz.x) + " x " + String(sz.y));
    return true;
}

int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = GetDisplays();

    //Create window
    auto window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[0], WINDOW_TITLEBAR | WINDOW_RESIZABLE);

    //Create user interface
    auto ui = CreateInterface(window);
    iVec2 sz = ui->root->ClientSize();
    auto panel = CreatePanel(50, 50, sz.x - 100, sz.y - 100, ui->root);
    panel->SetColor(0, 0, 0);

    //Comment this line out to see why it is needed. ;)
    ListenEvent(EVENT_WINDOWSIZE, window, EventCallback, panel);

    while (true)
    {
        const Event ev = WaitEvent();
        switch (ev.id)
        {
        case EVENT_WINDOWCLOSE:
            if (ev.source == window) return 0;
            break;
        case EVENT_WINDOWSIZE:
            sz = panel->GetParent()->ClientSize();
            panel->SetShape(50, 50, sz.x - 100, sz.y - 100);
            panel->SetText(String(sz.x) + " x " + String(sz.y));
            break;
        }
    }
    return 0;
}
```
