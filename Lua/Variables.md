# Variables
A variable is a named value in a program that stores a piece of information. Let's take a look at the definition of the word "variable", as provided by [dictionary.com](http://dictionary.reference.com/browse/variable):

> adjective
> 
> apt or liable to vary or change; changeable:  
> variable weather; variable moods.  
> capable of being varied or changed; alterable:  
> a variable time limit for completion of a book.  
> inconstant; fickle:  
> a variable lover.  
> having much variation or diversity.  
> Biology. deviating from the usual type, as a species or a specific character.  
> Astronomy. (of a star) changing in brightness.  
> Meteorology. (of wind) tending to change in direction.  

All of these definitions have something to do with the idea of change, and as you might have guessed, variables can and do very often change values during the execution of a program. Variables can be used to keep track of the health of a character, the player's score, or the angle of the rising sun.

Declaring Variables
In Lua we can declare a variable at any time and start using it very easily:

```lua
MyVariable = 3
```

You give variables any name you want, with a few exceptions. Variables names can't start with a number, and can only contains letters, either lower-case or upper case. Numbers can be used in the name after the first letter. Variables are case sensitive, meaning that the code below would actually declare two different variables with different values:

```lua
MyVariable = 1
myvariable = 2
```

Once a variable has a value set, it can be retrieve and used. This code, for example, would print out the number "3".

```lua
MyVariable = 3
Print(MyVariable)
```

## Data Types
Lua is a **dynamically typed*** language. This means that a variable can hold any kind of value. This includes numbers, strings, booleans, tables, and objects. In this lesson we will learn about the first three data types and save the others for later.

```lua
health = 100 --number
name = "RoboSlayer" --string
readyToFight = true --boolean
```

A variable that holds one type of data can be assigned another type without any problems:

```lua
health = 100
health = "Full"
```

If you ever want to know the type of a value, you can use the type Lua function, as in the example below:

```lua
local a = 3
Print(type(a)) --prints "number"
```

Now let's look at the most common data types in more detail.

## Numbers

The number represents any real number, and can be positive or negative. Numbers can be integer or decimal values:

```lua
n = 1
f = 0.5
```

You can use algebraic expressions to perform mathematical operations on number varlables:

```lua
a = 1
b = 2
c = a + b
Print(c) --prints "3"
```

## Strings

Strings are a sequence of characters that form a bit of text. These can be used for the name of a player, or to store some dialog that will be displayed onscreen when you talk to a character in the game.

```lua
name = "Smashy the Clown"
```

You can concatenate (add) two strings values together by putting two periods in between the variables:

```lua
a = "Hello, "
b = "how are you today?"
Print(a..b) --prints "Hello, how are you today?"
```

## Booleans

Boolean are a very simple data type that can only have two values, true and false. These are used for "state" values that only have an on/off value.

```lua
playerIsReady = true
```

## Nil
Until a value is assigned to a variable, all variables are equal to nil. Nil means "no value". It is [u]not[/u] the same thing as zero, because zero is an actual number. Nil means "nothing".
Converting Data Types
We can convert values to different data types very easily in Lua. Sometimes this is done automatically. If we print a number value, for example, it automatically gets converted to a string that is printed to the program output. Sometimes we need to explicitly force conversion of one data type to another. This can be achieved with the Lua functions tonumber() and tostring().

```lua
n = 2 --number value
n = tostring(n) --now it is a string value
```

Boolean values can be converted to strings:

```lua
b = true --boolean value
b = tostring(b) --convert to string
Print(b) --prints "true"
```

However, true and false do not correspond to one and zero, and booleans cannot be converted to numbers:

```lua
b = true --boolean value
b = tonumber(b) --fails to convert to number
Print(b) --prints "nil"
```

## Scope

Scope is an important programming concept. Variables can have one of two scopes. They can be global or local. Global variables are accessible anywhere in the program, by any script file. By default, Lua variables are all global. In a single-player game we might have a global variable called "PlayerScore" we use to keep track of points the player gets.
Local variables are contained within a piece of code. We can define a local variable with the key word "local":

```lua
local n = 1
```

Local variables can only be accessed from within the block of code they are declared in. In the example below, a local variable is declared inside an "if" statement. Because the variable is made local, it will not be visible to code outside the if statement.

```lua
a = 1
if a > 0 then
        local n = 2
end

Print(n) --prints "nil"
```

Local variables are great because they let us use the same name in different places. For example, the player and an enemy can both have a value for "health", without having to name them something different. Local variables help us compartmentalize code so that it's more reusable.

## Conclusion

You're starting to build some pretty advanced knowledge that's good not only for games, but computer science in general! (Now would be a good time to brag to your parents about how smart video games are making you.) If any of this wasn't clear or you don't understand something, feel free to let us know on the forum, and we'll try to help you.
