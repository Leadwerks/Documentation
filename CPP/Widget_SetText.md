# Widget::SetText

This method sets the widget text.

## Syntax

-void **SetText**(const [WString](WString.md) text)

| Parameter | Description |
| --- | --- |
| text | widget text to set |

## Example

```c+++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = GetDisplays();

    //Create a window
    auto window = CreateWindow("Ultra Engine", 0, 0, 640, 480, displays[0]);

    //Create User Interface
    auto ui = CreateInterface(window);

    //Create widget
    auto sz = ui->root->ClientSize();
    auto textarea = CreateTextArea(10, 10, sz.x - 20, sz.y - 20, ui->root, TEXTAREA_WORDWRAP);

    WString s = L"Night was falling now, and as I recalled what Akeley had written me about those earlier nights \
I shuddered to think there would be no moon. Nor did I like the way the farmhouse nestled in the lee of that\
colossal forested slope leading up to the Dark Mountain’s unvisited crest. With Akeley’s permission I lighted a small oil lamp,\
 turned it low, and set it on a distant bookcase beside the ghostly bust of Milton; but afterward I was sorry I had done so, for \
it made my host’s strained, immobile face and listless hands look damnably abnormal and corpselike. He seemed half-incapable of motion, \
though I saw him nod stiffly once in a while.";

    textarea->SetText(s);

    while (true)
    {
        const Event ev = WaitEvent();
        switch (ev.id)
        {
        case EVENT_WINDOWCLOSE:
            return 0;
            break;
        }
    }
    return 0;
}
```
