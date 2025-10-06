# Open-Meteo API SDK
A free, silly, all-in-one API SDK to forecast weather, air quality, climate change, and many more by OpenMeteo with full typed support!

All features from the [Open-Meteo API](https://open-meteo.com/en/features) have been implemented (some are limited).
Be sure to read Open Meteo's [Terms of Use](https://open-meteo.com/en/terms/) before using this package in your project.

- [Community highlights](#community-highlights)
- [Usage & Docs](#usage--docs)
- [Migration Guide](#migration-guide)
- [Top Contributors](#top-contributors)

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

For example, to get the hourly temperature in Celsius in Vietnam, 2 meters above sea level using `WeatherApi`, and only get information from `2025-10-01` to `2025-10-06`:

```dart
import 'package:open_meteo/open_meteo.dart';

void main() async {
  final weather = WeatherApi(
    userAgent: "My-Flutter-App",
    temperatureUnit: TemperatureUnit.celsius,
  );
  final response = await weather.request(
    locations: {
      OpenMeteoLocation(
        latitude: 16.16667,
        longitude: 107.83333,
        startDate: DateTime(2025, 10, 1),
        endDate: DateTime(2025, 10, 6),
      )
    },
    hourly: {WeatherHourly.temperature_2m},
  );
  final data = response.segments[0].hourlyData[WeatherHourly.temperature_2m]!;
  final temperatures = data.values;

  print(temperatures);
}
```

In this example, the result is a `Map<DateTime, double>`:
```
{
  2025-10-01 00:00:00.000: 19.502498626708984, 
  2025-10-01 01:00:00.000: 19.202499389648438,
  ...,
  2025-10-06 22:00:00.000: 20.10249900817871,
  2025-10-06 23:00:00.000: 19.552499771118164,
}
```

To get the hourly temperature in Celsius in Vietnam and Berlin, 2 meters above sea level using `WeatherApi`, and only get information from `2025-10-01` to `2025-10-06`:

```dart
import 'package:open_meteo/open_meteo.dart';

void main() async {
  final weather = WeatherApi(
    userAgent: "My-Flutter-App",
    temperatureUnit: TemperatureUnit.celsius,
  );
  final response = await weather.request(
    locations: {
      OpenMeteoLocation(
        latitude: 16.16667,
        longitude: 107.83333,
        startDate: DateTime(2025, 10, 1),
        endDate: DateTime(2025, 10, 6),
      ),
      OpenMeteoLocation(
        latitude: 52.52,
        longitude: 13.41,
        startDate: DateTime(2025, 10, 1),
        endDate: DateTime(2025, 10, 6),
      ),
    },
    hourly: {WeatherHourly.temperature_2m},
  );
  final vnData = response.segments[0].hourlyData[WeatherHourly.temperature_2m]!;
  final vnTemperatures = vnData.values;
  print("Vietnam's temperature:");
  print(vnTemperatures);

  final blData = response.segments[1].hourlyData[WeatherHourly.temperature_2m]!;
  final blTemperatures = blData.values;
  print("Berlin's temperature:");
  print(blTemperatures);
}
```

In this example, the result is two `Map<DateTime, double>`, its position is accordance to the elements in `locations` passed:
```
Vietnam's temperature:
{
  2025-10-01 00:00:00.000: 19.502498626708984, 
  2025-10-01 01:00:00.000: 19.202499389648438,
  ...,
  2025-10-06 22:00:00.000: 20.10249900817871,
  2025-10-06 23:00:00.000: 19.552499771118164
}
Berlin's temperature:
{
  2025-10-01 05:00:00.000: 8.845499992370605,
  2025-10-01 06:00:00.000: 8.245499610900879,
  ...,
  2025-10-07 03:00:00.000: 11.795499801635742,
  2025-10-07 04:00:00.000: 11.245499610900879
}
```

> [!NOTE]
> The `Geocoding` and `Elevation` are the two exceptions as they only have `requestJson` method available, the upstream API doesn't implement FlatBuffers.

```dart
var result = await GeocodingApi().requestJson(name: "London");
```
```dart
var result = await ElevationApi().requestJson(latitudes: [16.16667], longitudes: [107.83333]);
```

## Migration Guide
Initialize and call request:
```dart
// 1.x.x
var weather = Weather(
  latitude: 16.16667,
  longitude: 107.83333,
  temperature_unit: TemperatureUnit.celsius
);
await weather.request(hourly: [Hourly.temperature_2m]);

// 2.x.x
final weather = WeatherApi(temperatureUnit: TemperatureUnit.celsius);
final response = await weather.request(
  latitude: 16.16667,
  longitude: 107.83333,
  hourly: {WeatherHourly.temperature_2m},
);

// 3.x.x
final weather = WeatherApi(temperatureUnit: TemperatureUnit.celsius);
final response = await weather.request(
  locations: {
    OpenMeteoLocation(latitude: 16.16667, longitude: 107.83333),
  },
  hourly: {WeatherHourly.temperature_2m},
);
```

Get a single result from a single segmented response:
```dart
// 1.x.x & 2.x.x
response.hourlyData[WeatherHourly.temperature_2m]!;

// 3.x.x
response.segments[0].hourlyData[WeatherHourly.temperature_2m]!;
```

Get multiple results from a multiple segmented response:
```dart
// 1.x.x & 2.x.x
// Not supported, requires multiple calls.

// 3.x.x
response.segments[0].hourlyData[WeatherHourly.temperature_2m]!;
response.segments[1].hourlyData[WeatherHourly.temperature_2m]!;
response.segments[...].hourlyData[WeatherHourly.temperature_2m]!;
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
  latitude: 16.16667,
  longitude: 107.83333,
  hourly: {WeatherHourly.temperature_2m},
);

print(response.urlUsed); // https://api.open-meteo.com/v1/forecast?latitude=16.16667&longitude=107.83333&hourly=temperature_2m&timeformat=unixtime&timezone=auto&format=flatbuffers
```

Contributions are welcome!
