# GUI

Leadwerks features a robust graphical user interface for creating in-game interfaces and desktop applications.

The first step to creating a GUI is to retrieve the machine's displays (monitors). A window is then created on one display, typically the primary one, which is listed first. An [Interface](Interface.md) object is created on the window, which contains all our user interface elements. One or more [Widgets](Widget.md) are created on the root interface panel. Some widgets may have multiple items added to them with the [Widget::AddItem](Widget_AddItem.md) method.

Widgets and timers are the two object types that may emit events using the [EmitEvent](EmitEvent.md) command. When this is called, the event is first evaluated by any callbacks that have been defined with the [ListenEvent](ListenEvent.md) function. The event is then added to the event queue, where it may be retrieved using the [WaitEvent](WaitEvent.md) command.
