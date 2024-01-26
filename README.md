# Open-Meteo Weather Forecast API
A simple, fast, asynchronous Dart/Flutter client package for Open-Meteo Weather Forecast API.

## Why?
Open-Meteo is an open-source API that allows us to get weather infomations from any locations for free, no key required.

This package will let you access to Open-Meteo Weather Forecast API easier on Dart / Flutter!

## How to use
There are 4 classes and 2 enums for you to play around with OpenMeteo's API:

- `OpenMeteo`: Main class for checking and sending request to OpenMeteo's API.
    - `TemperatureUnit` | `WindspeedUnit` | `PrecipitationUnit`: Classes to provide customizations for the request.
- `Hourly` | `Daily`: Enums to specify needed informations.

Example of getting temperature from 2 meters above sea level:
```dart
await OpenMeteo(latitude: 52.52, longitude: 13.41).raw_request(hourly: [Hourly.temperature_2m]);
```
Or:
```dart
var op = OpenMeteo(latitude: 52.52, longitude: 13.41);
var hourly = [Hourly.temperature_2m];
var res = await op.raw_request(hourly: hourly);
```
All parameters are shipped from the offcial [OpenMeteo's docs](https://open-meteo.com/en/docs#api-documentation)