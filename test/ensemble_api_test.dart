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
            hourly: [EnsembleHourly.temperature_2m],
          );
          final temperature = result.hourlyData[EnsembleHourly.temperature_2m];
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
        final result = await api.requestJson(
          latitude: latitude,
          longitude: longitude,
          hourly: [EnsembleHourly.temperature_2m],
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
