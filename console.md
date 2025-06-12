# Console

The Console is a valuable tool for monitoring the program's log, warnings, and error messages. It provides insight into the operation of editor and helps you identify and troubleshoot issues as they arise.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/console.png?raw=true)

## Executing Lua Commands

You can also utilize the Console to execute Lua commands directly within the editor. For example, you can copy and paste the following line of Lua code into the entry field:

```lua
Notify("Hello, world!")
```

Press the "Enter" key to execute the command and see the result.

The console will even support mult-line blocks of Lua code:

```lua
box = CreateBox(program.world)
box:SetColor(1,0,0)
```

This feature allows you to quickly test and run Lua scripts within the editor environment.

## Garbage Collection

A garbage collection sweep will be executed after each command you enter into the console. For example, if you set the box variable from the last example to nil, the box will disappear.

```
box = nil
```

The program viewports are also redrawn after each command is executed.

## Inspecting Variable Values

If you need to examine the value of a variable within the Lua virtual machine, you can do so by typing the variable name into the entry field by itself, and then pressing the Enter key. Here is an example:

```
program
```

When the Enter key is pressed, the value _userdata_ is printed, indicating that program is a C++ class exposed to Lua.
