# Terrain:SetLayerWeight

This method sets the terrain material at any point on the heightmap. 

## Syntax

- **SetLayerWeight**(number layer, number x, number y, number weight, boolean normalize = true)
- **SetLayerWeight**(number layer, [iVec2](iVec2.md) coord, number weight, boolean normalize = true)

| Parameter | Description |
|---|---|
| layer | index of layer to use |
| coord, (x, y) | terrain point to modify |
| weight | influence the material has at this point |
| normalize | if set to true, other layers in use at this point will be adjusted so the sum of all layer weights is 1.0 |

## Returns

If the specified point lies outside of the terrain area, false is returned.

If the terrain is not currently using the specified material but is already using the maximum number of materials false is returned, otherwise true is returned.

## Remarks

Terrains can use a maximum of 256 different materials each. Up to four materials can influence each point.

The first variation of this method will apply the specified material to one point on the terrain, with a weighting value. Up to four materials can be applied to any terrain point. Their weights will be normalized before rendering. If the material has already been applied at this terrain point, its weighting value will be replaced.

The second variation will apply the material to the entire terrain.

If the terrain point already has four materials applied, the material with the lowest influence less than or equal to the influence parameter will be replaced. If all materials have a higher influence than the new material, no change will occur.

If material is NULL, with any variation of this method, all materials will be removed.

If the terrain already is using the maximum number of materials, no change will occur.

## Example

This example lets you paint a material onto the terrain.

![](https://raw.githubusercontent.com/Leadwerks/Documentation/master/Images/terrain_setmaterial.jpg)

```lua
-- Get the display list
local displays = GetDisplays()

-- Create a window
local window = CreateWindow("Terrain Paint", 0, 0, 1280, 720, displays[1], WINDOW_CENTER + WINDOW_TITLEBAR)

-- Create a world
local world = CreateWorld()
world:SetAmbientLight(0)

-- Create a framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create a camera
local camera = CreateCamera(world)
camera:SetFov(70)
camera:SetPosition(0, 100, -100)
camera:SetRotation(45, 0, 0)
camera:SetClearColor(0.125)

-- Sunlight
local light = CreateDirectionalLight(world)
light:SetRotation(45, 35, 0)
light:SetColor(2)

-- Create terrain
local terrain = CreateTerrain(world, 512, 512)
terrain:LoadHeightmap("https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets/Terrain/512.r16")
terrain:SetScale(1, 100, 1)

-- Create base material
local ground = CreateMaterial()
local diffusemap = LoadTexture("https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets/Materials/Ground/river_small_rocks_diff_4k.dds")
local normalmap = LoadTexture("https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets/Materials/Ground/river_small_rocks_nor_gl_4k.dds")
ground:SetTexture(diffusemap, TEXTURE_DIFFUSE)
ground:SetTexture(normalmap, TEXTURE_NORMAL)
local baselayer = terrain:AddLayer(ground)
terrain:Fill(baselayer)
terrain:SetLayerScale(baselayer, 4)

-- Create paint material
local rocks = CreateMaterial()
diffusemap = LoadTexture("https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets/Materials/Ground/Rocks_Dirt_Ground_2k.dds")
normalmap = LoadTexture("https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets/Materials/Ground/Rocks_Dirt_Ground_2k_dot3.dds")
local dispmap = LoadTexture("https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets/Materials/Ground/Rocks_Dirt_Ground_2k_disp.dds")
rocks:SetTexture(diffusemap, TEXTURE_BASE)
rocks:SetTexture(normalmap, TEXTURE_NORMAL)
rocks:SetTexture(dispmap, TEXTURE_DISPLACEMENT)
local paintlayer = terrain:AddLayer(rocks)
terrain:SetLayerScale(paintlayer, 8)

-- Camera controls
camera:AddComponent(CameraControls)

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do
    if window:MouseDown(MOUSE_LEFT) then
        local mousepos = window:GetMousePosition()
        local pickinfo = camera:Pick(framebuffer, mousepos.x, mousepos.y)
        if pickinfo.success then
            if pickinfo.entity == terrain then
                local pos = {}
                pos.x = math.floor(pickinfo.position.x) + terrain.resolution.x / 2
                pos.y = math.floor(pickinfo.position.z) + terrain.resolution.y / 2
                local radius = 10
                for x = pos.x - radius, pos.x + radius do
                    for y = pos.y - radius, pos.y + radius do
                        local strength = 1.0 - Vec3(x, y, 0):DistanceToPoint(Vec3(pos.x, pos.y, 0)) / radius
                        if strength <= 0.0 then
                            -- Skip if strength is zero or negative
                            goto continue
                        end
                        local wt = terrain:GetLayerWeight(paintlayer, x, y)
                        wt = wt + 0.1
                        terrain:SetLayerWeight(paintlayer, x, y, wt)
                        ::continue::
                    end
                end
            end
        end
    end
    world:Update()
    world:Render(framebuffer)
end
```
