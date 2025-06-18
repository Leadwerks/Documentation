# 3D Models

Leadwerks can load 3D models from Khronos glTF, Wavefront OBJ formats, as well as its own proprietary MDL format. FBX files can be converted to MDL format in the editor.

## Downloading 3D Models

You can download a variety of game-ready 3D models in the [downloads manager](downloadsmanager.md).

## Importing 3D Models

To import a 3D model into your project, simply copy all files into your game's folder or subfolders. glTF, WAV, and Leadwerks MDL files can be immediately opened by double-clicking on them in the [project panel](assetbrowser). You can convert FBX files to Leadwerks MDL format by right-clicking on the file thumbnail and selecting the **Convert to MDL** popup menu.

## Adding a Model to the Scene

To insert an instance of a model into your scene, just click and hold on the file thumbnail with the **left mouse button**. Drag and mouse into any of the viewports and release the mouse button when you are hovered over the spot you wish to place the model.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/addmodel.gif?raw=true)

## Editing Models

You can double-click on a model file icon to open it in the [model editor](modeleditor.md). This interface provides a variety of tools to adjust model files. You can save the model when you are done editing, to overwrite the original file and store your changes.

Typically, your workflow should involve moving 3D models from other file formats and resaving as Leadwerks MDLs, as this format supports many features others do not.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/modeleditor.gif?raw=true)
