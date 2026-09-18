# VrController:GetTouch

This method gets the current touch state of the controller.

## Syntax

- boolean **GetTouch**(number surface)

| Parameter | Description |
|---|---|
| surface | can be VRTOUCH_PRIMARY, VRTOUCH_SECONDARY, VRTOUCH_TRIGGER, or VRTOUCH_THUMBSTICK |

## Returns

Returns true if the specified surface is touched, otherwise false is returned.

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
    for n = 1, 2 do
        models[n]:SetColor(0.5, 0.5, 0.5)
        if hmd.controllers[n]:GetTouch(VRTOUCH_PRIMARY) then 
            models[n]:SetColor(1, 0, 0) 
        end
        if hmd.controllers[n]:GetTouch(VRTOUCH_SECONDARY) then 
            models[n]:SetColor(0, 1, 0) 
        end
        if hmd.controllers[n]:GetTouch(VRTOUCH_TRIGGER) then 
            models[n]:SetColor(0, 0, 1) 
        end
        if hmd.controllers[n]:GetTouch(VRTOUCH_THUMBSTICK) then 
            models[n]:SetColor(1, 0.5, 0) 
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
