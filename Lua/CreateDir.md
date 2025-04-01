# CreateDir

This function creates a new folder on the user's hard drive, if it does not already exist.

## Syntax
- boolean **CreateDir**(string path, boolean recursive = false)

| Parameter | Description |
|---|---|
| path | full or relative path to the new file |
| recursive | if set to true, any missing parent folders in the path will also be created |

## Returns

Returns true if the folder was successfully created or if it already existed, otherwise false is returned.
