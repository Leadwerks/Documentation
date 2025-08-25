# Custom Widgets

You can create new types of widgets in C++ by extending the base [Widget](Widget.md) class. The widget's behavior is controlled by overriding the Widget class methods. Drawing is accomplished by adding WidgetBlock objects to the blocks member.

The following methods can be overridden to control custom widget behavior:

| Name | Description |
|---|---|
| [Draw](Widget_Draw.md) | called each time the widget is painted |
| [DoubleClick](Widget_DoubleClick.md) | called when a mouse button is clicked twice in rapid succession |
| [GainFocus](Widget_GainFocus.md) | called when the widget is selected |
| [KeyChar](Widget_KeyChar.md) | called when a keyboard character is entered |
| [KeyDown](Widget_KeyDown.md) | called when a keyboard key is pressed |
| [KeyUp](Widget_KeyUp.md) | called when a keyboard key is released |
| [LoseFocus](Widget_LoseFocus.md) | called when the widget is deselected |
| [MouseDown](Widget_MouseDown.md) | called when a mouse button is pressed |
| [MouseEnter](Widget_MouseEnter.md) | called when the mouse cursor enters the active window bounds |
| [MouseLeave](Widget_MouseLeave.md) | called when the mouse cursor leaves the active window bounds |
| [MouseMove](Widget_MouseMove.md) | called whenever the mouse moves, with coordinates relative to the active window |
| [MouseUp](Widget_MouseUp.md) | called when a mouse button is released |
| [MouseWheel](Widget_MouseWheel.md) | called when the mouse wheel turns |
| [TripleClick](Widget_TripleClick.md) | called when a mouse button is clicked rapidly three times |

## Example

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

//Declare new style constants
enum CustomWidgetStyle
{
    CUSTOMWIDGET_DEFAULT = 0
};

//Declare new widget class
class CustomWidget : public Widget
{
    //Custom members
    bool hover;

protected:

    virtual bool Initialize(const WString& text, const int x, const int y, const int width, const int height, shared_ptr<Widget> parent, const int style)
    {
        return Widget::Initialize(text, x, y, width, height, parent, style);
    }

    //Called when the mouse moves if this widget has the focus
    virtual void MouseMove(const int x, const int y) {}

    //Called when the mouse cursor enters the widget bounds
    virtual void MouseEnter(const int x, const int y)
    {
        hover = true;
        Redraw();
    }

    //Called when the mouse cursor leaves the widget bounds
    virtual void MouseLeave(const int x, const int y)
    {
        hover = false;
        Redraw();
    }

    //Called when the mouse button is pressed
    virtual void MouseDown(const MouseButton button, const int x, const int y)
    {
        if (button == MOUSE_LEFT) EmitEvent(EVENT_WIDGETACTION, Self());
    }

    //Called when the mouse button is released
    virtual void MouseUp(const MouseButton button, const int x, const int y) {}

    //Called when another widget becomes selected
    virtual void LoseFocus() {}

    //Called when mouse double-click occurs
    virtual void DoubleClick(const MouseButton button, const int x, const int y) {}

    //Called when mouse triple-click occurs
    virtual void TripleClick(const MouseButton button, const int x, const int y) {}

    //Called when widget is selected
    virtual void GainFocus() {}

    //Called when key is pressed
    virtual bool KeyDown(const KeyCode key) { return false; }

    //Called when key is released
    virtual void KeyUp(const KeyCode key) {}

    //Called for each keydown event
    virtual void KeyChar(const int keychar) {}

    //Called when mouse wheel turns and mouse is hovered over this widget
    virtual void MouseWheel(const int delta, const int x, const int y) {}

    //Called each time the widget is redrawn
    virtual void Draw(const int x, const int y, const int width, const int height)
    {
        blocks.clear();
        Vec4 color = Vec4(1, 0, 0, 1);
        if (hover) color = Vec4(0, 1, 0, 1);

        //Background rectangle
        AddBlock(iVec2(0), this->size, color);

        //Foreground text
        AddBlock(text, iVec2(0), this->size, Vec4(1), TEXT_CENTER | TEXT_MIDDLE);
    }
public:

    //Constructor
    CustomWidget() : hover(false)
    {}

    friend shared_ptr<Widget> CreateCustomWidget(const WString&, const int, const int, const int, const int, shared_ptr<Widget>, const CustomWidgetStyle);
};

//Create function
shared_ptr<Widget> CreateCustomWidget(const WString& text, const int x, const int y, const int width, const int height, shared_ptr<Widget> parent, const CustomWidgetStyle style)
{
    auto widget = std::make_shared<CustomWidget>();
    widget->Initialize(text, x, y, width, height, parent, style);
    return widget;
}

int main(int argc, const char* argv[])
{
    //Get the displays
    auto displays = GetDisplays();

    //Create a window
    auto window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[0]);

    //Create User Interface
    auto ui = CreateInterface(window);

    //Create widget
    auto widget = CreateCustomWidget("Custom", 20, 20, 120, 36, ui->root, CUSTOMWIDGET_DEFAULT);

    while (true)
    {
        const Event ev = WaitEvent();
        switch (ev.id)
        {
        case EVENT_WIDGETACTION:
            Print("Widget action: " + String(ev.data));
            break;
        case EVENT_WINDOWCLOSE:
            return 0;
            break;
        }
    }
    return 0;
}
```
