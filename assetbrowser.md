# Project Panel

The project panel is split into an upper area for navigating between different subfolders in your game's directory, and a lower area that displays file thumbnails.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/assetbrowser.png?raw=true)

Here's a breakdown of its key features:

### Directory Structure

The top half of the Asset Browser displays a search bar and the directory structure of your project. This section allows you to easily locate and organize your project's files and assets. You can navigate through your project's folders and directories, making it convenient to access and manage your resources.

### File Thumbnails

The bottom panel of the Asset Browser showcases thumbnail representations of all the files within the selected directory. These thumbnails provide a visual overview of your project's assets, making it easier to identify and select the files you need.

You can define specific file extensions to be excluded from the browser using the "File Type Blacklist" field, in the Project Settings area. This setting can be configured within the [options window](optionswindow.md). By default, files that use the extension .bin and .meta will not be shown, in order to eliminate visual clutter from your view.

### Other Controls

Above the directory area is a row of controls, including a button with an add sign ('+'), a filter text entry field, and a slider for controlling the file thumbnail size. The filter text entry field supports wildcards, so you can enter *.mat into this field to only view material files, for example. Clearing this text will restore the default view to show all files.

### Opening Files

To open a file, simply double-click its icon. If the file format is supported by Leadwerks, it will be launched in an [asset editor](asseteditor.md) window, providing you with an interface for viewing and editing the asset. Code files will be opened in the integrated [IDE](ide.md) In cases where the file format is not directly supported, it will be opened using your system's default program associated with that specific file type.

### File Previews

Hovering your mouse pointer over a file thumbnail triggers a convenient popup preview. This preview displays a larger view of the file, along with its name and additional relevant information. This feature aids in quickly identifying files without the need to open them, enhancing your workflow efficiency.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/filepreview.png?raw=true)
