# Component::FireOutputs

This method is used to manually trigger any outputs that are connected to this component in the [flowgraph editor](flowgrapheditor.md).

## Syntax

- int **FireOutputs**(const WString& name);
- int **FireOutputs**(const WString& name, const std::vector<std\::any\> args);

| Parameter | Description |
|---|---|
| name | name of the output method, should match the name of the method this call is made in |
| args | optional arguments to pass to [Component::CallMethod](Component_CallMethod.md) |

## Returns

Returns the number of matching outputs that are connected to this component.
