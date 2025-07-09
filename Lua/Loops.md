# Loops

www.youtube.com/watch?v=Zt04WgwICMM

Loops allow you to execute the same code without rewriting it over and over.  This helps structure your program.  It's important to understand how while and for loops work in Lua, so let's jump right in. Hold onto your hats because things are about to get a bit...loopy!

## While Loops

The while loop is a statement that keeps on looping over its code until a certain condition is met. The syntax of a while loop is as follows:
```lua
while condition do
  --code to be executed
end
```

The example below can be pasted into your "Main.lua" script file to see how while loops work.  When you run this example (select the Game > Debug menu item in the script editor menu) it will keep looping until the space key is pressed.  Even clicking on the game window won't close it because you have to press Space to exit the loop:
```lua
--Get the displays
local displays = GetDisplays()

-- Create a window
local window = CreateWindow("Leadwerks", 0, 0, 1280, 720, displays[1], WINDOW_CENTER + WINDOW_TITLEBAR)

-- Create a world
local world = CreateWorld()

-- Create a framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetPosition(0, 0, -2)

-- Create a light
local light = CreateBoxLight(world)
light:SetRotation(45, 35, 0)
light:SetRange(-10, 10)
light:SetColor(2)

-- Create a model
local model = CreateBox(world)
model:SetColor(0, 0, 1)

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do
    model:Turn(0, 1, 0)
    world:Update()
    world:Render(framebuffer)
end
```

## For Loops

The for loop looks a lot like the while loop, but it's a little fancier.  A for loop has a defined starting and ending value.  The loop will be performed a certain number of times until the ending value is reached.. If you want to do something ten times you can use a for loop instead of writing the same code over and over again.
A for loop has the following syntax:
```lua
for startValue, EndValue, [increments] do
	--code to execute
end
```

The increments value is optional.  If it isn't defined, it is assumed to be "1", meaning that the value gets one added to it at the end of each loop.  Paste the code below into the "Main.lua" and run the game to see how it works:
```lua
--For loop
for n = 1, 10 do
        --Print out a string
        Print("Loop iteration: "..n)
end
```
When run, the program above will print out the following text:
> Loop iteration: 1  
Loop iteration: 2  
Loop iteration: 3  
Loop iteration: 4  
Loop iteration: 5  
Loop iteration: 6  
Loop iteration: 7  
Loop iteration: 8  
Loop iteration: 9  
Loop iteration: 10  

If we add an increment value we can customize the way the loop is incremented.  By setting the increment value to "2" we can print every other number from 1 to 10:
```lua
--For loop
for n=1,10,2 do
	--Print out a string
	Print("Loop iteration: "..n)
end
```
Here is the printed output of the program:
> Loop iteration: 1  
Loop iteration: 3  
Loop iteration: 5  
Loop iteration: 7  
Loop iteration: 9  

We can even use the increment value to decrease the starting value each loop.  In that case, we would want to start value to be greater than the ending value, or else the loop would continue forever.  The following code will iterate backwards from 10 to one, subtracting one from the n variable each iteration:
```lua
--For loop
for n = 10, 1, -1 do
	--Print out a string
	Print("Loop iteration: "..n)
end
```
Here is the printed output of the above program:
> Loop iteration: 10  
Loop iteration: 9  
Loop iteration: 8  
Loop iteration: 7  
Loop iteration: 6  
Loop iteration: 5  
Loop iteration: 4  
Loop iteration: 3  
Loop iteration: 2  
Loop iteration: 1  

## Break

You can exit a loop early at any time with the break keyword.  The example below will iterate through a loop until the fifth iteration, at which point it will encounter the break command and exit the loop early.
```lua
--For loop
for n=1,10 do
	--Exit loop when 5 is reached
	if n==5 then
		break
	end
	--Print out a string
	Print("Loop iteration: "..n)
end
```
The printed output of this program looks like this:

> Loop iteration: 1  
Loop iteration: 2  
Loop iteration: 3  
Loop iteration: 4  

## Conclusion
Loops are an important language used to structure code.  In fact your game itself is running in one big loop inside the script interpreter.  Every programming language in existence uses some variation of this idea.
