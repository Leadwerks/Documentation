# VrDevice:GetState

This method returns the current state of the device.

## Syntax

number **GetState**()

## Returns

VRDEVICESTATE_INACTIVE is returned if the device is not detected.

VRDEVICESTATE_STARTING is returned if the device is an [Hmd](Hmd.md) and is currently starting up.

VRDEVICESTATE_IDLE is returned for devices that are detected but not currently in use by the player.

VRDEVICESTATE_ACTIVE is returned for devices that are currently in use by the player.

## Example

```lua
-- Helper function for state names
local function StateName(state)
    if state == VRDEVICESTATE_STARTING then return "Starting" end
    if state == VRDEVICESTATE_ACTIVE then return "Active" end
    if state == VRDEVICESTATE_IDLE then return "Idle" end
    return "Inactive"
end

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

local state = { VRDEVICESTATE_INACTIVE, VRDEVICESTATE_INACTIVE, VRDEVICESTATE_INACTIVE }

-- Main loop
while window:Closed() == false and window:KeyDown(KEY_ESCAPE) == false do

    -- Get headset state
    local currentstate = hmd:GetState()
    if currentstate ~= state[1] then
        state[1] = currentstate
        Print("Headset state: " .. StateName(currentstate))
    end

    -- Get left controller state
    currentstate = hmd.controllers[1]:GetState()
    if currentstate ~= state[2] then
        state[2] = currentstate
        Print("Left controller state: " .. StateName(currentstate))
    end

    -- Get right controller state
    currentstate = hmd.controllers[2]:GetState()
    if currentstate ~= state[3] then
        state[3] = currentstate
        Print("Right controller state: " .. StateName(currentstate))
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
                Print("Hmd started")
            end
        end
    end

end
```
