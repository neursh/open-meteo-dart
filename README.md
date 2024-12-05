# Open-Meteo API SDK
A simple, fast, asynchronous Dart/Flutter package for accessing the Open-Meteo API.

All features from the [Open-Meteo API](https://open-meteo.com/en/features) have been implemented (some are limited).
Be sure to read Open Meteo's [Terms of Use](https://open-meteo.com/en/terms/) before using this package in your project.

- [Top Contributors](#top-contributors)
- [Usage & Docs](#usage--docs)
- [Known issues](#known-issues)
- [1.1.0 Migration Guide](#110-migration-guide)

## Top Contributors
 <table>
  <tr>
    <td align="center">
      <img valign="top" width="80px" src="https://avatars.githubusercontent.com/u/89086035?v=4" />
      <br>
      <a href="https://github.com/MathNerd28">MathNerd28</a>
      <br>
      <a href="https://github.com/neursh/open-meteo-dart/pulls?q=is%3Apr+author%3AMathNerd28">🛠️</a> | 💛 v1.1.0 - v2
    </td>
  </tr>
</table>

## Usage & Docs
Each of the nine features available in Open-Meteo is represented by its class: `WeatherApi`, `HistoricalApi`, `EnsembleApi`, `ClimateApi`, `MarineApi`, `AirQualityApi`, `GeocodingApi`, `ElevationApi` and `FloodApi`.

> [!NOTE]
> All inputs to the API have been adapted to Dart-friendly variables.
> Time arguments are `DateTime` objects and many parameters have enum representations.

For example, to get the hourly temperature in Celsius in London, 2 meters above sea level using `WeatherApi`, and only get information from `2024-08-10` to `2024-08-12`:

```dart
import 'package:open_meteo/open_meteo.dart';

void main() async {
  final weather = WeatherApi();
  final response = await weather.request(
    latitude: 52.52,
    longitude: 13.41,
    hourly: {WeatherHourly.temperature_2m},
    startDate: DateTime(2024, 8, 10),
    endDate: DateTime(2024, 8, 12),
    temperature_unit: TemperatureUnit.celsius,
  );
  final data = response.hourlyData[WeatherHourly.temperature_2m]!;
  final currentTemperature = data.values;

  print(currentTemperature);
}
```

In this example, the result is a `Map<DateTime, double>`:
```
{
  2024-08-08 05:00:00.000: 20.09549903869629,
  2024-08-08 06:00:00.000: 19.89550018310547,
  ...,
  2024-08-13 03:00:00.000: 18.788999557495117,
  2024-08-13 04:00:00.000: 17.288999557495117,
}
```

> [!TIP]
> In each API, there are two main methods:
> 
> - `request` returns a Dart object, and throws an exception if the API returns an error response, recommended for most use cases.
> 
> - `requestJson` returns a JSON map, containing either the data or the raw error response. This method exists solely for debugging purposes, do not use in production.

> [!NOTE]
> The `Geocoding` and `Elevation` are the two exceptions as they only have `searchJson` method available, the upstream API doesn't implement FlatBuffers.

```dart
var result = await GeocodingApi().requestJson(name: "London");
```
```dart
var result = await ElevationApi().requestJson(latitudes: [52.52], longitudes: [13.41]);
```

## Known issues
Addressed in [#16](https://github.com/neursh/open-meteo-dart/issues/16), the `Int64` type is not supported on the web platform due to Dart and Javascript differencies, and it won't be fixed for a long time.

We'll try to find a workaround for this problem. But for now, the only way for web platform to continue using the package is by using `requestJson()`.

## 1.1.0 Migration Guide
- Every API now has `Api` suffix.
```
Weather() -> WeatherApi()
```

- Except for enum variables, snake_case variables are changed to lowerCamelCase to follow Dart's standard linter rules.
```
Weather(temperature_unit: TemperatureUnit.celsius) -> WeatherApi(temperatureUnit: TemperatureUnit.celsius)
```

- `Hourly`, `Daily`, `Current` enums are no longer available, instead, each API has their own set of enums:
  - `WeatherHourly`, `WeatherDaily`, `WeatherCurrent` enums for `WeatherApi`.
  - `HistoricalHourly`, `HistoricalDaily` enums for `HistoricalApi`.
  - And so on...

- `latitude`, `longitude`, and some variables now moved to request methods, API classes only have some settings related to the formatting result:
```dart
// 1.1.0
var weather = Weather(
  latitude: 52.52,
  longitude: 13.41,
  temperature_unit: TemperatureUnit.celsius
);
var hourly = [Hourly.temperature_2m];
await weather.request(hourly: hourly);

// 2.0.0
final weather = WeatherApi(temperatureUnit: TemperatureUnit.celsius);
final response = await weather.request(
  latitude: 52.52,
  longitude: 13.41,
  hourly: {WeatherHourly.temperature_2m},
);
```

## Bugs & Pull requests
Before reporting an issue, please check Open-Meteo's docs to make sure you're calling the correct endpoint with the correct arguments.
Contributions are welcome!
