# Speaker:SetFilter

This method adds an audio filter to the speaker.

## Syntax

- **Speaker:SetFilter**(AudioFilter filter, number index = 0)

### Parameters

| Parameter | Description |
|---|---|
| filter | audio filter to set |
| index | sound effect index to use, for multiple filters |

## Example

```lua
--Get the displays
local displays = GetDisplays()

--Create a window
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_CENTER + WINDOW_TITLEBAR)

--Create a world
local world = CreateWorld()

--Create a framebuffer
local framebuffer = CreateFramebuffer(window)

--Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetFov(70)
camera:SetPosition(0, 0, -3)
camera:Listen()

--Create a light
local light = CreateBoxLight(world)
light:SetRotation(35, 45, 0)
light:SetRange(-10, 10)

--Create a box
local box = CreateBox(world)
box:SetColor(0, 0, 1)

--Sound
local sound = LoadSound("https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets/Sound/notification.wav")
local speaker = CreateSpeaker(sound)
speaker:SetLooping(true)
speaker:SetPosition(box:GetPosition(true))
speaker:Play()
speaker:SetRange(10)

--Main loop
while window:Closed() == false and window:KeyDown(KEY_ESCAPE) == false do

    --Add filter when space key is pressed
    if window:KeyHit(KEY_SPACE) then
        speaker:SetFilter(AUDIOFILTER_REVERB_SEWERPIPE)
    end

    --Move and turn with the arrow keys - best experienced with headphones
    if window:KeyDown(KEY_UP) then
        camera:Move(0, 0, 0.1)
    end
    if window:KeyDown(KEY_DOWN) then
        camera:Move(0, 0, -0.1)
    end
    if window:KeyDown(KEY_LEFT) then
        camera:Turn(0, -1, 0)
    end
    if window:KeyDown(KEY_RIGHT) then
        camera:Turn(0, 1, -0)
    end

    world:Update()
    world:Render(framebuffer)
end

return 0
```
