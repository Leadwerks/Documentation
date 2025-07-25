# Sound:Play

This method plays a sound once and returns a speaker object.

- **Play**()

## Returns

Returns a new speaker object that can be used to control the sound.

## Example

```lua
--Get the displays
local displays = GetDisplays();

--Create window
local window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[1], WINDOW_TITLEBAR | WINDOW_CENTER);

-- Load sound
local sound = LoadSound("https://raw.githubusercontent.com/UltraEngine/Documentation/master/Assets/Sound/notification.wav")
sound:Play()

while window:Closed() == false and window:KeyDown(KEY_ESCAPE) == false do
    -- Play sound when space key is pressed
    if window:KeyHit(KEY_SPACE) then
        sound:Play()
    end
    Sleep(16)
end
```
