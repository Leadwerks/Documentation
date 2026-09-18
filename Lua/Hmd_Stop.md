# Hmd:Stop

This method ends a running VR session.

## Syntax

- **Stop**()

## Remarks

At the time of this writing, SteamVR cannot start a new OpenXR session on a different framebuffer once a previous session has started and ended. This is a bug in SteamVR and has been reported to Valve.

## Example

```lua
-- Get the displays
local displays = GetDisplays()

-- Create a window
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

-- Main loop
while window:Closed() == false and window:KeyDown(KEY_ESCAPE) == false do

	-- Start and stop an OpenXR session
	if window:KeyHit(KEY_SPACE) then
		if hmd:GetState() == VRDEVICESTATE_INACTIVE then
			hmd:Start(framebuffer)
		else
			hmd:Stop()
		end
	end

    -- Update the world
    world:Update()

    -- Render the world
    world:Render(framebuffer)

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
            end
        end
    end

end
```
