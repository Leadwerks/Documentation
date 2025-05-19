# Entity:Staticize

This method makes the entity static. A static entity cannot move and can be much more efficient to render. This operation is one-way and cannot be reversed.

## Syntax

- **Staticize**()

## Example

This example shows how a scene can be optimized to make non-moving objects static, resulting in a lower shadow polygon count. In large scenes with many lights this can result in a large reduction of rendered polygons and faster performance.

![Staticize Example](https://github.com/UltraEngine/Documentation/raw/master/Images/API_Entity_MakeStatic.gif)

```lua
-- Get information about available displays
local displays = GetDisplays()

-- Create a window with specified properties
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_TITLEBAR | WINDOW_CENTER)

-- Create a framebuffer associated with the window
local framebuffer = CreateFramebuffer(window)

-- Create a world to hold 3D objects
local world = CreateWorld()
world:SetAmbientLight(0.1)
world:RecordStats(true)

-- Create a camera in the world
local camera = CreateCamera(world)
camera:SetClearColor(0.25)
camera:SetPosition(0, 2, 0)
camera:Move(0, 0, -5)

-- Load a 3D model of a tunnel
local tunnel = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Underground/tunnel_t.glb")
tunnel:SetRotation(0, 180, 0)
tunnel:Staticize()

-- Load a 3D model of a cage
local cage = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Underground/fancage.glb")
cage:Staticize()

-- Load a 3D model of fan blades and add a rotating motion component
local fan = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Underground/fanblades.glb")
fan:SetPosition(0, 2, 0)
require "Components/Motion/Mover"
local mover = fan:AddComponent(Mover)
mover.rotationspeed.z = 300

-- Create a point light source in the world
local light = CreatePointLight(world)
light:SetColor(2, 2, 2)
light:SetRange(10)
light:SetPosition(0, 2, 2)
light:SetColor(4.0)

-- Create an orthographic camera for rendering text
local orthocam = CreateCamera(world, PROJECTION_ORTHOGRAPHIC)
orthocam:SetClearMode(CLEAR_DEPTH)
orthocam:SetRenderLayers(128)
orthocam:SetPosition(framebuffer.size.x * 0.5, framebuffer.size.y * 0.5, 0)

-- Load a font for rendering text
local font = LoadFont("Fonts/arial.ttf")

-- Create a text sprite to display shadow polygon information
local text = CreateSprite(world, font, "Shadow polygons: 0", 14.0 * displays[1].scale)
text:SetPosition(2, framebuffer.size.y - 16.0 * displays[1].scale, 0)
text:SetRenderLayers(128)

-- Create another text sprite with instructions
local text2 = CreateSprite(world, font, "Press space to make the light static.", 14.0 * displays[1].scale)
text2:SetPosition(2, framebuffer.size.y - 16.0 * 2.0 * displays[1].scale, 0)
text2:SetRenderLayers(128)

-- Main loop: Update and render the world until the window is closed or the ESC key is pressed
while not window:KeyHit(KEY_ESCAPE) and not window:Closed() do
    world:Update()  -- Update the world and its objects
    world:Render(framebuffer)  -- Render the world to the framebuffer

    -- Check for a key press to make the light static
    if window:KeyHit(KEY_SPACE) then
        light:Staticize()
        text2:SetHidden(true)  -- Hide the instruction text
    end

    -- Update the text to display the number of shadow polygons
    text:SetText("Shadow polygons: " .. tostring(world.renderstats.shadowpolygons))
end
```
