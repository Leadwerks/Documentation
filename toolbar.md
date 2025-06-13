# Toolbar

The Toolbar is a dynamic control center that provides quick access to some of the most commonly used functions within the program. It's designed for user convenience and efficient workflow. Here's a detailed breakdown of its features and functions:

![](https://github.com/UltraEngine/Documentation/blob/master/Images/toobar.png?raw=true)

## File Operations

On the left side of the Toolbar, you'll find standard file operations, including:

- **New**: Create a new project or scene.
- **Open**: Load an existing map into the editor.
- **Save**: Save your current project or scene, ensuring that your progress is preserved.
- **Undo and Redo**: These buttons allow you to reverse or redo recent actions, helping you navigate through your editing history.

## Edit Operations

The next group contains buttons for common editing operations.

- **Cut**: Removes and copies the selected objects.
- **Copy**: Copies the selected objects, but leaves them intact.
- **Paste**: Creates a new instance of any previously copied objects.
- **Delete**: Removes the selected objects from the scene.

## Undo Operations

The next group contains buttons to undo and redo the last editing step. These buttons will be disabled if the current state of the program does not allow the operation, for example, if it is a new scene and nothing has been created yet.

## Zoom Operations

The next group contains buttons to zoom in and out in the current viewport.

## Object Button

The object button is a special control used to activate the object creation tool and select an object to make.

When you click the arrow on the left side of the button, or just click the button when it is already in the selected state, a panel will appear below showing all the objects you can create.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/objectpanel.png?raw=true)

## Rotation Operations

The next group of buttons can be used to rotate all selected objects around the X, Y, or Z axes. If a single object is select, it will rotate around its pivot point. If multiple objects are selected, they will rotate around the center of the selection bounds.

## World Settings and Options

The next button group will open the [World Settings](worldsettings.md) and [Options](optionswindow.md) windows.

## Run Game Button

The next toolbar item is another special control, the run game button. You can press the button to launch the game, passing the current scene to the game executable in a command-line parameter. If you press the arrow on the right side of the control, a dropdown list will be shown, allowing you to select the game configuration you want to run.

C++ games have the following options:
- Release
- Debug

Lua games have the following options:
- Release
- Debug
- Fast Debug

The fast debug option for Lua will run the Lua debugger with the release build of the game executable, which executes Lua code much faster than the debug build, and it will catch most (though not all) bugs.

## View Buttons

The next group contains buttons to change the view of the current viewport. You can a perspective view, or an orthographic view on three axes, from any direction.

## Viewport Layout Buttons

The next group contains buttons to change the viewport layout. You can select a layout that displays one, two, three or four viewports. These buttons are ordered by their typical frequency of usage, for convenience.

## Window Layout Buttons

The last group of buttons is aligned to the right side of the toolbar and allows you to quickly show and hide the bottom console and the left-side panel.
