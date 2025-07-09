# "if" Statements

www.youtube.com/watch?v=JCUZtwh0f-k

An "if" statement is used to check if a condition is met. The program will execute branching logic based on the state of the condition tested.

The syntax for an "if" statement looks like this:

```lua
if condition then
        --the code that gets executed
end
```

Here's a simple example:

```lua
if 2 > 1 then
        Print("Two is greater than one!")
end
```

The above code tests to see if two is greater than one (it is!) and then goes on to execute the code inside the statement.  The statement is terminated with the "end" keyword.  So we know the above code would print out the word "true" when run.

You can compress "if" statements down to a single line to make them take up less vertical space.  This code does the exact same thing as the previous example.

```lua
if 2 > 1 then print("Two is greater than one!") end
```

## Else

We can use the else keyword to make two branches of code that can be executed.  One will be executed if the condition is met, and if it isn't then the other branch of code will be executed.  Here's a simple example:

```lua
a = 1
if a == 2 then
        Print("a equals 2")
else
        Print("a does not equal 2")
end
```

The code above would check to see if the variable "a" was equal to the number 2.  Since it isn't, the program skips to the "else" statement and runs the code following it.

## ElseIf

The "elseif" keyword provides an easy way to combine a lot of "if" statements.  Here's an example:

```lua
n = 2
if n == 1 then
        Print("n equals 1")
elseif n == 2 then
        Print("n equals 2")
elseif n == 3 then
        Print("n equals 3")
end
```

The above code would print out "n equals 2" because that's the only block of code that gets executed.

## Conclusion

This simple idea of branching logic forms the basis of all kinds of gameplay elements, as we will see later on in the gameplay series of tutorials.
