# Debugging

www.youtube.com/watch?v=uVNQvg-xKmg

Sometimes our code doesn't work the way we think it should be working. When that happens there's almost always a good reason for it. It's important that we be able to look at what our program is doing so we can find out what is wrong.  Debugging allows us to do that by pausing the program execution and displaying all the variables in the program, as it's running.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/luadebugging.gif?raw=true)

## Release, Debug, and Fast Debug Modes

A Leadwerks Lua game can be run in one of three modes.  Release mode runs the fastest, and is what we actually use when our game is published.  Debug mode is slower, but contains lots of extra checks and extra information that help while we are developing our game.  Normally we will use debug mode while developing our game, and release mode for testing speed.

The very first time you run a game in debug mode, the message below will be displayed.  This just makes it clear that the user should expect debug mode to run more slowly than release mode.

## Breakpoints

A breakpoint is a place in our code we want to stop at so we can take a look at what's going on inside our program.  We can set a breakpoint in the script editor, by clicking in the gutter next to the text editor.

Note that debugging only works when we run the game in debug mode.  When a game is run in release mode, breakpoints are ignored.
Debugging Your Game

Let's do some debugging.  Create a new scene and add a CSG box to it. Add the ScriptTest.lua script from the 'Script\TutorialScript' folder to the CSG box. Change the Speed value to '10'. Next open up the script in the script editor. Adding a breakpoint on the line that makes the object turn, so we can check the values of the x, y, and z variables:

When we run the program again, the game will pause almost right away. The script editor will highlight the line of code it stopped on, and the script debugger will show all the variables in the program, including our x, y, and z variables we calculated. Notice how the speed variable is also has a value of 10.

## Error and Assert

Error and Assert are two additional tools we can use to make sure code is working as it should.  We can use them to create our own errors that stop the program and show the debug information.

The Debug:Error command will create an error if it is encountered that gets displayed in a message box in the script editor.  In the following example, we will attempt to load a model file that doesn't exist, and display an error when it isn't found.  Copy the following code into the "Main.lua" file and press F5 to run the program:

```lua
--Create a window
window=Window:Create("My Game",0,0,800,600)

--Create the graphics context
context=Context:Create(window,0)
if context==nil then return end

--Create a world
world=World:Create()

--Try to load a model that doesn't exist
local model = Model:Load("blahblahblah.mdl")

--Generate a debug error if the model is nil
if model==nil then
	Debug:Error("Model is nil!")
end
```

Another way to do this is with the Debug:Assert() command.  This accepts a condition and displays an error if that condition is not true.  Basically, this just eliminates the need for an extra "if" statement, making our code a little simpler:

```lua
--Create a window
window=Window:Create("My Game",0,0,800,600)

--Create the graphics context
context=Context:Create(window,0)
if context==nil then return false end

--Create a world
world=World:Create()

--Try to load a model that doesn't exist
local model = Model:Load("blahblahblah.mdl")

--Generate error if model is nill
Assert(model,"Model is nil!")
```

That's really all there is to debugging code.

## Memory Leaks

Your game runs in a loop.  If a script creates an object each loop and doesn't release it, it is possible for the game to keep allocating memory over and over again.  This is called a "memory leak" and it can happen every once in a while when developing your game.  Fortunately, Leadwerks provides a way to help find and eliminate memory leaks.

When your game is run in debug mode, some statistics will be displayed in the upper-left corner of the screen.  This includes the framerate and the current memory usage.  You may notice that your memory usage gradually rises, and then drops suddenly after a while.  This is because Lua only collects memory every once in a while.  You can force Lua to collect memory each frame if you add this command into the loop in your Main.lua file:

```lua
collectgarbage()
```

This will force the garbage collector to perform a full collection each frame, and make it easier to tell if your memory usage is going up.  Just remember to remove or comment out this line when you are done testing, because it will make your game run slower.

## Conclusion

Congratulations, the completion of this tutorial series means that you are now a Lua expert!  In the next series of lessons we're going to take the knowledge we've learned and use it to start making games.
