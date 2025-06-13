# Script Editor

The integrated script editor allows editing of code and shader files. The window has a tabbed interface for viewing multiple code files.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/ide.png?raw=true)

The interface is divided into the following areas:

## Toolbar

The toolbar contains buttons for frequently performed actions.

## Code Area

Most of the interface is dedicated to a tabbed panel that can display multiple code files.

## Side Panel

The right-side panel provides an area for Lua debugging information, when the debugger is being used.

## Bottom Panel

The bottom panel provides a tabbed interface showing the printed output when the game is run, as well as a list of any errors that occur while running the game.

## Running the Game

You can run the game by selecting the **Game > Run** menu item, or by pressing the run button in the toolbar.

## Game Configurations

If you press the arrow on the right side of the control, a dropdown list will be shown, allowing you to select the game configuration you want to run.

C++ games have the following options:
- Release
- Debug

Lua games have the following options:
- Release
- Debug
- Fast Debug

The fast debug option for Lua will run the Lua debugger with the release build of the game executable, which executes Lua code much faster than the debug build, and it will catch most (though not all) bugs.

## Debugging

To use the debugger with a Lua game, set a breakpoint by clicking in the gutter to the left the code area, in a Lua code file. When the game is run with the Debug or Fast Debug configuration select, it will pause when the breakpoint is hit. The debug panel on the right will then display all the variables in use in your game.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/breakpoint.png?raw=true)

You can press the **Continue** toolbar button to resume execution of the program, or use the **Step**, **Step In**, and **Step Out** buttons to proceed through your code one line at a time, pausing each time.

Breakpoints can be set and removed while the game is running.
