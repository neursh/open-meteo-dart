# OpenMeteo API Client
An simple, fast, asynchronous Dart/Flutter client package for OpenMeteo API

## Why?
OpenMeteo is an open-source API allows us to get weather infomations from any locations for free, no key required.

This package will let you access to OpenMeteo's API easier on Dart / Flutter!

## How to use
There are 6 classes for you to play around with OpenMeteo's API:

- `OpenMeteo`: Main class for checking and sending request to OpenMeteo's API.
    - `TemperatureUnit` | `WindspeedUnit` | `PrecipitationUnit`: Classé to provide customizations for the request.
- `Hourly` | `Daily`: Classes to specify needed infomations

Example of getting temperauture from 2 meters above sea level:
```dart
await OpenMeteo(latitude: 52.52, longitude: 13.41).raw_request(hourly: [Hourly.temperature_2m]);
```
Or:
```dart
var op = OpenMeteo(latitude: 52.52, longitude: 13.41);
var hourly = [Hourly.temperature_2m];
var res = await op.raw_request(hourly: hourly);
```
All options are shipped from the offcial [OpenMeteo's docs](https://open-meteo.com/en/docs#api-documentation)