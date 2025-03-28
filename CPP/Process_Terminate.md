# Process::Terminate #

This method forcefully quits a running process.

## Syntax ##

- void **Terminate**()

## Remarks ##

Generally you should not terminate a running process, but should call [Process::Wait](Process_Wait.md) to wait for the process to exit on its own.

## Example ##

```c++
#include "UltraEngine.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
#ifdef _WIN32
    WString appname = "Notepad";
    WString apppath = "C:/Windows/notepad.exe";
#endif

    //Get the displays
    auto displays = GetDisplays();

    //Create a window
    auto window = CreateWindow("Ultra Engine", 0, 0, 460, 480, displays[0]);

    //Create User Interface
    auto ui = CreateInterface(window);

    //Create widget
    auto sz = ui->root->GetSize();
    auto button = CreateButton("Launch " + appname, (sz.x - 120) / 2, (sz.y - 30) / 2, 120, 30, ui->root);

    shared_ptr<Process> proc;

    while (true)
    {
        const Event ev = WaitEvent();
        switch (ev.id)
        {
        case EVENT_WIDGETACTION:
            if (ev.source == button)
            {
                if (proc)
                {
                    proc->Terminate();
                    proc = NULL;
                    button->SetText("Launch " + appname);
                }
                else
                {
                    button->SetText("Close " + appname);
                    proc = CreateProcess(apppath);
                }
            }
            break;
        case EVENT_WINDOWCLOSE:
            return 0;
            break;
        }
    }
    return 0;
}
```
