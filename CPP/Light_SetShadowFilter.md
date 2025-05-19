# Light::SetShadowFilter #
This method specifies whether a light should affect static objects, dynamic objects, or both.

## Syntax ##
- void **SetShadowFilter**( const ShadowFilter filter)

| Parameter | Description | 
| --- | --- |
| filter | Shadow filter flags, can be any combination of SHAODW_STATIC and SHADOW_DYNAMIC. |

## Example ##

![](https://raw.githubusercontent.com/Leadwerks/Documentation/master/Images/Light_SetShadowFilter.gif)

```c++
#include "pch.h"
#include "Project.h"

int main(int argc, const char* argv[])
{
	//Create window
	auto displays = GetDisplays();
	float displayscale = displays[0]->GetScale().x;
	auto window = CreateWindow(displays[0],"",0,0,1280 * displayscale,720 * displayscale);

	//Create framebuffer
	auto framebuffer = CreateFramebuffer(window);

	//Create world
	auto world = CreateWorld();

	//Create camera
	auto camera = CreateCamera(world);
	camera->SetClearColor(0.125);
	camera->Turn(35, 0, 0);
	camera->Move(0, 0, -5);

	//Create model with lots of extra polygons
	auto ground = CreateBox(world, 10, 1, 10, 4, 4);

	//Load fan model
	auto fan = LoadModel(world, "https://github.com/Leadwerks/Documentation/raw/master/Assets/Models/Fanblades/fanblades.glb");
	fan->SetRotation(90, 0, 0);
	fan->SetPosition(0, 2, 0);
	
	//Create spot light
	auto light = CreateLight(world, LIGHT_SPOT);
	light->SetColor(2, 2, 2);
	light->SetRange(10);
	light->SetRotation(90, 0, 0);
	light->SetPosition(0, 4, 0);
	light->SetShadowFilter(SHADOW_DYNAMIC);

	//Display text
	auto spritelayer = CreateSpriteLayer(world);
	camera->AddSpriteLayer(spritelayer);
	auto font = LoadFont("Fonts/arial.ttf");

	auto text = CreateText(spritelayer, font, "0 shadow polygons.", 14.0 * displayscale);
	text->SetPosition(2, 2);
	
	auto text2 = CreateText(spritelayer, font, "Press space to make the ground static.", 14.0 * displayscale);
	text2->SetPosition(2, 20 * displayscale);

	//Enable stats recording
	world->RecordStats(true);

	//Main loop
	while (!window->KeyHit(KEY_ESCAPE) and !window->Closed())
	{
		fan->Turn(0, 0, 5);

		world->Update();
		world->Render(framebuffer);

		if (window->KeyHit(KEY_SPACE))
		{
			text2->Hide();
			ground->MakeStatic();
		}

		//Display shadow polycount
		text->SetText("Shadow polygons: " + String(world->renderstats.shadowpolygons));
	}
	return 0;
}
```