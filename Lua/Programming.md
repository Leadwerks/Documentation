# Programming with Lua

www.youtube.com/watch?v=1hLvEjr0z2U

Lua is a fun and easy scripting language widely employed in a variety of games, ranging from popular titles like Angry Birds to Call of Duty. Its simplicity and flexibility make it an excellent choice for both novice developers and experienced programmers looking to swiftly bring their ideas to life.

## Using the Integrated Script Editor

The integrated [script editor](scripteditor.md) is recommended for most users, and doesn't require any additional software to be installed. The script editor will open any time you double-click on a code file in the [project panel](assetbrowser.md), or you can select the **Scripting > Script Editor** item in the main menu.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/ide.png?raw=true)

The [programming reference](https://www.leadwerks.com/learn/LoadModel?lang=lua) includes examples for most commands. To run an example, just copy the code from the example section of the page, and paste it into the file Source\Main.lua, overwriting its contents.

If you are using the integrated script editor, you do not need to read the rest of this article, and you can proceed to the first Lua programming tutorial.

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
