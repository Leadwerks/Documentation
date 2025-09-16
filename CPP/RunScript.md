# RunScript

This function executes a Lua script from a file or string.

## Syntax

- bool **RunScript**(const [WString](WString.md)& path)
- bool **RunScript**(const [WString](WString.md)& path, vector\<sol::object\>& returnvalues)

| Parameter | Description |
|-----|-----|
| path | script file to run |

## Returns

Returns true if the script was successfully run, otherwise false is returned.

## Remarks

This command can run both raw Lua code files (.lua) or compiled Lua byte code (.luac). See the [Lua documentation](https://www.lua.org/manual/5.4/luac.html) for additional information.

A build of the luac compiler is included in the "Tools" folder of the Ultra Engine install directory.

## Example

This shows a typical setup for the C++ side of a Lua program.

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

void ExecuteDir(const WString& path)
{
    auto dir = LoadDir(path);
    for (auto file : dir)
    {
        WString filepath = path + "/" + file;
        switch (FileType(filepath))
        {
        case 1:
            if (ExtractExt(file).Lower() == "lua")  RunScript(filepath);
            break;
        case 2:
            ExecuteDir(filepath);
            break;
        }
    }
}

int main(int argc, const char* argv[])
{
    //Get commandline settings
    auto settings = ParseCommandLine(argc, argv);

    //Run the error handler script
    RunScript("Scripts/System/ErrorHandler.lua");

    //Enable the debugger if needed
    shared_ptr<Timer> debugtimer;
    if (settings["debug"].is_boolean() and settings["debug"] == true)
    {
        RunScript("Scripts/System/Debugger.lua");
        debugtimer = CreateTimer(510);
        ListenEvent(EVENT_TIMERTICK, debugtimer, std::bind(PollDebugger, 500));
    }

    //Enable the entity component system
    RunScript("Scripts/System/ComponentSystem.lua");

    //Run user start scripts
    ExecuteDir("Scripts/Start");

    //Run main script
    RunScript("Scripts/Main.lua");

    return 0;
}
```
