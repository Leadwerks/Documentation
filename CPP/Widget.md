# Widget

This class handle user interface elements. A variety of widget types are supported. You can also create [custom widgets](CustomWidgets.md) by extending this class.

## Properties

| Name | Type | Description
|---|---|---|
| kids | const vector<shared_ptr<[Widget](Widget.md)\> \>& | read-only list of child widgets |
| size | const [iVec2](iVec2.md)& | read-only widget size |
| text | const [WString](WString.md)& | read-only widget text |
| [AddBlock](Widget_AddBlock.md) | Method | adds a widget block |
| [AddItem](Widget_AddItem.md) | Method | adds a widget item |
| [AddNode](Widget_AddNode.md) | Method | adds a node to a treeview widget |
| [ClearItems](Widget_ClearItems.md) | Method | removes all widget items |
| [ClientSize](Widget_ClientSize.md) | Method | returns the client area |
| [GetItemText](Widget_GetItemText.md) | Method | gets the widget item text |
| [GetParent](Widget_GetParent.md) | Method | returns the widget parent |
| [GetPosition](Widget_GetPosition.md) | Method | gets the button position |
| [GetSelectedItem](Widget_GetSelectedItem.md) | Method | gets the selected widget item |
| [GetSelectedNode](Widget_GetSelectedNode.md) | Method | gets the selected treeview node |
| [GetSize](Widget_GetSize.md) | Method | gets the widget size |
| [GetState](Widget_GetState.md) | Method | gets the widget state |
| [GetText](Widget_GetText.md) | Method | gets the widget text |
| [Paint](Widget_Paint.md) | Method | redraws a widget |
| [RemoveItem](Widget_RemoveItem.md) | Method | removes a widget item |
| [SetColor](Widget_SetColor.md) | Method | sets the widget color |
| [SetFontBold](Widget_SetFontBold.md) | Method | sets the widget font weight |
| [SetFontScale](Widget_SetFontScale.md) | Method | sets the widget font scale |
| [SetIcon](Widget_SetIcon.md) | Method | applies an icon to the widget |
| [SetInteractive](Widget_SetInteractive.md) | Method | applies an icon to the widget |
| [SetItemText](Widget_SetItemText.md) | Method | modifies the item text |
| [SetLayout](Widget_SetLayout.md) | Method | controls the way a widget behaves during resizing |
| [SetParent](Widget_SetParent.md) | Method | makes this widget the child of the parent widget |
| [SetPixmap](Widget_SetPixmap.md) | Method | applies a pixmap to the widget |
| [SetProgress](Widget_SetProgress.md) | Method | sets the progress complete for a progress bar widget |
| [SetShape](Widget_SetShape.md) | Method | sets the widget position sna size |
| [SetState](Widget_SetState.md) | Method | sets the button state |
| [SetText](Widget_SetText.md) | Method | sets the widget color |
| [SelectItem](Widget_SelectItem.md) | Method | selects a widget item |
| [SelectNode](Widget_SelectNode.md) | Method | selects a treeview node |
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
| [CreateTreeView](CreateSlider.md) | Function | creates a treeview widget |
