# Stream::WriteFloat #
This method writes a float value to the stream at the current position.

## Syntax ##
- void **WriteFloat**(const float f)

| Parameter | Description |
| --- | --- |
| f | value to write |

## Example

```c++
#include "pch.h"

using namespace UltraEngine;

int main(int argc, const char* argv[])
{
    WString path = GetPath(PATH_DOCUMENTS) + "/temp.bin";

    //Open a stream with read and write permissions
    DeleteFile(path);
    auto stream = OpenFile(path);
    if (stream == NULL)
    {
        Print("Failed to write file.");
        return 0;
    }

    //Write some data
    stream->WriteByte(1);
    stream->WriteDouble(2.0);
    stream->WriteFloat(3.0f);
    stream->WriteInt(4);
    stream->WriteShort(5);

    //Change the stream position
    stream->Seek(0);

    //Read back the data
    Print(stream->ReadByte());
    Print(stream->ReadDouble());
    Print(stream->ReadFloat());
    Print(stream->ReadInt());
    Print(stream->ReadShort());

    //Close the stream
    stream->Close();

    return 0;
}
```