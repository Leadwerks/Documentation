# VrController:GetAxis

This method gets the current axis position of the controller.

## Syntax

- [Vec2](Vec2.md) **GetAxis**(number axis)

| Parameter | Description |
|---|---|
| axis | axis to detect, can be VRAXIS_TRIGGER, VRAXIS_THUMBSTICK, or VRAXIS_GRIP |

## Returns

Returns the current position for the specified axis.

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

-- Create visual models for controllers
local models = {}
for n = 1, 2 do
    models[n] = CreateBox(world, 0.1)
    models[n]:SetShadows(false)
    models[n]:Attach(hmd.controllers[n], VRPOSE_GRIP)
end

-- Main loop
while not window:Closed() and not window:KeyDown(KEY_ESCAPE) do

	-- Display color changes based on controller input
	local n
	for n = 1, 2 do
		
		models[n]:SetColor(0.5, 0.5, 0.5)

		-- Display thumbstick axis
		local axis = hmd.controllers[n]:GetAxis(VRAXIS_THUMBSTICK)
		if axis ~= Vec2(0) then models[n]:SetColor(axis.x * 0.5 + 0.5, axis.y * 0.5 + 0.5, 0) end
		
		-- DIsplay trigger axis
		axis = hmd.controllers[n]:GetAxis(VRAXIS_TRIGGER)
		if axis ~= Vec2(0) then models[n]:SetColor(axis.x, 0, 0) end
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
                Shutdown()
                return
            else
                Print("HMD started")
            end
        end
    end
end
```
