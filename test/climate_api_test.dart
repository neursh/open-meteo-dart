import 'package:open_meteo/open_meteo.dart';
import 'package:test/test.dart';

void main() {
  group('climate api', () {
    const latitude = 52.52, longitude = 13.405; // Berlin
    const models = [ClimateModel.CMCC_CM2_VHR4];
    final startDate = DateTime(2022, 1, 1), endDate = DateTime(2022, 1, 2);

    group('constructor', () {
      test('with single model', () {
        expect(
          () => ClimateApi(models: [ClimateModel.CMCC_CM2_VHR4]),
          returnsNormally,
        );
      });

      test('with multiple models', () {
        expect(
          () => ClimateApi(models: [
            ClimateModel.CMCC_CM2_VHR4,
            ClimateModel.NICAM16_8S,
          ]),
          returnsNormally,
        );
      });

      group('with custom', () {
        test('url/key', () {
          expect(
            () => ClimateApi(
              models: models,
              apiUrl: 'https://api.custom.url/some/path',
              apiKey: 'idk-the-format-of-open-meteo-api-keys',
            ),
            returnsNormally,
          );
        });
        test('units', () {
          expect(
            () => ClimateApi(
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
            () => ClimateApi(
              models: models,
              cellSelection: CellSelection.sea,
            ),
            returnsNormally,
          );
        });
        test('bias correction', () {
          expect(
            () => ClimateApi(
              models: models,
              disableBiasCorrection: true,
            ),
            returnsNormally,
          );
        });
      });
    });

    group('flatbuffers', () {
      late ClimateApi api;
      setUp(() {
        api = ClimateApi(models: models);
      });

      group('enum deserialization', () {
        test('for daily data', () async {
          final response = await api.request(
            latitude: latitude,
            longitude: longitude,
            startDate: startDate,
            endDate: endDate,
            daily: ClimateDaily.values,
          );
          expect(response.dailyData.keys, containsAll(ClimateDaily.values));
        });
      });

      group('get', () {
        test('daily temperature max', () async {
          final result = await api.request(
            latitude: latitude,
            longitude: longitude,
            startDate: startDate,
            endDate: endDate,
            daily: [ClimateDaily.temperature_2m_max],
          );
          final temperature = result.dailyData[ClimateDaily.temperature_2m_max];
          expect(temperature, isNotNull);
          expect(temperature!.data, isNotEmpty);
        });
      });
    });

    group('json get', () {
      late ClimateApi api;
      setUp(() {
        api = ClimateApi(models: models);
      });

      test('daily temperature max', () async {
        final result = await api.rawRequest(
          latitude: latitude,
          longitude: longitude,
          startDate: startDate,
          endDate: endDate,
          daily: [ClimateDaily.temperature_2m_max],
        );
        expect(result['error'], isNot(true));
        expect(result['daily'], isNotNull);
        expect(result['daily']['temperature_2m_max'], isNotNull);
        expect(
          result['daily']['time'].length,
          result['daily']['temperature_2m_max'].length,
        );
      });
    });
  });
}
