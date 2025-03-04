# LoadPackage

This function loads a package from an archive file.

## Syntax

- `Package LoadPackage(string path, LoadFlags flags = LOAD_DEFAULT)`

## Parameters

| Parameter | Description |
|---|---|
| path | file path to load |
| flags | optional load flags |

## Returns

Returns a new package if it was successfully loaded, otherwise NULL is returned.

## Remarks

When a package is loaded it will automatically be used when `ReadFile` is called. When this function is called, a file on the user's hard drive will first be loaded and returned if it exists. Otherwise, each loaded package will be checked for the file, in the order the packages were loaded.

Example:

```csharp
Package package = LoadPackage("path/to/package");
```
