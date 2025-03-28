# CallMethod

This function performs a method-style function call with any object.

## Syntax

- [sol::object](https://sol2.readthedocs.io/en/latest/api/object.html) **CallMethod**(shared_ptr<[Object](Object.md)\> o, const [WString](WString.md)& name, const std::vector\<[sol::object](https://sol2.readthedocs.io/en/latest/api/object.html)\>& args = {} )
- bool **CallMethod**(shared_ptr<[Object](Object.md)\> o, const [WString](WString.md)& name, const std::vector\<[sol::object](https://sol2.readthedocs.io/en/latest/api/object.html)\>& args, std::vector\<[sol::object](https://sol2.readthedocs.io/en/latest/api/object.html)\>& returnvalues)

| Parameter | Description |
|---|---|
| o | object to call the method for, must be derived from [Object](Object.md) |
| name | name of the method |
| args | method arguments |
| returnvalues | return values will be stored here |

## Returns

The first overload returns a single return value.

The second overload returns true if the method was successfully executed, otherwise false is returned.

## Remarks

When CallMethod is used, the object passed to the function will be the first function argument. The function must be declared in Lua preceeded by ":", enabling the self keyword to be used.

```lua
function player:SetHealth( health )
    self.health = health
    self.healthbar:Update(Clamp(health / 100, 0, 1))
    if self.health <= 0 then
        self:Die()
    end
end
```
The function will be identified by name, so it must be a field of the userdata object passed to the CallMethod function:

## Syntax

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    //Create an object
    auto box = CreateBox(NULL);
    box->name = "Bob";

    //Declare a variable in Lua
    SetGlobal("entity", box);

    //Run a script that attaches a function to the entity
    ExecuteString("function entity:Rename( newname ) self.name = newname end");

    //Call the method
    CallMethod(box, "Rename", { "Fred" });

    //Check if it worked
    Print(box->name);

    return 0;
}
```
