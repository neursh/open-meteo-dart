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
        test('past/forecast range', () {
          expect(
            () => MarineApi(
              pastDays: 1,
              pastHours: 1,
              forecastDays: 1,
              forecastHours: 1,
            ),
            returnsNormally,
          );
        });
        test('start/end times', () {
          expect(
            () => MarineApi(
              startDate: DateTime.now(),
              endDate: DateTime.now().add(const Duration(days: 1)),
              startHour: DateTime.now(),
              endHour: DateTime.now().add(const Duration(hours: 1)),
            ),
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
            current: CurrentMarine.values,
          );
          expect(response.currentData.keys, containsAll(CurrentMarine.values));
        });
        test('for hourly data', () async {
          final response = await api.request(
            latitude: latitude,
            longitude: longitude,
            hourly: HourlyMarine.values,
          );
          expect(response.hourlyData.keys, containsAll(HourlyMarine.values));
        });
        // Waiting for https://github.com/open-meteo/open-meteo/issues/936
        // test('for daily data', () async {
        //   final response = await api.request(
        //     latitude: latitude,
        //     longitude: longitude,
        //     daily: DailyMarine.values,
        //   );
        //   expect(response.dailyData.keys, containsAll(DailyMarine.values));
        // });
      });

      group('get', () {
        test('current wave height', () async {
          final result = await api.request(
            latitude: latitude,
            longitude: longitude,
            current: [CurrentMarine.wave_height],
          );
          final waveHeight = result.currentData[CurrentMarine.wave_height];
          expect(waveHeight, isNotNull);
          expect(waveHeight!.data.length, 1);
        });
        test('hourly wave height', () async {
          final result = await api.request(
            latitude: latitude,
            longitude: longitude,
            hourly: [HourlyMarine.wave_height],
          );
          final waveHeight = result.hourlyData[HourlyMarine.wave_height];
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
        final result = await api.rawRequest(
          latitude: latitude,
          longitude: longitude,
          current: [CurrentMarine.wave_height],
        );
        expect(result['error'], isNot(true));
        expect(result['current'], isNotNull);
        expect(result['current']['wave_height'], isNotNull);
      });
      test('hourly wave height', () async {
        final result = await api.rawRequest(
          latitude: latitude,
          longitude: longitude,
          hourly: [HourlyMarine.wave_height],
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
        final result = await api.rawRequest(
          latitude: latitude,
          longitude: longitude,
          daily: [DailyMarine.wave_height_max],
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
