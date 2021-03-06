# Display #
This class provides an interface for querying and managing computer display screens such as hardware monitors.

### Properties ###
| Name | Type | Description |
| --- | --- | --- |
| graphicsmodes | const vector<[iVec2](iVec2.md)>& | read-only available screen resolutions |
| position | const [iVec2](iVec2.md)& | read-only screen position on the virtual desktop |
| scale | const float& | read-only DPI scaling value |
| size | const [iVec2](iVec2.md)& | read-only screen dimensions |
| [GetPosition](Display_GetPosition.md) | Method | returns the position of the display on the virtual monitor space |
| [GetSize](Display_GetSize.md) | Method | returns the display dimensions in pixels |
| [GetScale](Display_GetScale.md) | Method | returns the current DPI scale value |
| [GraphicsModes](Display_GraphicsModes.md) | Method | returns a list of supported graphics resolutions |
| [GetDisplays](GetDisplays.md) | Function | returns a list of hardware displays in use |
