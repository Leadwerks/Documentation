# Post-processing Effects

Let's take a look at a simple effect.

```json
{
    "posteffect":
    {
        "subpasses":
        [
            {    
                "samplers": ["PREVPASS"],
                "shader": "Shaders/PostEffects/PassThrough/PassThrough.frag"
            }
        ]
    }
}
```

Shader

```glsl
#version 450

// Samplers
uniform layout(binding = 0) sampler2D ColorBuffer;
uniform layout(binding = 15) sampler2D DitherTexture;

// Includes
#include "../../Common/Constants.glsl"
#include "../../Common/Uniforms.glsl"
#include "../../Common/Dither.glsl"

// Inputs
in vec2 TexCoords;

// Outputs
out vec4 outColor;

void main()
{
    ivec2 coord = ivec2(gl_FragCoord.x, gl_FragCoord.y);
    outColor = texelFetch(ColorBuffer, coord, 0);
	
	//Dither final pass
    if ((RenderFlags & RENDERFLAGS_FINALPASS) != 0) outColor.rgb += dither(DitherTexture);
}
```

## Dithering

The last pass the renderer draws should apply a dither effect to the screen. This applies a small amount of noise that breaks up visible banding on color gradients. Rather than waste an extra full-screen pass on this simple effect, the engine will indicate when a rendering pass is the last one by including the RENDERFLAGS_FINALPASS flags in the RenderFlags uniform. This tells the shader to apply a dither effect to the final color it outputs.

