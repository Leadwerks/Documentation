# 3D Modeling Pipeline

Ultra Engine natively supports the loading and saving of [Khronos glTF](https://www.khronos.org/gltf/) and Wavefront OBJ files. You can extend its capabilities by adding support for additional model file formats through the [plugin](Plugin.md) system.

## Using glTF Models

Khronos glTF is the recommended 3D model file format to use with Ultra Engine. It provides support for hierarchies, PBR materials, animations, and other useful features. The format loads quickly and seamlessly integrates with a variety of 3D modeling programs.

### Exporting glTF from Blender

To export your models to glTF format from Blender, follow these steps:

1. Open your model in Blender.

2. Go to *File > Export > Export as* and choose the *glTF 2.0* format.

3. There are several formats the glTF file can be saved in:

   - **glTF Binary (.glb)**: This packs the glTF, binary data, and textures into one single file.
   - **glTF Separate (.gltf + .bin + textures)**: This saves the glTF, binary data, and textures as separate files.
   - **glTF Embedded (.gltf)**: This packs the glTF, binary data, and textures into one single ASCII file.

   While Ultra Engine can load any of these types of files, it's best to use the second option, *glTF Separate*. This allows easy access to the glTF data and texture files. However, when sending these types of glTF files to someone else, you must always remember to include the associated .bin file or the model won't be readable. These are usually named the same name as the glTF file, with the .bin extension added.

5. Click the "Export" button to save your model in *glTF format*. Your exported glTF file can be loaded directly into Ultra Engine.

## Working with Memory-Compressed Textures

Most glTF files store textures in PNG images. Although JPEG is supported, it is not recommended due to compression artifacts. glTF does not natively support memory-compressed texture formats, but it does support the [Microsoft DDS](https://github.com/KhronosGroup/glTF/tree/main/extensions/2.0/Vendor/MSFT_texture_dds) and [Basis Universal](https://github.com/KhronosGroup/glTF/tree/main/extensions/2.0/Khronos/KHR_texture_basisu) formats through two file format extensions. If you plan on your game only running on PC platforms, then DDS will be best for you. If you intend for your game to eventually run on platforms like Oculus Quest, then Basis Universal will provide you with future compatibility.

You can convert glTF textures to DDS or Basis in the Ultra Engine editor. Open the glTF file you want to modify and select the *Tools > Convert Textures to DDS* or *Convert Textures to Basis* menu item. This will save all PNG and JPEG images the model uses to the optimized format and reassign these files to the materials. The glTF file will then specify the optimized texture files. The original PNG and JPEG images will be retained, ensuring compatibility with programs that don't support the required extensions. Note that displacement maps should not use compression, and will not be stored in a compressed pixel format, but these files do not have to be shipped with your game.

### Manually Editing glTF Files

Alternatively, you can manually modify the glTF files in a text editor and add the optimized texture files as follows. Here is an example excerpt from a glTF file:

```json
"textures": [
    {
        "source": 0
    }
],
"images": [
    {
        "uri": "mytexture.png"
    }
]
```
And here is the same information with the DDS extension applied:
```json
"extensionsUsed": [
    "MSFT_texture_dds"
],
"textures": [
    {
        "source": 0,
        "extensions": {
            "MSFT_texture_dds": {
                "source": 1
            }
        }
    }
],
"images": [
    {
        "uri": "mytexture.png"
    },
    {
        "uri": "mytexture.dds"
    }
]
```
The following changes were made:
- *MSFT_texture_dds* is added to the *extensionsUsed* section.
- A new image is added in the *images* list specifying the DDS file.
- The *MSFT_texture_dds* block is added to a texture structure with a *source* value specifying the index of the DDS image.

## Additional Information

- [glTF 2.0 in Blender](https://docs.blender.org/manual/en/2.80/addons/io_scene_gltf2.html)
- [glTF Materials in 3ds Max](https://help.autodesk.com/view/3DSMAX/2023/ENU/?guid=GUID-7ABFB805-1D9F-417E-9C22-704BFDF160FA)
- [Exporting to glTF from 3ds Max](https://help.autodesk.com/view/3DSMAX/2023/ENU/?guid=GUID-5B4C8EC2-2230-4F9F-B3C6-48D9E347E37D)
