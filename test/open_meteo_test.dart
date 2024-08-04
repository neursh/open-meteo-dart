import 'package:open_meteo/open_meteo.dart';
import 'package:test/test.dart';

void main() {
  group('Ensemble API checks', () {
    var ensemble = Ensemble(latitude: 52.52, longitude: 13.41);
    var models = [EnsembleModel.icon_seamless];
    var hourly = [Hourly.temperature_2m];
    test('Hourly temperature', () async {
      var result = await ensemble.requestJson(models: models, hourly: hourly);
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
      startDate: DateTime(2022, 1, 1),
      endDate: DateTime(2022, 1, 2),
    );
    var models = [ClimateModel.CMCC_CM2_VHR4];
    var daily = [Daily.temperature_2m_max];
    test('Daily temperature', () async {
      var result = await climate.rawRequest(models: models, daily: daily);
      expect(result['error'], isNot(true));
      expect(result['daily'], isNot(null));
      expect(result['daily']['time'].length,
          result['daily']['temperature_2m_max'].length);
    });
  });

  group('Air Quality API checks', () {
    var airQuality = AirQuality(latitude: 52.52, longitude: 13.41);
    var hourly = [Hourly.pm10];
    var current = [Current.pm10];

    test('Hourly air quality from current time.', () async {
      var result = await airQuality.rawRequest(hourly: hourly);
      expect(result['error'], isNot(true));
      expect(result['hourly'], isNot(null));
      expect(result['hourly']['time'].length, result['hourly']['pm10'].length);
    });

    test('Current air quality.', () async {
      var result = await airQuality.rawRequest(current: current);
      expect(result['error'], isNot(true));
      expect(result['current'], isNot(null));
    });

    test('Combined from all options', () async {
      var result =
          await airQuality.rawRequest(hourly: hourly, current: current);
      expect(result['error'], isNot(true));
      expect(result['hourly'], isNot(null));
      expect(result['hourly']['time'].length, result['hourly']['pm10'].length);
      expect(result['current'], isNot(null));
    });
  });

  group('Geocoding API checks', () {
    var geocoding = Geocoding(language: 'en');

    test('Look for Berlin', () async {
      var result = await geocoding.request(name: 'Berlin');
      expect(result['error'], isNot(true));
      expect(result['results'][0]['name'], 'Berlin');
    });
  });

  group('Elevation API checks', () {
    var elevation = Elevation();

    test('Check elevation', () async {
      var result =
          await elevation.request(latitudes: [52.52], longitudes: [13.41]);
      expect(result['error'], isNot(true));
      expect(result['elevation'][0], 38);
    });
  });
}
