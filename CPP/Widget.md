# Widget

Base class: [Object](Object.md)

This class handle user interface elements. A variety of widget types are supported. You can also create [custom widgets](CustomWidgets.md) by extending this class.

| Property | Type | Description |
|---|---|---|
| blocks | vector<shared_ptr<[WidgetBlock](WidgetBlock.md)\> \> | read-only container of widget blocks |
| items | std::vector<[WidgetItem](WidgetItem.md)> | read-only items list |
| kids | vector<shared_ptr<[Widget](Widget.md)\> \> | read-only container of child widgets |
| size | [iVec2](iVec2.md) | read-only widget size |
| text | [WString](WString.md) | read-only widget text |
| [AddBlock](Widget_AddBlock.md) | Method | adds a widget block |
| [AddItem](Widget_AddItem.md) | Method | adds a widget item |
| [AddNode](Widget_AddNode.md) | Method | adds a node to a treeview widget |
| [ClearItems](Widget_ClearItems.md) | Method | removes all widget items |
| [ClientSize](Widget_ClientSize.md) | Method | returns the client area |
| [Disable](Widget_Disable.md) | Method | disable the widget |
| [DoubleClick](Widget_DoubleClick.md) | Method | called when a mouse button is clicked twice in rapid succession
| [Draw](Widget_Draw.md) | Method | called each time the widget is redrawn |
| [Enable](Widget_Enable.md) | Method | enable the widget |
| [GetItemText](Widget_GetItemText.md) | Method | gets the widget item text |
| [GetHidden](Widget_GetHidden.md) | Method | returns the widget visibility |
| [GetInterface](Widget_GetInterface.md) | Method | gets the widget interface |
| [GetParent](Widget_GetParent.md) | Method | returns the widget parent |
| [GetPosition](Widget_GetPosition.md) | Method | gets the button position |
| [GetSelectedItem](Widget_GetSelectedItem.md) | Method | gets the selected widget item |
| [GetSelectedNode](Widget_GetSelectedNode.md) | Method | gets the selected treeview node |
| [GetSize](Widget_GetSize.md) | Method | gets the widget size |
| [GetState](Widget_GetState.md) | Method | gets the widget state |
| [GetText](Widget_GetText.md) | Method | gets the widget text |
| [GetValue](Widget_GetValue.md) | Method | gets a slider's value |
| [GainFocus](Widget_GainFocus.md) | Method | called when the widget is selected |
| [KeyChar](Widget_KeyChar.md) | Method | called when a keyboard character is entered |
| [KeyDown](Widget_KeyDown.md) | Method | called when a keyboard key is pressed |
| [KeyUp](Widget_KeyUp.md) | Method | called when a keyboard key is released |
| [LoseFocus](Widget_LoseFocus.md) |  Method | called when the widget is deselected |
| [MouseDown](Widget_MouseDown.md) |  Method | called when a mouse button is pressed |
| [MouseEnter](Widget_MouseEnter.md) |  Method | called when the mouse cursor enters the active window bounds |
| [MouseLeave](Widget_MouseLeave.md) |  Method | called when the mouse cursor leaves the active window bounds |
| [MouseMove](Widget_MouseMove.md) |  Method | called whenever the mouse moves, with coordinates relative to the active window |
| [MouseUp](Widget_MouseUp.md) |  Method | called when a mouse button is released |
| [MouseWheel](Widget_MouseWheel.md) |  Method | called when the mouse wheel turns |
| [Paint](Widget_Paint.md) | Method | redraws a widget |
| [RemoveItem](Widget_RemoveItem.md) | Method | removes a widget item |
| [SetColor](Widget_SetColor.md) | Method | sets the widget color |
| [SetFontBold](Widget_SetFontBold.md) | Method | sets the widget font weight |
| [SetFontScale](Widget_SetFontScale.md) | Method | sets the widget font scale |
| [SetHidden](Widget_SetHidden.md) | Method | hides or shows the widget |
| [SetIcon](Widget_SetIcon.md) | Method | applies an icon to the widget |
| [SetInteractive](Widget_SetInteractive.md) | Method | applies an icon to the widget |
| [SetItemState](Widget_SetItemState.md) | Method | modifies the item state |
| [SetItemText](Widget_SetItemText.md) | Method | modifies the item text |
| [SetLayout](Widget_SetLayout.md) | Method | controls the way a widget behaves during resizing |
| [SetParent](Widget_SetParent.md) | Method | makes this widget the child of the parent widget |
| [SetPixmap](Widget_SetPixmap.md) | Method | applies a pixmap to the widget |
| [SetProgress](Widget_SetProgress.md) | Method | sets the progress complete for a progress bar widget |
| [SetShape](Widget_SetShape.md) | Method | sets the widget position sna size |
| [SetRange](Widget_SetRange.md) | Method | sets the range of a slider widget |
| [SetState](Widget_SetState.md) | Method | sets the button state |
| [SetText](Widget_SetText.md) | Method | sets the widget text |
| [SetTexture](Widget_SetTexture.md) | Method | applies a texture to a widget in a 3D interface |
| [SetValue](Widget_SetValue.md) | Method | sets the value of a slider |
| [SelectItem](Widget_SelectItem.md) | Method | selects a widget item |
| [SelectNode](Widget_SelectNode.md) | Method | selects a treeview node |
| [TripleClick](Widget_TripleClick.md) |  Method | called when a mouse button is clicked rapidly three times |
| [CreateButton](CreateButton.md) | Function | creates a button widget |
| [CreateComboBox](CreateComboBox.md) | Function | creates a combobox widget |
| [CreateLabel](CreateLabel.md) | Function | creates a label widget |
| [CreateListBox](CreateMenu.md) | Function | creates a listbox widget |
| [CreateMenu](CreateMenu.md) | Function | creates a menu widget |
| [CreatePanel](CreatePanel.md) | Function | creates a panel widget |
| [CreateProgressBar](CreateProgressBar.md) | Function | creates a progress bar widget |
| [CreateSlider](CreateSlider.md) | Function | creates a slider widget |
| [CreateTextArea](CreateTextArea.md) | Function | creates a text area widget |
| [CreateTextField](CreateTextField.md) | Function | creates a text field widget |
| [CreateTreeView](CreateTreeView.md) | Function | creates a treeview widget |
