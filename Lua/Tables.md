# Tables

A Lua table is an associative array object that can store information.  This is a powerful feature of the Lua programming language that is very useful for games.  In this lesson we'll learn everything there is to know about tables.

## Creating Tables

Tables can be created by the special character combination "{}".  The code below will create an empty table:
```lua
mytable = {}
```

## Keys and Fields

Lua tables have keys and fields.  A field is a variable attached to the table that stores information.  Fields are identified by a key, which is usually a string, but can be any data type.  Fields can be accessed like so:
```lua
--Create a new table
mytable={}

--Set the color field to "Red"
mytable.color = "Red"
```

What fields can you put in a table?  The answer is, anything your heart desires.  This makes Lua fantastic for games, because you can store any information you need about an object in a table:
```lua
--Create a new table
mytable={}

--Set the name field to "Player 1"
mytable.name = "Player 1"

--Set the health field to 100
mytable.health = 100
```

You can also access table fields by putting the name in brackets:
```lua
--Create a new table
mytable={}

--Set the color field to "Red"
mytable["color"] = "Red"
```

Or you can use numbers in brackets and treat the table like an array:
```lua
--Create a new table
speech={}

--Set the index 0 field to "Hello"
speech[1] = "Hello"
```

You can even make tables of tables, as the example below demonstrates:
```lua
--Create a new table
mytable={}

--Set the weapon field to a new table
mytable.weapon = {}

--Set the ammo field of the weapon table to 200
mytable.weapon.ammo = 200
```

If you want to remove a field from a table, just set its value to nil:
```lua
--Create a new table
mytable={}

--Set the color field to "Red"
mytable.color = "Red"

--Remove the color field
mytable.color = nil
```

## Tables as Arrays

Sometimes you might want to have a table that acts like an array.  The easiest way to do this is to insert items into the last index of the table.  We can do this with this table.insert() function.  To get the length of a table, just add the hashtag character before the table:
```lua
--Create a new table
mytable={}

--Insert some items into the table
table.insert(mytable,"Thing 1")
table.insert(mytable,"Thing 2")
table.insert(mytable,"Thing 3")

--Print the length of the table
print(#mytable)
```

## Iterating Through Tables
Sometimes you might not know what all the keys of a table are, and so you don't know what to look for.  To loop through all the fields a table contains, you can use a for loop as shown below:
```lua
--Create a new table
mytable={}

--Insert some items into the table
mytable.something = "Thing 1"
mytable.somethingelse = "Thing 2"
mytable.anotherthing = "Thing 3"

--Iterate through all fields
for key,value in pairs(mytable) do
	print(key.." = "..value)
end
```

The pairs() function in Lua will iterate through a table sorted alphabetically.  If you have a numbered table and want to iterate through it in sequential order, instead just use the ipairs() function:
```lua
--Create a new table
mytable={}

--Insert some items into the table
table.insert(mytable,"Thing 1")
table.insert(mytable,"Thing 2")
table.insert(mytable,"Thing 3")

--Iterate through all fields in numerical order
for key,value in ipairs(mytable) do
	print(key.." = "..value)
end
```
If you know your table only includes numeric keys, you can iterate through it like an array:
```lua
--Create a new table
t = {}

--Insert some items into the table
t.insert(mytable, "Thing 1")
t.insert(mytable, "Thing 2")
t.insert(mytable, "Thing 3")

--Iterate through all fields in numerical order
for n = 1, #t do
	Print(t[n])
end
```
And that's all there is to it!  Now you know the basics of how to store your game's information.

## Conclusion

Tables are the magic that makes the Lua language so flexible and great for games.  It's important to understand this feature, so don't hesitate to ask any questions you have in the forum or on our Discord server.
