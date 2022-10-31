# JSON Path

## Basic

### Attributes

```json
{
  "vehicles": {
    "car": {
      "color": "blue",
      "price": 20000
    },
    "bus": {
      "color": "white",
      "price": 20000
    }
  }
}
```

```jsonpath
$.vehicles.car
$.vehicles.bus.color
```

### Lists

```json
[
  "car",
  "bus",
  "truck"
]
```

```jsonpath
$[0]
$[0,2]
```

## Criteria

```json
[12, 43, 23, 12, 56, 43]
```

```jsonpath
$[?(@ > 40)]
$[?(@ == 12)]
$[?(@ != 12)]
$[?(@ in [40, 35])]
$[?(@ nin [40, 35])]
```

## Wild Card

```json
{
  "vehicles": {
    "car": {
      "color": "blue",
      "price": 20000
    },
    "bus": {
      "color": "white",
      "price": 20000
    }
  }
}
```

```jsonpath
$.*.color
$.*.price
```

```json
[
  {
    "model": "ABC",
    "location": "front"
  },
  {
    "model": "DEF",
    "location": "back"
  }
]
```

```jsonpath
$[*].model
$[*].location
```
