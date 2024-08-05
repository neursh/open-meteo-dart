import 'package:open_meteo/open_meteo.dart';
import 'package:test/test.dart';

void main() {
  group('marine api', () {
    const latitude = 54.544587, longitude = 10.227487; // Baltic Sea near Kiel

    group('constructor', () {
      test('with defaults', () {
        expect(() => MarineApi(), returnsNormally);
      });

      group('with custom', () {
        test('url/key', () {
          expect(
            () => MarineApi(
              apiUrl: 'https://api.custom.url/some/path',
              apiKey: 'idk-the-format-of-open-meteo-api-keys',
            ),
            returnsNormally,
          );
        });
        test('units', () {
          expect(
            () => MarineApi(
              windspeedUnit: WindspeedUnit.mph,
              temperatureUnit: TemperatureUnit.fahrenheit,
              precipitationUnit: PrecipitationUnit.inch,
              lengthUnit: LengthUnit.imperial,
            ),
            returnsNormally,
          );
        });
        test('cell selection', () {
          expect(
            () => MarineApi(cellSelection: CellSelection.sea),
            returnsNormally,
          );
        });
      });
    });

    group('flatbuffers', () {
      late MarineApi api;
      setUp(() {
        api = MarineApi();
      });

      group('enum deserialization', () {
        test('for current data', () async {
          final response = await api.request(
            latitude: latitude,
            longitude: longitude,
            current: MarineCurrent.values.toSet(),
          );
          expect(response.currentData.keys, containsAll(MarineCurrent.values));
        });
        test('for hourly data', () async {
          final response = await api.request(
            latitude: latitude,
            longitude: longitude,
            hourly: MarineHourly.values.toSet(),
          );
          expect(response.hourlyData.keys, containsAll(MarineHourly.values));
        });
        // Waiting for https://github.com/open-meteo/open-meteo/issues/936
        // test('for daily data', () async {
        //   final response = await api.request(
        //     latitude: latitude,
        //     longitude: longitude,
        //     daily: DailyMarine.values.toSet(),
        //   );
        //   expect(
        //     response.dailyData.keys,
        //     containsAll(DailyMarine.values),
        //   );
        // });
      });

      group('get', () {
        test('current wave height', () async {
          final result = await api.request(
            latitude: latitude,
            longitude: longitude,
            current: {MarineCurrent.wave_height},
          );
          final waveHeight = result.currentData[MarineCurrent.wave_height];
          expect(waveHeight, isNotNull);
          expect(waveHeight!.data.length, 1);
        });
        test('hourly wave height', () async {
          final result = await api.request(
            latitude: latitude,
            longitude: longitude,
            hourly: {MarineHourly.wave_height},
          );
          final waveHeight = result.hourlyData[MarineHourly.wave_height];
          expect(waveHeight, isNotNull);
          expect(waveHeight!.data, isNotEmpty);
        });
        // test('daily wave height max', () async {
        //   final result = await api.request(
        //     latitude: latitude,
        //     longitude: longitude,
        //     daily: [DailyMarine.wave_height_max],
        //   );
        //   final waveHeight = result.dailyData[DailyMarine.wave_height_max];
        //   expect(waveHeight, isNotNull);
        //   expect(waveHeight!.data, isNotEmpty);
        // });
      });
    });

    group('json get', () {
      late MarineApi api;
      setUp(() {
        api = MarineApi();
      });

      test('current wave height', () async {
        final result = await api.requestJson(
          latitude: latitude,
          longitude: longitude,
          current: {MarineCurrent.wave_height},
        );
        expect(result['error'], isNot(true));
        expect(result['current'], isNotNull);
        expect(result['current']['wave_height'], isNotNull);
      });
      test('hourly wave height', () async {
        final result = await api.requestJson(
          latitude: latitude,
          longitude: longitude,
          hourly: {MarineHourly.wave_height},
        );
        expect(result['error'], isNot(true));
        expect(result['hourly'], isNotNull);
        expect(result['hourly']['wave_height'], isNotNull);
        expect(
          result['hourly']['time'].length,
          result['hourly']['wave_height'].length,
        );
      });
      test('daily wave height max', () async {
        final result = await api.requestJson(
          latitude: latitude,
          longitude: longitude,
          daily: {MarineDaily.wave_height_max},
        );
        expect(result['error'], isNot(true));
        expect(result['daily'], isNotNull);
        expect(result['daily']['wave_height_max'], isNotNull);
        expect(
          result['daily']['time'].length,
          result['daily']['wave_height_max'].length,
        );
      });
    });
  });
}
