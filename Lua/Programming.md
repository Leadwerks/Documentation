# Programming with Lua

Lua is a versatile scripting language widely employed in a multitude of games, ranging from popular titles like Angry Birds to complex ones like Call of Duty. Its simplicity and flexibility make it an excellent choice for both novice developers and experienced programmers looking to swiftly bring their ideas to life.

## Using the Integrated Script Editor

The integrated [script editor](scripteditor) is recommended for most users, and doesn't require any additional software to be installed.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/ide.png?raw=true)

If you are using the integrated script editor, the rest of this article does not apply to you,

## Using Visual Studio Code

If you prefer, it is possible to use Visual Studio Code for Lua programming. To begin programming with Lua and Visual Studio Code, follow these steps:

1. **Install Visual Studio Code:** Lua development for Ultra Engine is most convenient when using Visual Studio Code. If you don't have it installed, you can download it from [Visual Studio Code](https://code.visualstudio.com).

2. **Open Your Ultra Engine Lua Project:**
   - Locate the batch file named "Open in VSCode.bat" within your Ultra Engine project directory.
   - Double-click this file to open your project in Visual Studio Code.

![Open in VSCode](https://github.com/UltraEngine/Documentation/blob/master/Images/vscode.png?raw=true)

3. **Install the Lua Debugger Addon:**
   - If you haven't installed the Lua debugger addon already, Visual Studio Code will prompt you to download it. You can find this addon on the [Visual Studio Code Marketplace](https://marketplace.visualstudio.com/items?itemName=devCAT.lua-debug).
   - Installing this addon is essential for debugging Ultra Engine games developed with Lua.

4. **Configure Debugging Options:**
   - For effective Lua debugging, enable the "Allow Breakpoints Everywhere" option in Visual Studio Code's settings.
     - Navigate to *User > Features > Debug* settings to make this adjustment.

![Breakpoints Configuration](https://github.com/UltraEngine/Documentation/blob/master/Images/breakpoints.png?raw=true)

## Running Your Game

Once your development environment is set up, you can run your Ultra Engine Lua game by following these steps:

1. **Run Your Game:**
   - Press the F5 key within Visual Studio Code to launch your Ultra Engine Lua game.

2. **Explore Example Projects:**
   - If you want to see a working example, you can copy code from [our documentation](https://www.ultraengine.com/learn/LoadModel?lang=lua) and paste it into the *Source/main.lua* file in your project to see it in action.

## Trouble Shooting

If you see an error that says "Missing 'program' to debug" it is probably because you have the [actboy168.lua-debug](https://marketplace.visualstudio.com/items?itemName=actboy168.lua-debug) extension installed. You can uninstall the extension, or disable it for this workspace.

If you see an error that says "The code execution cannot proceed because MSVCP140D.dll was not found. Reinstalling the program may fix the error", this means the [Visual Studio redistributable](https://aka.ms/vs/17/release/vc_redist.x64.exe) has not been installed.
