# AudioFilter

Base class: [Asset](Asset.md)

This class manages sound effects that can be applied to a [speaker](Speaker.md).

| Property | Type | Description |
|---|---|---|
| [LoadAudioFilter](LoadAudioFilter.md) | Function | loads an audio filter from a file |

## Syntax

```csharp
public static Filter LoadAudioFilter(string filePath)
```

## Example

```csharp
string filePath = "filter.afl";
Filter filter = LoadAudioFilter(filePath);
```