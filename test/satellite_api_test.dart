import 'package:open_meteo/open_meteo.dart';
import 'package:test/test.dart';

void main() {
  group('satellite api', () {
    const latitude = 52.52, longitude = 13.405; // Berlin

    group('constructor', () {
      test('with defaults', () {
        expect(() => SatelliteApi(), returnsNormally);
      });

      group('with custom', () {
        test('url/key', () {
          expect(
            () => SatelliteApi(
              apiUrl: 'https://api.custom.url/some/path',
              apiKey: 'idk-the-format-of-open-meteo-api-keys',
            ),
            returnsNormally,
          );
        });
        test('cell selection', () {
          expect(
            () => SatelliteApi(cellSelection: CellSelection.sea),
            returnsNormally,
          );
        });
      });
    });

    group('flatbuffers', () {
      late SatelliteApi api;
      setUp(() {
        api = SatelliteApi();
      });

      group('enum deserialization', () {
        test('for hourly data', () async {
          final response = await api.request(
            latitude: latitude,
            longitude: longitude,
            hourly: SatelliteHourly.values.toSet(),
          );
          expect(
            response.hourlyData.keys,
            containsAll(SatelliteHourly.values),
          );
        });
        test('for daily data', () async {
          final response = await api.request(
            latitude: latitude,
            longitude: longitude,
            daily: SatelliteDaily.values.toSet(),
          );
          expect(
            response.dailyData.keys,
            containsAll(SatelliteDaily.values),
          );
        });
      });

      group('get', () {
        test('hourly diffuse radiation', () async {
          final result = await api.request(
            latitude: latitude,
            longitude: longitude,
            hourly: {SatelliteHourly.diffuse_radiation},
          );
          final temperature =
              result.hourlyData[SatelliteHourly.diffuse_radiation];
          expect(temperature, isNotNull);
          expect(temperature!.values, isNotEmpty);
        });
        test('daily shortwave radiation', () async {
          final result = await api.request(
            latitude: latitude,
            longitude: longitude,
            daily: {SatelliteDaily.shortwave_radiation_sum},
          );
          final temperature =
              result.dailyData[SatelliteDaily.shortwave_radiation_sum];
          expect(temperature, isNotNull);
          expect(temperature!.values, isNotEmpty);
        });
      });
    });

    group('json get', () {
      late SatelliteApi api;
      setUp(() {
        api = SatelliteApi();
      });
      test('hourly diffuse radiation', () async {
        final result = await api.requestJson(
          latitude: latitude,
          longitude: longitude,
          hourly: {SatelliteHourly.diffuse_radiation},
        );
        expect(result['error'], isNot(true));
        expect(result['hourly'], isNotNull);
        expect(result['hourly']['diffuse_radiation'], isNotNull);
        expect(
          result['hourly']['time'].length,
          result['hourly']['diffuse_radiation'].length,
        );
      });
      test('daily shortwave radiation', () async {
        final result = await api.requestJson(
          latitude: latitude,
          longitude: longitude,
          daily: {SatelliteDaily.shortwave_radiation_sum},
        );
        expect(result['error'], isNot(true));
        expect(result['daily'], isNotNull);
        expect(result['daily']['shortwave_radiation_sum'], isNotNull);
        expect(
          result['daily']['time'].length,
          result['daily']['shortwave_radiation_sum'].length,
        );
      });
    });
  });
}
