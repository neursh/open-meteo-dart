import 'package:open_meteo/open_meteo.dart';
import 'package:test/test.dart';

void main() {
  group('air quality api', () {
    const latitude = 52.52, longitude = 13.405; // Berlin

    group('constructor', () {
      test('with defaults', () {
        expect(() => AirQualityApi(), returnsNormally);
      });

      group('with custom', () {
        test('url/key', () {
          expect(
            () => AirQualityApi(
              apiUrl: 'https://api.custom.url/some/path',
              apiKey: 'idk-the-format-of-open-meteo-api-keys',
            ),
            returnsNormally,
          );
        });
        test('cell selection', () {
          expect(
            () => AirQualityApi(cellSelection: CellSelection.sea),
            returnsNormally,
          );
        });
        test('domains', () {
          expect(
            () => AirQualityApi(domains: AirQualityDomains.cams_europe),
            returnsNormally,
          );
        });
      });
    });

    group('flatbuffers', () {
      late AirQualityApi api;
      setUp(() {
        api = AirQualityApi();
      });

      group('enum deserialization', () {
        test('for current data', () async {
          final response = await api.request(
            latitude: latitude,
            longitude: longitude,
            current: AirQualityCurrent.values.toSet(),
          );
          expect(
            response.segments[0].currentData.keys,
            containsAll(AirQualityCurrent.values),
          );
        });
        test('for hourly data', () async {
          final response = await api.request(
            latitude: latitude,
            longitude: longitude,
            hourly: AirQualityHourly.values.toSet(),
          );
          expect(
            response.segments[0].hourlyData.keys,
            containsAll(AirQualityHourly.values),
          );
        });
      });

      group('get', () {
        test('current aqi', () async {
          final result = await api.request(
            latitude: latitude,
            longitude: longitude,
            current: {AirQualityCurrent.european_aqi},
          );
          final temperature =
              result.segments[0].currentData[AirQualityCurrent.european_aqi];
          expect(temperature, isNotNull);
        });
        test('hourly aqi', () async {
          final result = await api.request(
            latitude: latitude,
            longitude: longitude,
            hourly: {AirQualityHourly.european_aqi},
          );
          final temperature =
              result.segments[0].hourlyData[AirQualityHourly.european_aqi];
          expect(temperature, isNotNull);
          expect(temperature!.values, isNotEmpty);
        });
      });
    });

    group('json get', () {
      late AirQualityApi api;
      setUp(() {
        api = AirQualityApi();
      });

      test('current aqi', () async {
        final result = await api.requestJson(
          latitude: latitude,
          longitude: longitude,
          current: {AirQualityCurrent.european_aqi},
        );
        expect(result['error'], isNot(true));
        expect(result['current'], isNotNull);
        expect(result['current']['european_aqi'], isNotNull);
      });
      test('hourly aqi', () async {
        final result = await api.requestJson(
          latitude: latitude,
          longitude: longitude,
          hourly: {AirQualityHourly.european_aqi},
        );
        expect(result['error'], isNot(true));
        expect(result['hourly'], isNotNull);
        expect(result['hourly']['european_aqi'], isNotNull);
        expect(
          result['hourly']['time'].length,
          result['hourly']['european_aqi'].length,
        );
      });
    });
  });
}
