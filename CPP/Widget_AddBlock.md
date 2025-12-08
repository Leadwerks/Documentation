# Widget::AddBlock

This method adds a [WidgetBlock](WidgetBlock.md) to a custom widget, for displaying a rectangle, image, or text. Generally, this method will be called inside the Draw method of a custom class derived from the [Widget](Widget.md) class.

## Syntax

- int **AddBlock**(const [iVec2](iVec2)& position, const [iVec2](iVec2)& size, const [Vec4](Vec4)& color = [Vec4](Vec4)(0), const bool wireframe = false, const float radius = 0.0f, const float gradient = 1.0f);
- int **AddBlock**(const [WString](WString.md)& text, const [iVec2](iVec2)& position, const [iVec2](iVec2)& size, const [Vec4](Vec4)& color, const TextAlignment alignment = 0);
- int **AddBlock**(shared_ptr<[Icon](Icon.md)> icon, const [iVec2](iVec2)& position, const float scale = 1.0f, const [Vec4](Vec4)& color = 1.0f);
- int **AddBlock**(shared_ptr<[Pixmap](Pixmap.md)> pixmap, const [iVec2](iVec2)& position, const [Vec4](Vec4)& color = 1.0f);

## Parameters

| Name | Description |
|---|---|
| position | screen coordinates of the block within the widget |
| size | width and height of the block clipping region |
| color | block color |
| wireframe | if set to true a rectangle outline will be drawn, otherwise a filled rectangle is drawn |
| radius | for rounded rectangles, radius of the corners |
| gradient | color multiplier for vertical gradient |
| text | text to display |
| alignment | text alignment, can be any combination of TEXT_LEFT, TEXT_CENTER, or TEXT_RIGHT and TEXT_TOP, TEXT_MIDDLE, and TEXT_BOTTOM
| icon | icon to display |
| scale | icon scale, independent from DPI scaling |
| pixmap | pixmap to display 

## Returns
Returns the index of the new widget block.

## Example

```c++
#include "Leadwerks.h"

using namespace Leadwerks;

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

    // Initialize the widget
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
    {
    }

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
    auto window = CreateWindow("Leadwerks", 0, 0, 800, 600, displays[0]);

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
