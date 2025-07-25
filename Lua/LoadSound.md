# LoadSound

## Syntax
- [Sound](Sound.md) **LoadSound**(string path)
- [Sound](Sound.md) **LoadSound**(string path, number flags)
- [Sound](Sound.md) **LoadSound**([Stream](Stream.md) stream)
- [Sound](Sound.md) **LoadSound**([Stream](Stream.md) stream, number flags)

|Parameter|Description|
|-|-|
|path|file name to load|
|stream|stream to load the file from|
|flags|optional loading flags, can be LOAD_DEFAULT or any combination of LOAD_UNMANAGED and LOAD_QUIET |

## Example

```lua
-- Get the displays
local displays = GetDisplays()

-- Create window
local window = CreateWindow("Ultra Engine", 0, 0, 800, 600, displays[1], WINDOW_TITLEBAR or WINDOW_CENTER)

-- Load sound
local sound = LoadSound("https://raw.githubusercontent.com/Leadwerks/Documentation/master/Assets/Sound/notification.wav")

-- Play sound
local speaker = CreateSpeaker()
speaker:SetSound(sound)
speaker:SetLooping(true)
speaker:Play()

while window:Closed() == false do
	if window:KeyDown(KEY_ESCAPE) then
		break
	end
end
```
