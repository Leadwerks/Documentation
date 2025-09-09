# Display

Base class: [Object](Object.md)

This class provides an interface for querying and managing hardware monitors.

| Property | Type | Description |
| --- | --- | --- |
| graphicsmodes | [iVec2](iVec2.md)[] | read-only array of available screen resolutions |
| position | [iVec2](iVec2.md) | read-only screen position on the virtual desktop |
| scale | number | read-only DPI scaling value |
| size | [iVec2](iVec2.md) | read-only screen dimensions |
| [ClientArea](Display_ClientArea.md) | Method | returns the usable area within the screen |
| [GetPosition](Display_GetPosition.md) | Method | returns the position of the display on the virtual monitor space |
| [GetSize](Display_GetSize.md) | Method | returns the display dimensions in pixels |
| [GetScale](Display_GetScale.md) | Method | returns the current DPI scale value |
| [GetDisplays](GetDisplays.md) | Function | returns a list of hardware displays in use |
