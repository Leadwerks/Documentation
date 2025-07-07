# Functions

Functions are a reusable bit of code that can be called anywhere from in your program.

## Function Declarations

A function declaration looks like the code below:
```lua
function MyFunction()
	--function code goes here.
end
```

The function keyword indicates the start of a function declaration, and is followed by the name, which in this case is "MyFunction".  We can put any code inside the function.  The example below declares a function called "SayHello" which prints the string "Hello!" whenever it is called.  Note that the function code only gets called when the function is called.  The function code is not executafed before then::
```lua
function SayHello()
	print("Hello!")
end

SayHello()
```

## Function Arguments

You can pass optional values to a function to be used in its code.  These values are called "arguments" or "parameters".  In the example below, a function is declared which accepts one argument and performs an action:
```lua
function PrintUpper(text)
	print(string.upper(text))
end

PrintUpper("Functions can be fun.")
```

You can send multiple arguments to a function by separating them with a comma:
```lua
function CombineAndPrintUpper(text1,text2)
	print(string.upper((text1))..string.upper((text2)))
end
CombineAndPrintUpper("Hello, ","how are you?")
```

## Return Values

Functions can also return a value to the code that is calling them.  The function below accepts an argument, adds one to it, then returns the result:
```lua
function AddOne(num)
	return num+1
end
n = AddOne(2)
print(n)
```
One special feature of Lua is that a function can actually return multiple values.  In the example below, two values are returned and assigned to two different variables:
```lua
function AddOneAndSubtractOne(num)
	return num+1, num-1
end
--Whoa!
x,y = AddOneAndSubtractOne(2)

print(x)
print(y)
```
## Functions in Tables

Lua tables can have functions that allow them to act in an object-oriented manner.  This just means that the table can perform actions on its own values, instead of having to pass every single argument to each function.
Declaring a table function is done like so
```lua
MyTable = {}
function MyTable:SayHello()
	print("Hello!")
end

MyTable:SayHello()
```
A table function is called with the table variable first, followed by a colon (":") and then the function name.  When a function is called in this manner, the table itself is accessible inside the function code with the keyword self.  In the next example, the keyword self is used to get the table's own "health" value and display it:
```lua
MyTable = {}
MyTable.health = 100
function MyTable:PrintHealth()
print(self.health)
end

MyTable:PrintHealth()
```
Note that the table variable and function name must be joined by a colon (":"), not a period(".").  Using the colon separator will silently insert the table itself into the "self" value.  If you use a period, the self variable will not be recognized in the function code:
```lua
MyTable = {}
MyTable.health = 100
function MyTable:PrintHealth()
	print(self.health)
end

MyTable.PrintHealth()
```
When the above code is run, you'll get an error like this:

If table functions look familiar, it's because you've already seen them, back in the first Lua tutorial.  The object scripts system Leadwerks uses makes use of table functions in this manner.  Do you remember adding this code to make the fan spin?
```lua
function Script:UpdateWorld()
	self.entity:Turn(0,0,1)
end
```
An object script has a table associated with the object in the map.  The self keyword refers to that table.  All object scripts have one table value that is always present called "entity".  This is the actual 3D object that gets loaded from the map, and it is always a type of Entity object.  So object scripts can always refer to their own entity with "self.entity".  You can add additional fields to this table for health, ammo, experience level, or anything else you want to make part of your game.  That, dear reader, is the power of Leadwerks and Lua.

## Conclusion
Whoa!  Is your mind blown or what?  We've come full circle now.  The only thing left to do is wrap up a few more details and then it's on to the gameplay!
