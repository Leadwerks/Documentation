# Code Comments

www.youtube.com/watch?v=J70jEln0gPQ

Welcome to the easiest tutorial ever.  We're just going to talk a little but about code comments, why we add them, and how to use them.  Commenting out code is a way to remove it so that it gets ignored by the game.  The code will still be in your script file, but will not be read by the Lua script interpreter.

## Why We Comment

Even if you're an expert programmer, it's not always obvious right away what a block of code does.  When programmers are working together on a project, it's important for them to add some remarks in the code to explain what they're doing.  But comments are still important if you're just working alone, because you won't always remember writing your own code.  A simple comment can help you remember what you were doing.
Comments are also useful for temporarily removing part of the code, without deleting it forever.  Sometimes you will want to comment a line of code out so you can see how the game runs without it.  Other times you may wish to comment out an entire block of code so you can temporarily remove a feature to focus on something else.

## Single-line Comments

You can comment out a single line of code by adding two dashes in front of the line.  When you do this the text will change colors indicating that it is inactive.

```lua
--This is a single-line comment
```

You can also add a comment to the end of a line of code to explain what it is doing:

```lua
model = CreateBox(world) --create a new box model
```

## Multi-line Comments

You can comment out multiple lines of code by adding "--[[" before the block and "]]" after.  When you do this the entire section of text will change colors indicating that it is inactive.

```lua
--[[
This is a multi-line comment
It can span multiple lines
So you don't have to comment out each line one at a time
]]
```

## Conclusion

That's all there is to know about comments.  I told you this would be easy.  Better make another cup of tea because next we're going to introduce some real computer science concepts.  But don't worry, we'll make it easy to learn.
