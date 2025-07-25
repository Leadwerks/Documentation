# CreateSpeaker

This function creates a new speaker object.

## Syntax

- [Speaker](Speaker.md) CreateSpeaker([Sound](Sound.md))

| Parameter | Description |
|---|---|
| sound | sound to set |

## Returns

Returns a new speaker.

## Example

```lua
local displays = GetDisplays()

local window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[1], WINDOW_TITLEBAR | WINDOW_CENTER)

local sound = LoadSound("https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets/Sound/notification.wav")

local speaker = CreateSpeaker(sound)

while not (window:Closed() or window:KeyDown(KEY_ESCAPE)) do
    if window:KeyHit(KEY_SPACE) then
        speaker:Play()
    end
    Sleep(16)
end
```
