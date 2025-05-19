# Skeleton:AddHook

## Syntax
- **AddHook**(sequence, frame, hook)

## Example

```lua
-- Get the displays
local displays = GetDisplays()

-- Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create a world
local world = CreateWorld()

-- Create a framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125);
camera:SetFov(70);
camera:Move(0, 2, -8);

--Create light
local light = CreateBoxLight(world);
light:SetRotation(45, 35, 0);
light:SetRange(-10, 10);
light:SetArea(20, 20);

--Create ground
auto ground = CreateBox(world, 10, 1, 10)
ground:SetColor(0, 1, 0)
ground:SetPosition(0, -0.5, 0)

--Load a model
local model = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Characters/Fox.glb")
model:SetScale(0.05)
model:SetRotation(0, -90, 0)
model:Animate(1)

function Hook(skeleton, extra)
    local entity = Entity(extra)
    entity:SetColor(Random(), Random(), Random())
end

--Add an animation callback function
model:skeleton:AddHook(1, 0, Hook, model)

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do
    world:Update()
    world:Render(framebuffer)
end
```
