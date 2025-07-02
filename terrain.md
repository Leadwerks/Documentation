# Terrain

www.youtube.com/watch?v=7iZue7odgYI

Leadwerks has a built-in clipmap terrain system, complete with tools for sculpting and painting terrain.  We can use these tools to create expansive outdoor environments, and we'll learn how to do exactly that in this tutorial.

## Creating Terrain
To create a terrain, select the **Terrain Tool** in the lef-side bar. A Terrain tab will appear on the right-side panel. Here you can choose a heightmap size.  Let's use the default size of 512x512 and press the **Create** button to create a new terrain.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/createterrain.png?raw=true)

The terrain is now visible as a flat white surface.  When you hover your mouse over the terrain, a new mouse tool will appear that lets us modify the terrain.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/newterrain.png?raw=true)

Let's add a material to make the terrain more easily visible. Press the **Add** button below the material list to add a material to the terrain. If you don't have one yet, you can download any of the ground materials in the [downloads manager](downloadsmanager.md).

![](https://github.com/UltraEngine/Documentation/blob/master/Images/newterrain2.png?raw=true)

## Sculpt
Sculpting terrain is easy and fluid in Leadwerks Editor. If you move the mouse over the terrain you will see a white and yellow circle. These two circles define the inner and outer radius of the terrain tool's magic.

If you hold down the left mouse button and move the mouse, you will start building up the terrain. Try it out by making a small hill. Holding down the control key whilst pressing the mouse will lower the terrain. Try removing the hill that you just created.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/sculptterrain.gif?raw=true)

The inner and outer radius of the terrain tool can be adjusted to get different effects.  The distance between the inner and outer radii will cause hills to appear either smoother or steeper and more cliff-like. Set the outer radius to 20 to cover a larger area. Now set the inner radius to 0.9. Make a large hill on the terrain by holding down the left mouse button on the terrain and moving the mouse around.

Now change the inner radius to 0.1 and create another hill next to the first one. Notice how the second hill has a very smooth slope, while the first hill has slopes that are almost vertical.

The strength setting determines how much the terrain is affected by the terrain tool. For adding small details to the terrain you will want a lower strength. If you want to create large mountains instantly, use a higher strength.

The height property determines the vertical scaling of the terrain.  If we make a hill higher and higher, we'll eventually reach a "ceiling" we can't go above.  The terrain height setting lets us alter the maximum height of the terrain so we can create higher mountains.  Change the height to 200. This will affect the terrain instantly. Our mountain is now twice as high.

## Smooth
We can smooth terrain with the smoothing tool. Select the "Smooth" tool and set the inner radius to 0.5. Now try smoothing out the steep hill you made. The higher the strength the faster the smoothing process goes

![](https://github.com/UltraEngine/Documentation/blob/master/Images/smoothterrain.gif?raw=true)

## Flatten
The flatten tool is used to adjust terrain to one height.  It's very useful for making plateaus, which are an area of flat raised ground.  Select the 'Flatten" tool and set the outer brush radius to five.  Move your mouse so it is hovering over the top of your steep hill. Now hold down the mouse and start dragging the mouse towards lower ground. The terrain underneath the mouse will raise up to the same height you first clicked on, but won't go above this height.  If you move too quickly or if the strength setting is low, the terrain will rise, but will not reach the same height.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/flattenterrain.gif?raw=true)

## Importing a Heightmap
You can import heightmaps into leadwerks from 16-bit RAW files.  (Image file formats are not supported because the limited resolution causes visual artifacts.)  There are many external tools that can be used to generate heightmaps.  One such tool is L3DT and it can be downloaded for free.  Let's import a heightmap made with this tool.

Download this file: [512.r16](https://github.com/Leadwerks/Documentation/raw/refs/heads/master/Assets/Terrain/512.r16)

Press the **Load** button in the terrain editor and select the file "512.r16" that you downloaded.  Press the Open button and the height data will be loaded into your terrain.

## Painting
The painting tool in Leadwerks make it is easy to get a great looking terrain in just a few minutes.  Take a look at the "Layers" section below the terrain tool settings.  Each layer can have a diffuse, normal, and displacement map.  If you right-click on the Diffuse tree node under layer one, a popup menu will appear.  Select the Select File popup menu item and choose the "savannah_dirt.tex" file.  When you press the Open button, the texture will be added to the first terrain layer.  Because this is the bottom layer, it will appear everywhere on the terrain.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/paintterrain.gif?raw=true)

## Sample Terrain

Install the "Sample Terrain" in the Environment category of the [downloads manager](downloadsmanager.md). We're going to learn how to build this terrain, one step at a time.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/sampleterrain.jpg?raw=true)

First, create a new 512x512 terrain. Once this is created, press the **Add** button and select the _512.r16_ file found in the _Heightmaps_ folder in your project. Set the terrain vertical scale to 14000% to stretch the heightmap vertically. (When you save the scene the scaled terrain height values will be stored in the file, and the vertical scale will be reset to 100%.)

![](https://github.com/UltraEngine/Documentation/blob/master/Images/terrainheightmap.png?raw=true)

Now let's add a base material layer. Click the **Add** button and select the file "Materials\Ground\Soil_Ground_22.mat".

![](https://github.com/UltraEngine/Documentation/blob/master/Images/terrainbase.png?raw=true)

Next we will add a layer of rocks for the sides of hills. Add the material "Materials\Rock\Rock_Wall_01.mat" the the terrain. Set the minimum slope to 35 degrees and then press the **Fill** button. This will paint the layer at every spot on the terrain that is more steep than 35 degrees. Set the UV scale to 4.0 to make the rocks appear bigger.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/terrainrock.png?raw=true)

Next we will add a grass layer. Add the material "Materials/Ground/sparse_grass.mat" to the terrain. Set the maximum slope to 15 degrees and press the **Fill** button.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/terraingrass.png?raw=true)

Finally, let's add some snow at the top of the hills. Add the material "Materials/Ground/snow008A.mat" to the terrain. Set the maximum slope to 15 degrees. Next, set the minimum height to 75 meters. Press the **Fill** button and snow will appear on top of the hills.

![](https://github.com/UltraEngine/Documentation/blob/master/Images/terrainsnow.png?raw=true)

Finally, you can set the skybox, specular, and diffuse environment maps to those found in the Materials/Environment/DaySkyHDRI011B folder, and adjust the sun settings in the [world settings](worldsettings) dialog, to get the exact look that you want.
