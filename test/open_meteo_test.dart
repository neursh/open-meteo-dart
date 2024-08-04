import 'package:open_meteo/open_meteo.dart';
import 'package:test/test.dart';

void main() {
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
}
