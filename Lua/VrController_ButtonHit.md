# VrController:ButtonHit

This method gets the current button pressed state of the controller.

## Syntax

- boolean **ButtonHit**(number button)

| Parameter | Description |
|---|---|
| button | can be VRBUTTON_PRIMARY, VRBUTTON_SECONDARY, VRBUTTON_GRIP, or VRBUTTON_THUMBSTICK |

## Returns

Returns true if the specified button is pressed, otherwise false is returned.

## Example

```lua
--Get the displays
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_CLIENTCOORDS | WINDOW_CENTER | WINDOW_TITLEBAR)

--Create a framebuffer
local framebuffer = CreateFramebuffer(window)

--Create a world
local world = CreateWorld()

--Environment maps
local specmap = LoadTexture("https://github.com/UltraEngine/Assets/raw/main/Materials/Environment/footprint_court/specular.dds")
world:SetEnvironmentMap(specmap, ENVIRONMENTMAP_BACKGROUND)

--Get the VR headset
local hmd = GetHmd(world)

buttonids = {}
buttonids[VRBUTTON_A] = "A"
buttonids[VRBUTTON_B] = "B"
buttonids[VRBUTTON_MENU] = "Menu"
buttonids[VRBUTTON_GRIP] = "Grip"
buttonids[VRBUTTON_SYSTEM] = "System"
buttonids[VRBUTTON_LEFT] = "Left"
buttonids[VRBUTTON_UP] = "Up"
buttonids[VRBUTTON_RIGHT] = "Right"
buttonids[VRBUTTON_DOWN] = "Down"
buttonids[VRBUTTON_TOUCHPAD] = "Touchpad"
buttonids[VRBUTTON_TRIGGER] = "Trigger"

--Main loop
while window:Closed() == false and window:KeyDown(KEY_ESCAPE) == false do

    --Display controller input
    for n = 1, 2 do

        --Check to make sure the controller is detected
        if hmd.controllers[n] ~= nil then
            for k, v in pairs(buttonids) do

                --Check for a button hit
                if hmd.controllers[n]:ButtonHit(k) then

                    --Print the controller index and button name
                    Print("Controller "..tostring(n).." button hit: "..v)

                end
            end
        end
    end

    world:Update()
    world:Render(framebuffer)

end
```
