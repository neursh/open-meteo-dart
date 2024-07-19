# Open-Meteo API SDK
A simple, fast, asynchronous Dart/Flutter SDK package for Open-Meteo API.

All [features from Open-Meteo API](https://open-meteo.com/en/features) are available with fully (some limited) implementation.

Read [Terms of Use](https://open-meteo.com/en/terms/) of Open Meteo before using this package.

> [!NOTE]
All parameters are shipped from the official [Open-Meteo's docs](https://open-meteo.com/en/docs#api-documentation).

> [!CAUTION]
This SDK simplified hourly and daily values in across all 7 features that needed it into 2 enum files. Remember to read the docs carefully before using it.

## Contributors
 <table>
  <tr>
    <td align="center">
      <img valign="top" width="80px" src="https://avatars.githubusercontent.com/u/89086035?v=4" />
      <br>
      <a href="https://github.com/MathNerd28">MathNerd28</a>
      <br>
      <a href="https://github.com/neursh/open-meteo-dart/pulls?q=is%3Apr+author%3AMathNerd28">🛠️</a> | 💛
    </td>
  </tr>
</table> 

## Usage & Docs
> [!NOTE]
There're 9 classes represent 9 features available in Open-Meteo API: `Weather`, `Historical`, `Ensemble`, `Climate`, `Marine`, `AirQuality`, `Geocoding`, `Elevation` and `Flood`.

> [!NOTE]
All values from API have been adapted to Flutter friendly variables. Example: Fixed point time related arguments are using `DateTime` and some options are available `enum` values specified for it.

Out of all classes, there're 7 classes that requires either daily or hourly parameter, they will all have a similar style of implementation. For example, this is how to get current temperature from London, 2 meters above sea level using `Weather`:
```dart
var weather = Weather(
  latitude: 52.52,
  longitude: 13.41,
  temperature_unit: TemperatureUnit.celsius);
var hourly = [Hourly.temperature_2m];
var result = await weather.raw_request(hourly: hourly);
```
Result:
```json
{"latitude": 52.52, "longitude": 13.419998, "generationtime_ms": 0.04506111145019531, "utc_offset_seconds": 3600, "timezone": "Europe/Berlin", "timezone_abbreviation": "CET", "elevation": 38.0, "hourly_units": {"time": "unixtime", "temperature_2m": "°C"}, "hourly": {"time": [1706223600, 1706227200, 1706230800, 1706234400, 1706238000, 1706241600, 1706245200, 1706248800, 1706252400, 1706256000, 1706259600, 1706263200, 1706266800, 1706270400, 1706274000, 1706277600, 1706281200, 1706284800, 1706288400, 1706292000, 1706295600, 1706299200, 1706302800, 1706306400, 1706310000, 1706313600, 1706317200, 1706320800, 1706324400, 1706328000, 1706331600, 1706335200, 1706338800, 1706342400, 1706346000, 1706349600, 1706353200, 1706356800, 1706360400, 1706364000, 1706367600, 1706371200, 1706374800, 1706378400, 1706382000, 1706385600, 1706389200, 1706392800, 1706396400, 1706400000, 1706403600, 1706407200, 1706410800, 1706414400, 1706418000, 1706421600, 1706425200, 1706428800, 1706432400, 1706436000, 1706439600, 1706443200, 1706446800, 1706450400, 1706454000, 1706457600, 1706461200, 1706464800, 1706468400, 1706472000, 1706475600, 1706479200, 1706482800, 1706486400, 1706490000, 1706493600, 1706497200, 1706500800, 1706504400, 1706508000, 1706511600, 1706515200, 1706518800, 1706522400, 1706526000, 1706529600, 1706533200, 1706536800, 1706540400, 1706544000, 1706547600, 1706551200, 1706554800, 1706558400, 1706562000, 1706565600, 1706569200, 1706572800, 1706576400, 1706580000, 1706583600, 1706587200, 1706590800, 1706594400, 1706598000, 1706601600, 1706605200, 1706608800, 1706612400, 1706616000, 1706619600, 1706623200, 1706626800, 1706630400, 1706634000, 1706637600, 1706641200, 1706644800, 1706648400, 1706652000, 1706655600, 1706659200, 1706662800, 1706666400, 1706670000, 1706673600, 1706677200, 1706680800, 1706684400, 1706688000, 1706691600, 1706695200, 1706698800, 1706702400, 1706706000, 1706709600, 1706713200, 1706716800, 1706720400, 1706724000, 1706727600, 1706731200, 1706734800, 1706738400, 1706742000, 1706745600, 1706749200, 1706752800, 1706756400, 1706760000, 1706763600, 1706767200, 1706770800, 1706774400, 1706778000, 1706781600, 1706785200, 1706788800, 1706792400, 1706796000, 1706799600, 1706803200, 1706806800, 1706810400, 1706814000, 1706817600, 1706821200, 1706824800], "temperature_2m": [3.9, 3.1, 2.5, 2.1, 1.6, 1.5, 1.7, 1.7, 2.0, 2.4, 3.3, 4.8, 6.1, 7.2, 7.6, 8.0, 9.0, 8.8, 7.6, 6.9, 6.0, 5.5, 5.3, 5.1, 4.7, 4.6, 4.3, 4.0, 4.1, 3.9, 3.8, 3.7, 3.7, 3.9, 4.2, 4.7, 5.2, 5.7, 6.2, 6.2, 6.0, 5.5, 5.3, 5.2, 5.0, 4.7, 4.3, 3.6, 2.9, 2.2, 1.6, 1.1, 0.5, 0.3, 0.1, -0.2, -0.5, -0.5, -0.1, 0.9, 2.6, 4.3, 6.2, 6.5, 6.1, 5.0, 4.2, 3.6, 3.1, 2.8, 2.5, 2.3, 2.1, 1.8, 1.5, 1.4, 1.3, 1.4, 1.4, 1.5, 1.5, 1.7, 2.6, 4.3, 6.1, 7.6, 8.5, 8.7, 8.1, 7.0, 6.1, 5.5, 5.0, 4.6, 4.3, 3.9, 3.7, 3.4, 3.1, 2.8, 2.6, 2.4, 2.2, 2.2, 2.3, 2.4, 2.9, 4.1, 5.7, 6.9, 7.6, 7.8, 7.8, 7.2, 6.3, 5.5, 5.1, 4.8, 4.6, 4.4, 4.3, 4.2, 4.0, 3.9, 3.7, 3.6, 3.4, 3.5, 3.8, 4.4, 5.2, 6.2, 7.4, 8.3, 7.5, 7.9, 7.9, 7.4, 6.6, 5.9, 5.7, 5.6, 5.6, 5.6, 5.6, 5.7, 6.0, 6.4, 6.8, 7.0, 7.3, 7.4, 7.3, 7.2, 7.2, 7.5, 8.1, 8.4, 8.4, 8.2, 7.9, 7.6, 7.1, 6.9, 6.9, 7.1, 7.3, 7.3]}}
```
> [!TIP]
`raw_request` will return a JSON, which is the result if nothing is wrong. Right now, this is the only way to request the API.

The only two exceptions are `Geocoding` and `Elevation`:
```dart
var result = await Geocoding.search(name: "Somewhere");
```
```dart
var result = await Elevation.search(latitudes: [52.52], longitudes: [13.41]);
```

## Bugs & Pull requests
Before issuing a problem you encounter, please make sure that you're calling to the right API with the correct arguments.

All pull requests are welcome!
