# Operators

In this lesson we'll review all the logical operators that are available to use in Lua.  Operators are special expessions that can be used to determine the relationship of two values.  They are often used in "if" statements to execute code when a condition is met.

## Equals

The equals operator is denoted by two equals signs in a row: `==`

The equals operator is a test to see if two values are equal.  This does not assign a value to a variable.

```lua
n = 2
if n == 2 then
        Print("n equals 2")
end
```

The equals operator can be used with any data type, including strings and boolean values.

```lua
name = "Fred"
if name == "Fred" then
        Print("The name's Fred")
end
```

## Less Than

The less than operator determines if one number is smaller than another.  The less than sign looks a little bit like a bird's beak if you picture the bird facing to the left: `<`

Remember, birds don't eat a lot, so the number where his beak points is smaller.  Here's an example of it in action:

```lua
a = 1
if a < 2 then
        Print("a is less than 2")
end
```

## Greater Than

The greater than operator determines if one number is larger than another.  The greater than sign looks a little bit like an alligator's mouth if you picture the alligator facing to the left: `>`

Remember, alligators eat a lot, so the number where his mouth points is bigger.  Here's an example of it in action:

```lua
a = 1
if a > 0 then
        Print("a is greater than 0")
end
```

## Less Than or Equal To

This is a variation of the less than operator that will also be true if the values are equal. It is denoted by a less than sign followed by a single equals sign:
`<=`
Here is an example of its usage:

```lua
a = 1
if a <= 1 then
        Print("a is less than or equal to 1")
end
```

## Greater Than or Equal To

This is a variation of the greater than operator that will also be true if the values are equal.   It is denoted by a greater than sign followed by a single equals sign:
`>=`
Here is an example of its usage:

```lua
a = 1
if a >= 1 then
        Print("a is greater than or equal to 1")
end
```

## Not Equal

This operator is the opposite of the equals operator.  It is indicated by a tilde character followed by a single equals sign:
`~=`
Here is an example of its usage:

```lua
a = 1
if a ~= 5 then
        Print("a does not equal 5")
end
```

## Bitwise Operators

Okay, now things are going to get a little weird. Computers use a lot of power-of-two numbers. Power-of-two numbers are what you get if you start with one and just keep multiplying by two:
> 1 x 2 = 2  
> 2 x 2 = 4  
> 4 x 2 = 8  
> 8 x 2 = 16  
> 16 x 2 = 32  
> 32 x 2 = 64  
> 64 x 2 = 128  
> 128 x 2 = 256  

The funny thing about power-of-two numbers is that when we combine them we can tell which numbers we used to make the new number. For example:
> 1 + 2 = 3

We know that if three is made by adding power-of-two numbers together, the two numbers we used are one and two. Here's another example:
> 2 + 4 = 6

The only power-of-two numbers you can add together to make six are four and two!

Let's try another. What power-of-two numbers can we add together to make the number 13?
> 1 + 4 + 8 = 13

This works with all positive power-of-two numbers, into infinity.

### Bitwise OR

Sometimes programmers like to use this super power to combine multiple values into a single variable using something called the logical OR operator:
```lua
n = 1 | 2
Print(n) --prints 3
```
Logical OR will add two power-of-two numbers together...unless one number already contains the other!
```lua
n = 1 | 3
Print(n) --prints 3
```
These combined values are sometimes called "bitwise flags" and are often used for optional settings that are being passed to a function, like the window create function.

```lua
CreateWindow("My Window", 0, 0, 800, 600, display, WINDOW_CENTER | WINDOW_TITLEBAR )
```

The window will be created using the WINDOW_CENTER and the WINDOW_TITLEBAR styles.

### Bitwise AND

If logical OR combines values, logical AND allows us to detect combined values. In the example below, we know the number three is made up of two and one, so two is the value the two sides of the operator have in common.

```lua
n = 2 & 3
Print(n) --prints 1
```

You can quickly check to see if a power-of-two combo contains a bitwise flag like this:

```lua
n = 9
if n & 1 ~= 0 then
        Print("Yes")
end
```

Since nine is made by adding eight and one together, the above code will print "Yes".

You can also use the logical AND operator to remove a bitwise flag from a number, when combined with the not `~` symbol:

```lua
n = 9 & ~ 1
Print(n) --prints 8
```

You probably won't need to use the logical AND operator in your game code, but it's there if you are feeling adventurous.

If this section was a little confusing, that's okay. Next time you see something like `WINDOW_CENTER | WINDOW_TITLEBAR` you will know why it is there and what it does!

## Conclusion

You will frequently encounter most of these operators while writing Lua scripts.  Make sure you understand how they all work, and ask on the forum if you have any questions.  You're doing great!
