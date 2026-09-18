# Hmd:SetOffset

Sets the offset position and rotation, for player movement.

## Syntax

- **SetOffset**([Vec3](Vec3.md) position, [Vec3](Vec3.md) rotation = Vec3(0))

| Parameter | Description |
|---|---|
| position | offset translation |
| rotation | offset rotation |

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

-- Some variables for the controller input
local position = Vec3(0, 0, 0)
local rotation = Vec3(0, 0, 0)
local pushed = { false, false }
local limit = 0.99

-- Main loop
while window:Closed() == false and window:KeyDown(KEY_ESCAPE) == false do

    -------------------------------------------------------------------------
    -- See the VRPlayer class for full locomotion support
    -------------------------------------------------------------------------
	
    -- Simple example movement on the Z axis with the left controller
    local axis = hmd.controllers[1]:GetAxis(VRAXIS_THUMBSTICK)
    if not pushed[1] then
        if axis:Length() > limit then
            pushed[1] = true
            local z = 1
            if axis.y < 0.0 then z = -1 end
            local pose = hmd:GetPose(VRPOSE_EYELEFT)
            local identity = Mat4()
            local delta = TransformVector(0, 0, z, pose, identity)
            delta.y = 0
            if delta.x ~= 0.0 or delta.y ~= 0.0 then
                delta = delta:Normalize()
            end
            position = position + delta
            hmd:SetOffset(position, rotation)
        end
    else
        if axis:Length() < 0.01 then pushed[1] = false end
    end

    -- Simple example rotation on the Y axis with the right controller
    axis = hmd.controllers[2]:GetAxis(VRAXIS_THUMBSTICK)
    if not pushed[2] then
        if axis:Length() > limit then
            pushed[2] = true

            local angle = 45
            if axis.x < 0.0 then angle = -45 end
			
            local offsetmatrix = Mat4(position, rotation, Vec3(1))
            local hmdpos = (hmd:GetPose(VRPOSE_EYELEFT)[3].xyz + hmd:GetPose(VRPOSE_EYERIGHT)[3].xyz) * 0.5
			
            -- Recenter the offset space around the headset
            local identity = Mat4()
            local relativeoffset = TransformPoint(hmdpos, identity, offsetmatrix)

            -- Rotate the offset space
            offsetmatrix[3].x = hmdpos.x
            offsetmatrix[3].z = hmdpos.z
            local rmat = Mat4(Vec3(0), Vec3(0, angle, 0), Vec3(1))
            offsetmatrix = offsetmatrix * rmat
            offsetmatrix[3].x = hmdpos.x
            offsetmatrix[3].z = hmdpos.z

            -- Shift the offset space away from the headset
            relativeoffset = TransformVector(relativeoffset, offsetmatrix, identity)
            offsetmatrix[3].x = offsetmatrix[3].x - relativeoffset.x
            offsetmatrix[3].z = offsetmatrix[3].z - relativeoffset.z
            position = offsetmatrix[3].xyz
			
            rotation.y = rotation.y + angle
            hmd:SetOffset(position, rotation)
        end
    else
        if axis:Length() < 0.01 then pushed[2] = false end
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
