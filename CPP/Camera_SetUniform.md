# Camera::SetUniform

This method sets a value in a post-processing shader.

## Syntax

- **SetUniform**(int index, [String](String.md) name, float value)
- **SetUniform**(int index, [String](String.md) name, int value)
- **SetUniform**(int index, [String](String.md) name, [Vec2](Vec2.md) value)
- **SetUniform**(int index, [String](String.md) name, [Vec3](Vec3.md) value)
- **SetUniform**(int index, [String](String.md) name, [Vec4](Vec4.md) value)

| Parameter | Description |
|---|---|
| index | index of the post-processing effect, returned by [Camera:AddPostEffect](Camera_AddPostEffect.md) |
| name | name of the shader uniform |
| value | value to set |
