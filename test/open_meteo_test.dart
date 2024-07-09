import 'package:open_meteo/open_meteo.dart';
import 'package:test/test.dart';

void main() {
  group('Weather Forecast API checks', () {
    var weather = Weather(
        latitude: 52.52,
        longitude: 13.41,
        temperature_unit: TemperatureUnit.celsius);
    var hourly = [Hourly.temperature_2m];
    var daily = [Daily.temperature_2m_max];
    var current = [Current.temperature_2m];
    test('Hourly temperature from current time.', () async {
      var result = await weather.raw_request(hourly: hourly);
      expect(result['error'], isNot(true));
      expect(result['hourly'], isNot(null));
      expect(result['hourly']['time'].length,
          result['hourly']['temperature_2m'].length);
    });
    test('Daily temperature from current time.', () async {
      var result = await weather.raw_request(daily: daily);
      expect(result['error'], isNot(true));
      expect(result['daily'], isNot(null));
      expect(result['daily']['time'].length,
          result['daily']['temperature_2m_max'].length);
    });
    test('Current temperature.', () async {
      var result = await weather.raw_request(current: current);
      expect(result['error'], isNot(true));
      expect(result['current'], isNot(null));
    });

    test('Combined from all options', () async {
      var result = await weather.raw_request(
          hourly: hourly, daily: daily, current: current);
      expect(result['error'], isNot(true));
      expect(result['hourly'], isNot(null));
      expect(result['hourly']['time'].length,
          result['hourly']['temperature_2m'].length);
      expect(result['daily'], isNot(null));
      expect(result['daily']['time'].length,
          result['daily']['temperature_2m_max'].length);
      expect(result['current'], isNot(null));
    });
  });

  group('Historical Forecast API checks', () {
    var historical = Historical(
        latitude: 52.52,
        longitude: 13.41,
        start_date: DateTime(2022, 1, 1),
        end_date: DateTime(2022, 1, 2),
        temperature_unit: TemperatureUnit.celsius);
    var hourly = [Hourly.temperature_2m];
    var daily = [Daily.temperature_2m_max];
    test('Hourly temperature', () async {
      var result = await historical.raw_request(hourly: hourly);
      expect(result['error'], isNot(true));
      expect(result['hourly'], isNot(null));
      expect(result['hourly']['time'].length,
          result['hourly']['temperature_2m'].length);
    });
    test('Daily temperature.', () async {
      var result = await historical.raw_request(daily: daily);
      expect(result['error'], isNot(true));
      expect(result['daily'], isNot(null));
      expect(result['daily']['time'].length,
          result['daily']['temperature_2m_max'].length);
    });
    test('Combined from all options', () async {
      var result = await historical.raw_request(hourly: hourly, daily: daily);
      expect(result['error'], isNot(true));
      expect(result['hourly'], isNot(null));
      expect(result['hourly']['time'].length,
          result['hourly']['temperature_2m'].length);
      expect(result['daily'], isNot(null));
      expect(result['daily']['time'].length,
          result['daily']['temperature_2m_max'].length);
    });
  });

  group('Ensemble API checks', () {
    var ensemble = Ensemble(latitude: 52.52, longitude: 13.41);
    var models = [EnsembleModel.icon_seamless];
    var hourly = [Hourly.temperature_2m];
    test('Hourly temperature', () async {
      var result = await ensemble.raw_request(models: models, hourly: hourly);
      expect(result['error'], isNot(true));
      expect(result['hourly'], isNot(null));
      expect(result['hourly']['time'].length,
          result['hourly']['temperature_2m'].length);
    });
  });

  group('Climate API checks', () {
    var climate = Climate(
      latitude: 52.52,
      longitude: 13.41,
      start_date: DateTime(2022, 1, 1),
      end_date: DateTime(2022, 1, 2),
    );
    var models = [ClimateModel.CMCC_CM2_VHR4];
    var daily = [Daily.temperature_2m_max];
    test('Daily temperature', () async {
      var result = await climate.raw_request(models: models, daily: daily);
      print(result);
      expect(result['error'], isNot(true));
      expect(result['daily'], isNot(null));
      expect(result['daily']['time'].length,
          result['daily']['temperature_2m_max'].length);
    });
  });

  group('Marine Weather API checks', () {
    var marine = Marine(latitude: 54.544587, longitude: 10.227487);
    var hourly = [Hourly.wave_height];
    var daily = [Daily.wave_height_max];
    var current = [Current.wave_height];

    test('Hourly wave height from current time.', () async {
      var result = await marine.raw_request(hourly: hourly);
      expect(result['error'], isNot(true));
      expect(result['hourly'], isNot(null));
      expect(result['hourly']['time'].length,
          result['hourly']['wave_height'].length);
    });
    test('Daily wave height from current time.', () async {
      var result = await marine.raw_request(daily: daily);
      expect(result['error'], isNot(true));
      expect(result['daily'], isNot(null));
      expect(result['daily']['time'].length,
          result['daily']['wave_height_max'].length);
    });
    test('Current wave height.', () async {
      var result = await marine.raw_request(current: current);
      expect(result['error'], isNot(true));
      expect(result['current'], isNot(null));
    });

    test('Combined from all options', () async {
      var result = await marine.raw_request(
          hourly: hourly, daily: daily, current: current);
      expect(result['error'], isNot(true));
      expect(result['hourly'], isNot(null));
      expect(result['hourly']['time'].length,
          result['hourly']['wave_height'].length);
      expect(result['daily'], isNot(null));
      expect(result['daily']['time'].length,
          result['daily']['wave_height_max'].length);
      expect(result['current'], isNot(null));
    });
  });

  group('Air Quality API checks', () {
    var airQuality = AirQuality(latitude: 52.52, longitude: 13.41);
    var hourly = [Hourly.pm10];
    var current = [Current.pm10];

    test('Hourly air quality from current time.', () async {
      var result = await airQuality.raw_request(hourly: hourly);
      expect(result['error'], isNot(true));
      expect(result['hourly'], isNot(null));
      expect(result['hourly']['time'].length, result['hourly']['pm10'].length);
    });

    test('Current air quality.', () async {
      var result = await airQuality.raw_request(current: current);
      expect(result['error'], isNot(true));
      expect(result['current'], isNot(null));
    });

    test('Combined from all options', () async {
      var result =
          await airQuality.raw_request(hourly: hourly, current: current);
      expect(result['error'], isNot(true));
      expect(result['hourly'], isNot(null));
      expect(result['hourly']['time'].length, result['hourly']['pm10'].length);
      expect(result['current'], isNot(null));
    });
  });

  group('Geocoding API checks', () {
    test('Look for Berlin', () async {
      var result = await Geocoding.search(name: 'Berlin', language: 'en');
      expect(result['error'], isNot(true));
      expect(result['results'][0]['name'], 'Berlin');
    });
  });

  group('Elevation API checks', () {
    test('Check elevation', () async {
      var result =
          await Elevation.search(latitudes: [52.52], longitudes: [13.41]);
      expect(result['error'], isNot(true));
      expect(result['elevation'][0], 38);
    });
  });
}
