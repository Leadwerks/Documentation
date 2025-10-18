# WString

Base class: [Object](Object.md)

This class provides an interface for manipulating wide unicode text strings. This class is preferable because it can support all characters.

| Property | Type | Description |
|---|---|---|
| WString | Constructor | WString(const char* c) |
| WString | Constructor | WString(const wchar_t* c) |
| WString | Constructor | WString(const int i) |
| WString | Constructor | WString(const float f) |
| WString | Constructor | WString(const double f) |
| [Find](WString_Find.md) | Method | performs a search operation |
| [GetSize](WString_GetSize.md) | Method | returns the length of the string |
| [Left](WString_Left.md) | Method | returns leftmost characters |
| [Lower](WString_Lower.md) | Method | converts the string to lowercase |
| [Mid](WString_Mid.md) | Method | returns the length of the string |
| [Replace](WString_Replace.md) | Method | performs a search and replace operation |
| [Right](WString_Right.md) | Method | returns rightmost characters |
| [Split](WString_Split.md) | Method | segments the string |
| [StartsWith](WString_StartsWith.md) | Method | compares the beginning of two strings |
| [ToFloat](WString_ToFloat.md) | Method | converts the string to a floating point value |
| [ToInt](WString_ToInt.md) | Method | converts the string to an integer value |
| [ToString](WString_ToString.md) | Method | returns a narrow string containing only ASCII characters |
| [ToUtf8String](WString_ToUtf8String.md) | Method | returns a narrow string with UTF-8 encoding |
| [Trim](WString_Trim.md) | Method | removes whitespace characters from the ends of the string |
| [Upper](WString_Upper.md) | Method | converts the string to uppercase |
| [Xor](WString_Xor.md) | Method | performs an XOR operation |
