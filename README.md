# Open-Meteo API SDK
A simple, fast, asynchronous Dart/Flutter package for accessing the Open-Meteo API.

All features from the [Open-Meteo API](https://open-meteo.com/en/features) are implemented (some limited).
Be sure to read Open Meteo's [Terms of Use](https://open-meteo.com/en/terms/) before using this package in your project.

> [!NOTE]
All weather parameters have been copied from the official [Open-Meteo docs](https://open-meteo.com/en/docs#api-documentation).

> [!CAUTION]
This package combines weather parameters from 7 of the endpoints into 3 enums (`Current`, `Hourly`, `Daily`) to reduce code duplication.
Check the Open-Meteo docs to ensure your parameters are valid for the endpoint you're calling.

## Top Contributors
 <table>
  <tr>
    <td align="center">
      <img valign="top" width="80px" src="https://avatars.githubusercontent.com/u/89086035?v=4" />
      <br>
      <a href="https://github.com/MathNerd28">MathNerd28</a>
      <br>
      <a href="https://github.com/neursh/open-meteo-dart/pulls?q=is%3Apr+author%3AMathNerd28">🛠️</a> | 💛 v1.1.0
    </td>
  </tr>
</table>

## Usage & Docs
Each of the nine features available in Open-Meteo is represented by its own class: `Weather`, `Historical`, `Ensemble`, `Climate`, `Marine`, `AirQuality`, `Geocoding`, `Elevation` and `Flood`.

For example, to get the hourly temperature in London, 2 meters above sea level using `Weather`:

> [!NOTE]
All inputs to the API have been adapted to Dart-friendly variables.
Time arguments are `DateTime` objects, and many parameters have enum representations.

```dart
Weather weather = Weather(
  latitude: 52.52,
  longitude: 13.41,
  temperature_unit: TemperatureUnit.celsius,
);
WeatherResponse result = await weather.request(
  hourly: [Hourly.temperature_2m],
);
WeatherParameterData? temperature =
    result.hourlyWeatherData?[Hourly.temperature_2m];
double? currentTemperature = temperature?.data?.values.first;
```

> [!TIP]
> - `request` returns a Dart object, and throws an exception if the API returns an error response, recommended for most use cases.
> 
> - `raw_request` returns a JSON map, containing either the data or the raw error response. This method exists solely for debug purposes, do not use in production.

> [!NOTE]
> The `Geocoding` and `Elevation` endpoints use static methods instead of first constructing an instance of that object.
> 
> Additionally, they only have a `search` method available, returning a JSON map because the upstream API doesn't implement FlatBuffers.

```dart
var result = await Geocoding.search(name: "Somewhere");
```
```dart
var result = await Elevation.search(latitudes: [52.52], longitudes: [13.41]);
```

## Bugs & Pull requests
Before reporting an issue, please check Open-Meteo's docs to make sure you're calling the correct endpoint with the correct arguments.
Contributions are welcome!
