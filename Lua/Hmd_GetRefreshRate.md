# Hmd:GetRefreshRate

This method returns the headset refresh rate.

## Syntax

- number **GetRefreshRate**()

## Returns

Returns the headset refresh rate, in frames per second.

```lua
-- Get the displays
local displays = GetDisplays()

-- Create a window (Lua uses 1-based indexing, so displays[1] replaces displays[0])
local window = CreateWindow("Leadwerks", 0, 0, 1280 * displays[1].scale, 720 * displays[1].scale, displays[1], WINDOW_CLIENTCOORDS | WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create a framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create a world
local world = CreateWorld()

-- Get the VR headset
local hmd = GetHmd(world)
hmd:Start(framebuffer)

-- Environment maps
local specmap = LoadTexture("Materials/Environment/Default/specular.dds")
local diffmap = LoadTexture("Materials/Environment/Default/diffuse.dds")
local skymap = LoadTexture("Materials/Environment/Default/skybox.dds")
world:SetEnvironmentMap(skymap, ENVIRONMENTMAP_BACKGROUND)
world:SetEnvironmentMap(specmap, ENVIRONMENTMAP_SPECULAR)
world:SetEnvironmentMap(diffmap, ENVIRONMENTMAP_DIFFUSE)

-- Create a light
local light = CreateBoxLight(world)
light:SetRotation(55, 35, 0)
light:SetRange(-10, 10)
light:SetArea(15, 15)

-- Add a floor
local floor = CreateBox(world, 10, 1, 10)
floor:SetPosition(0, -0.5, 0)
floor:SetColor(0.5, 0.5, 0.5)

-- Default update frequency, before the HMD initializes
local frequency = 60

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do
	
    -- Update the world in sync with the headset frequency
    world:Update(frequency)
	
    -- Render the world with one synced frame
    world:Render(framebuffer, true, 1)
	
    -- Evaluate HMD events
    while PeekEvent() do
        local ev = WaitEvent()
        if ev.id == EVENT_VRSTART then
			
            -- Session has started
            if ev.data == 0 then
                Notify("HMD failed to start\n\n" .. ev.text, "OpenXR Error", true)
                return
            else
                Print("HMD started")
                frequency = hmd:GetRefreshRate()
            end
			
        end
    end
end
```
