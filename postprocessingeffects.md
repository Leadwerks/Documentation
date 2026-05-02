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
layout(binding = 0) uniform sampler2D ColorBuffer;

// Inputs
in vec2 TexCoords;

// Outputs
out vec4 outColor;

void main()
{
    ivec2 coord = ivec2(gl_FragCoord.x, gl_FragCoord.y);
    outColor = texelFetch(ColorBuffer, coord, 0);
}
```
