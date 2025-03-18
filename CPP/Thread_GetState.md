# Thread::GetState #
This method returns the thread's current state.

## Syntax ##
- [ThreadState](Constants.md#ThreadState) **GetState**()

## Returns ##
The returned value may be THREAD_READY, THREAD_RUNNING, or THREAD_FINISHED.

## Example ##

```c++
#include "Leadwerks.h"

using namespace Leadwerks;

void ThreadFunc()
{
    std::vector<int> primenumbers;
    int i;
    for (int num = 0; num <= 10000; num++) {
        int count = 0;
        for (i = 2; i <= num / 2; i++) {
            if (num % i == 0) {
                count++;
                break;
            }
        }
        if (count == 0 && num != 1)
        {
            primenumbers.push_back(num);
        }
    }
}

void PrintState(shared_ptr<Thread> thread)
{
    switch (thread->GetState())
    {
    case THREAD_READY:
        Print("Ready");
        break;
    case THREAD_RUNNING:
        Print("Running");
        break;
    case THREAD_FINISHED:
        Print("Finished");
        break;
    }
}

int main(int argc, const char* argv[])
{
    //Create thread
    auto thread = CreateThread(std::bind(ThreadFunc));
    PrintState(thread);

    //Execute thread
    thread->Start();
    PrintState(thread);

    //Wait for thread to finish
    thread->Wait();
    PrintState(thread);

    return 0;
}
```
