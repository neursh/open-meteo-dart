import 'package:open_meteo/open_meteo.dart';
import 'package:test/test.dart';

void main() {
  group('ensemble api', () {
    const latitude = 52.52, longitude = 13.405; // Berlin
    const models = [EnsembleModel.icon_seamless];

    group('constructor', () {
      test('with single model', () {
        expect(
          () => EnsembleApi(models: [EnsembleModel.icon_seamless]),
          returnsNormally,
        );
      });
      test('with multiple models', () {
        expect(
          () => EnsembleApi(models: [
            EnsembleModel.icon_seamless,
            EnsembleModel.gfs_seamless,
          ]),
          returnsNormally,
        );
      });

      group('with custom', () {
        test('url/key', () {
          expect(
            () => EnsembleApi(
              models: models,
              apiUrl: 'https://api.custom.url/some/path',
              apiKey: 'idk-the-format-of-open-meteo-api-keys',
            ),
            returnsNormally,
          );
        });
        test('units', () {
          expect(
            () => EnsembleApi(
              models: models,
              windspeedUnit: WindspeedUnit.mph,
              temperatureUnit: TemperatureUnit.fahrenheit,
              precipitationUnit: PrecipitationUnit.inch,
            ),
            returnsNormally,
          );
        });
        test('cell selection', () {
          expect(
            () => EnsembleApi(
              models: models,
              cellSelection: CellSelection.sea,
            ),
            returnsNormally,
          );
        });
        test('elevation', () {
          expect(
            () => EnsembleApi(
              models: models,
              elevation: 10,
            ),
            returnsNormally,
          );
        });
        test('past/forecast range', () {
          expect(
            () => EnsembleApi(
              models: models,
              pastDays: 1,
              pastHours: 1,
              pastMinutely15: 1,
              forecastDays: 1,
              forecastHours: 1,
              forecastMinutely15: 1,
            ),
            returnsNormally,
          );
        });
        test('start/end times', () {
          expect(
            () => EnsembleApi(
              models: models,
              startDate: DateTime.now(),
              endDate: DateTime.now().add(const Duration(days: 1)),
              startHour: DateTime.now(),
              endHour: DateTime.now().add(const Duration(hours: 1)),
              startMinutely15: DateTime.now(),
              endMinutely15: DateTime.now().add(const Duration(minutes: 15)),
            ),
            returnsNormally,
          );
        });
      });
    });

    group('flatbuffers', () {
      late EnsembleApi api;
      setUp(() {
        api = EnsembleApi(models: models);
      });

      group('enum deserialization', () {
        // Waiting for https://github.com/open-meteo/open-meteo/pull/939
        // test('for hourly data', () async {
        //   final response = await api.request(
        //     latitude: latitude,
        //     longitude: longitude,
        //     hourly: HourlyEnsemble.values,
        //   );
        //   expect(response.hourlyData.keys, containsAll(HourlyEnsemble.values));
        // });
      });

      group('get', () {
        test('hourly temperature', () async {
          final result = await api.request(
            latitude: latitude,
            longitude: longitude,
            hourly: [HourlyEnsemble.temperature_2m],
          );
          final temperature = result.hourlyData[HourlyEnsemble.temperature_2m];
          expect(temperature, isNotNull);
          expect(temperature!.data, isNotEmpty);
        });
      });
    });

    group('json get', () {
      late EnsembleApi api;
      setUp(() {
        api = EnsembleApi(models: models);
      });

      test('hourly temperature', () async {
        final result = await api.rawRequest(
          latitude: latitude,
          longitude: longitude,
          hourly: [HourlyEnsemble.temperature_2m],
        );
        expect(result['error'], isNot(true));
        expect(result['hourly'], isNotNull);
        expect(result['hourly']['temperature_2m'], isNotNull);
        expect(
          result['hourly']['time'].length,
          result['hourly']['temperature_2m'].length,
        );
      });
    });
  });
}
