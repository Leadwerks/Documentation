# Entity:Attach

This method attaches an entity to a model bone or a navigation agent. This provides a way of "gluing" an entity to a non-entity object.

## Syntax

- **Entity:Attach**(agent: [NavAgent](NavAgent))
- **Entity:Attach**(model: [Model](Model), bone: [Bone](Bone))

| Parameter | Description |
| --- | --- |
| agent | navigation agent to attach entity to |
| model | model to attach entity to |
| bone | skeleton bone to attach entity to |

## Returns

Returns true if the attachment is valid, otherwise false is returned.

## Remarks

For bone attachments, the bone must belong to the skeleton the model is currently using.

The entity's local orientation at the time this method is called will be used to orient around the attachment.

A bone's scale will be disregarded in the entity placement.

## Example

This example will load an animated model and add some headgear to keep him warm.

![Example image](https://raw.githubusercontent.com/UltraEngine/Documentation/master/Images/entity_attach.jpg)

```lua
-- Create a window
local displays = GetDisplays()
local window = CreateWindow("Ultra Engine", 0, 0, 1280, 720, displays[1], WINDOW_CENTER | WINDOW_TITLEBAR)

-- Create a framebuffer
local framebuffer = CreateFramebuffer(window)

-- Create a world
local world = CreateWorld()

-- Create a camera
local camera = CreateCamera(world)
camera:SetClearColor(0.125)
camera:SetFov(70)
camera:Move(0, 2, -8)

-- Create light
local light = CreateBoxLight(world)
light:SetRotation(45, 35, 0)
light:SetRange(-10, 10)

-- Model by PixelMannen
-- https://opengameart.org/content/fox-and-shiba
local model = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Characters/Fox.glb")
model:SetScale(0.05)
model:Animate(1)
model:SetRotation(0, -90, 0)

local neck = model.skeleton:FindBone("b_Neck_04")
local head = model.skeleton:FindBone("b_Head_05")
local rotation = Vec3(0)

-- Model by alissvetlana
-- https://sketchfab.com/3d-models/hat-a7f54e87bea94730b4a1827ec1f770df
local hat = LoadModel(world, "https://github.com/UltraEngine/Documentation/raw/master/Assets/Models/Characters/hat.glb")
hat:SetScale(0.025)
hat:SetPosition(-0.3, 0.4, 0)
hat:Attach(model, head)

-- Main loop
while window:Closed() == false and window:KeyHit(KEY_ESCAPE) == false do
    world:Update()

    rotation.y = Cos(Millisecs() / 10.0) * 65.0
    neck:SetRotation(rotation)

    world:Render(framebuffer)
end
```
