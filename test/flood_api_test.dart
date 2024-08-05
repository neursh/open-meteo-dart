import 'package:open_meteo/open_meteo.dart';
import 'package:test/test.dart';

void main() {
  group('Flood api', () {
    const latitude = 52.52, longitude = 13.405; // Berlin

    group('constructor', () {
      test('with defaults', () {
        expect(() => FloodApi(), returnsNormally);
      });

      group('with custom', () {
        test('url/key', () {
          expect(
            () => FloodApi(
              apiUrl: 'https://api.custom.url/some/path',
              apiKey: 'idk-the-format-of-open-meteo-api-keys',
            ),
            returnsNormally,
          );
        });
        test('cell selection', () {
          expect(
            () => FloodApi(cellSelection: CellSelection.sea),
            returnsNormally,
          );
        });
        test('ensemble', () {
          expect(
            () => FloodApi(ensemble: true),
            returnsNormally,
          );
        });
        test('past/forecast range', () {
          expect(
            () => FloodApi(
              pastDays: 1,
              forecastDays: 1,
            ),
            returnsNormally,
          );
        });
        test('start/end times', () {
          expect(
            () => FloodApi(
              startDate: DateTime.now(),
              endDate: DateTime.now().add(const Duration(days: 1)),
            ),
            returnsNormally,
          );
        });
      });
    });

    group('flatbuffers', () {
      late FloodApi api;
      setUp(() {
        api = FloodApi();
      });

      group('enum deserialization', () {
        test('for daily data', () async {
          final response = await api.request(
            latitude: latitude,
            longitude: longitude,
            daily: FloodDaily.values,
          );
          expect(response.dailyData.keys, containsAll(FloodDaily.values));
        });
      });

      group('get', () {
        test('daily river discharge', () async {
          final result = await api.request(
            latitude: latitude,
            longitude: longitude,
            daily: [FloodDaily.river_discharge],
          );
          final temperature = result.dailyData[FloodDaily.river_discharge];
          expect(temperature, isNotNull);
          expect(temperature!.data, isNotEmpty);
        });
      });
    });

    group('json get', () {
      late FloodApi api;
      setUp(() {
        api = FloodApi();
      });

      test('daily river discharge', () async {
        final result = await api.rawRequest(
          latitude: latitude,
          longitude: longitude,
          daily: [FloodDaily.river_discharge],
        );
        expect(result['error'], isNot(true));
        expect(result['daily'], isNotNull);
        expect(result['daily']['river_discharge'], isNotNull);
        expect(
          result['daily']['time'].length,
          result['daily']['river_discharge'].length,
        );
      });
    });
  });
}
