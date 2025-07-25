# CreateTreeView

The treeview widget displays a hierarchy of nodes that can be selected, opened and closed, double-clicked, and moved. The [Widget::AddNode](Widget_AddNode.md) method is used to add nodes to the tree hierarchy.

When a new node is selected the WIDGETSELECT event will be emitted, with the treeview node stored in the event extra member. When a node is double-clicked, a WIDGETACTION event will be emitted, with the treeview node stored in the event extra member.

If the DRAGANDDROP style is used, the widget will emit a WIDGETDROP event when a node is dragged onto another node, with the source node as the event source and the destination node stored in the event extra member. If the DRAGINSERT style is also used, the event data member will be set to 0 when the node is dropped onto another node, -1 when it is dropped above it, and 1 when it is dropped below it.

If the MULTISELECT style is used, the user can select multiple nodes in the tree at once by holding using the control or shift keys when clicking.

The SORT style can be used to automatically sort treeview nodes alphabetically.

## Syntax

- [Widget](Widget.md) **CreateTreeView**(number x, number y, number width, number height, [Widget](Widget.md) parent)
- [Widget](Widget.md) **CreateTreeView**(number x, number y, number width, number height, [Widget](Widget.md) parent, number style)

| Parameter | Description |
| --- | --- |
| x | widget X position |
| y | widget Y position |
| width | widget width |
| height | widget height |
| parent | parent widget |
| style | treeview style, can be any combination of TREEVIEW_MULTISELECT, TREEVIEW_DRAGANDDROP, TREEVIEW_SORT, and TREEVIEW_DRAGINSERT |

## Example

![CreateTreeView](https://github.com/Leadwerks/Documentation/raw/master/Images/CreateTreeView.png)

```lua
-- Get the displays
local displays = GetDisplays()

-- Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[1], WINDOW_TITLEBAR | WINDOW_RESIZABLE | WINDOW_CENTER)

-- Create User Interface
local ui = CreateInterface(window)

-- Create widget
local sz = ui.background:ClientSize()
local treeview = CreateTreeView(10, 10, sz.x - 20, sz.y - 20, ui.background, TREEVIEW_DRAGANDDROP | TREEVIEW_DRAGINSERT)
treeview:SetLayout(1, 1, 1, 1);

local node = treeview.root:AddNode("Node 1")
node:AddNode("Subnode 1")
node:AddNode("Subnode 2")
node:AddNode("Subnode 3")

node = treeview.root:AddNode("Node 2")
node:AddNode("Subnode 1")
node:AddNode("Subnode 2")
node:AddNode("Subnode 3")

node = treeview.root:AddNode("Node 3")
node:AddNode("Subnode 1")
node:AddNode("Subnode 2")
node:AddNode("Subnode 3")

while true do
    local event = WaitEvent()
    if event.id == EVENT_WIDGETSELECT then
        if event.source == treeview and event.data == 1 then
            local node = Widget(event.extra)
            print("Selected: " .. node.text)
        end
    elseif event.id == EVENT_WIDGETACTION then
        if event.source == treeview then
            local node = Widget(event.extra)
            print("Action: " .. node.text)
            if #node.kids > 0 then
                if node:Collapsed() then
                    node:Expand()
                else
                    node:Collapse()
                end
            end
        end
    elseif event.id == EVENT_WIDGETDROP then
        local child = event.source:AsWidget()
        local parent = event.extra:AsWidget()
        child:SetParent(parent, event.data)
    elseif event.id == EVENT_WINDOWCLOSE then
        return 0
    end
end
```
