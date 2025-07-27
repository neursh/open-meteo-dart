# Open-Meteo API SDK
A simple, fast, asynchronous Dart/Flutter package for accessing the Open-Meteo API.

All features from the [Open-Meteo API](https://open-meteo.com/en/features) have been implemented (some are limited).
Be sure to read Open Meteo's [Terms of Use](https://open-meteo.com/en/terms/) before using this package in your project.

- [Community highlights](#community-highlights)
- [Usage & Docs](#usage--docs)
- [1.x.x Migration Guide](#1xx-migration-guide)
- [Top Contributors](#top-contributors)

> [!IMPORTANT]
> The type-safe implmentation is now available on the web platform!
>
> From version `2.1.5`, the package will now provide support for Int64 type on timestamp variables for the web platform. Up to 53 bits though, but that doesn't matter, everything will be long gone before this limit hits.
>
> So yay! Web platform now no longer rely on `requestJson()` and query the response on their own anymore.

## Community highlights
A fun little spot to showcase some cool projects that people made from this package!

## Usage & Docs
Each of the ~nine~ **ten** features available in Open-Meteo is represented by its class: `WeatherApi`, `HistoricalApi`, `EnsembleApi`, `ClimateApi`, `MarineApi`, `AirQualityApi`, `SatelliteRadiationApi`, `GeocodingApi`, `ElevationApi` and `FloodApi`.

> [!NOTE]
> All inputs to the API have been adapted to Dart-friendly variables.
>
> Time arguments are `DateTime` objects and parameters have enum representations.

> [!TIP]
> In each API, there are two main methods:
> 
> - `request` uses FlatBuffer under the hood for the best performance and low overhead. Returns a Dart object and let you query information with type safety, and throws an exception if the API returns an error response, recommended for most use cases.
> 
> - `requestJson` returns a JSON map, containing either the data or the raw error response. This method exists solely for debugging purposes. Server JSON encoding on a large amount of data is not feasible and could cause a heavy load on a free service, so pls try not to use it :)

> [!CAUTION]
> This is optional, but if you can, please also provide `userAgent` to the Apis. This can allow the folks at open-meteo to get a metric on how's your app doing.
>
> Using the default headers from the package makes your app's usage got mixed with other apps, so you might be limited even though you did nothing.

For example, to get the hourly temperature in Celsius in London, 2 meters above sea level using `WeatherApi`, and only get information from `2024-08-10` to `2024-08-12`:

```dart
import 'package:open_meteo/open_meteo.dart';

void main() async {
  final weather = WeatherApi(userAgent: "My-Flutter-App");
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

> [!NOTE]
> The `Geocoding` and `Elevation` are the two exceptions as they only have `searchJson` method available, the upstream API doesn't implement FlatBuffers.

```dart
var result = await GeocodingApi().requestJson(name: "London");
```
```dart
var result = await ElevationApi().requestJson(latitudes: [52.52], longitudes: [13.41]);
```

## 1.x.x Migration Guide
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
// 1.x.x
var weather = Weather(
  latitude: 52.52,
  longitude: 13.41,
  temperature_unit: TemperatureUnit.celsius
);
await weather.request(hourly: [Hourly.temperature_2m]);

// 2.x.x
final weather = WeatherApi(temperatureUnit: TemperatureUnit.celsius);
final response = await weather.request(
  latitude: 52.52,
  longitude: 13.41,
  hourly: {WeatherHourly.temperature_2m},
);
```

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

## Issues & Pull requests
Before reporting an issue, please check Open-Meteo's docs to make sure you're calling the correct endpoint with the correct arguments.

There's a method to check the URL that the package generated to send the request:
```dart
final weather = WeatherApi();
final response = await weather.request(
  latitude: 52.52,
  longitude: 13.41,
  hourly: {WeatherHourly.temperature_2m},
);

print(response.urlUsed); // https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m&timeformat=unixtime&timezone=auto&format=flatbuffers
```

Contributions are welcome!
