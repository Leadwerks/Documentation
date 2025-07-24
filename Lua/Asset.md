# Asset

Base class: [Object](Object.md)

This is the base class for all media classes.

| Property | Type | Description |
| --- | --- | --- |
| path | [string](https://www.lua.org/manual/5.4/manual.html#6.4) | read-only string containing the path to the file the asset was loaded from |
| packagepath | [string](https://www.lua.org/manual/5.4/manual.html#6.4) | read-only string containing the path to the package the asset was loaded from |
| properties | [table](https://www.lua.org/manual/5.4/manual.html#6.6) | user-defined properties |
| [GetPackage](Asset_GetPackage.md) | Method | returns the package the asset was loaded from, if it has not been deleted |
| [Reload](Asset_Reload.md) | Method | reloads an asset from the file it was originally loaded from |
| [Save](Asset_Save.md) | Method | saves an asset to a file |
