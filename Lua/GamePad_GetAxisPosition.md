# GamePad:GetAxisPosition

This method gets the current position of a thumbstick or trigger.

## Syntax

- [Vec2](Vec2.md) **GetAxisPosition**(number axis)

| Parameter | Description |
|---|---|
| axis | gamepad axis, can be GAMEPADAXIS_RTRIGGER, GAMEPADAXIS_LTRIGGER, GAMEPADAXIS_RSTICK, or GAMEPADAXIS_LSTICK |

## Returns

Returns the gamepad axis position.

## Example

```lua
local displays = GetDisplays()

local window = CreateWindow("Leadwerks", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

local framebuffer = CreateFramebuffer(window)

local world = CreateWorld()

local pads = GetGamePads()

--Main loop
while window:Closed() == false and window:KeyDown(KEY_ESCAPE) == false do

    if #pads > 0 then
		
		gamepad = pads[1]

		if gamepad:ButtonHit(GAMEPADBUTTON_A) then Print("A") end
		if gamepad:ButtonHit(GAMEPADBUTTON_B) then Print("B") end
		if gamepad:ButtonHit(GAMEPADBUTTON_X) then Print("X") end
		if gamepad:ButtonHit(GAMEPADBUTTON_Y) then Print("Y") end

		if gamepad:ButtonHit(GAMEPADBUTTON_DPADUP) then Print("DPAD UP") end
		if gamepad:ButtonHit(GAMEPADBUTTON_DPADDOWN) then Print("DPAD DOWN") end
		if gamepad:ButtonHit(GAMEPADBUTTON_DPADLEFT) then Print("DPAD LEFT") end
		if gamepad:ButtonHit(GAMEPADBUTTON_DPADRIGHT) then Print("DPAD RIGHT") end

		if gamepad:ButtonHit(GAMEPADBUTTON_START) then Print("START") end
		if gamepad:ButtonHit(GAMEPADBUTTON_BACK) then Print("BACK") end

		if gamepad:ButtonHit(GAMEPADBUTTON_LTHUMB) then Print("LTHUMB") end
		if gamepad:ButtonHit(GAMEPADBUTTON_RTHUMB) then Print("RTHUMB") end

		if gamepad:ButtonHit(GAMEPADBUTTON_LSHOULDER) then Print("LSHOULDER") end
		if gamepad:ButtonHit(GAMEPADBUTTON_RSHOULDER) then Print("RSHOULDER") end
	
		local axis = gamepad:GetAxisPosition(GAMEPADAXIS_RTRIGGER)
		if (axis ~= Vec2(0)) then Print("GAMEPADAXIS_RTRIGGER = " .. tostring(axis.x) .. ", " .. tostring(axis.y)) end
		axis = gamepad:GetAxisPosition(GAMEPADAXIS_LTRIGGER)
		if (axis ~= Vec2(0)) then Print("GAMEPADAXIS_LTRIGGER = " .. tostring(axis.x) .. ", " .. tostring(axis.y)) end
		axis = gamepad:GetAxisPosition(GAMEPADAXIS_RSTICK)
		if (axis ~= Vec2(0)) then Print("GAMEPADAXIS_RSTICK = " .. tostring(axis.x) .. ", " .. tostring(axis.y)) end
		axis = gamepad:GetAxisPosition(GAMEPADAXIS_LSTICK)
		if (axis ~= Vec2(0)) then Print("GAMEPADAXIS_LSTICK = " .. tostring(axis.x) .. ", " .. tostring(axis.y)) end
		
	end

  	world:Update()
    world:Render(framebuffer)

end
```
