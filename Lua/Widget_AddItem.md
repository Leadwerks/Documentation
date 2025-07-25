# Widget:AddItem

This function adds an item to any widget that displays a list of items.

## Syntax

- number **AddItem**([string](https://www.lua.org/manual/5.4/manual.html#6.4) text)
- number **AddItem**([string](https://www.lua.org/manual/5.4/manual.html#6.4) text, boolean selected)

| Parameter | Description |
|---|---|
| text | the text for the widget item |
| selected | if set to true the item will be selected |

## Returns

Returns the index of the new widget item.

## Example 

```lua
--Get the displays
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[1])

--Create User Interface
local ui = CreateInterface(window)

--Create widget
local sz = ui.background:GetSize()
local listbox = CreateListBox(20, 20, sz.x - 40, sz.y - 40, ui.background)
listbox:AddItem("Item 1", true)
listbox:AddItem("Item 2")
listbox:AddItem("Item 3")
listbox:AddItem("Item 4")
listbox:AddItem("Item 5")
listbox:AddItem("Item 6")

while true do
    local ev = WaitEvent()
    if ev.id == EVENT_WINDOWCLOSE then
        return 0
    end
end
```
