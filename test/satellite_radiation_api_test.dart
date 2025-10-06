import 'package:open_meteo/open_meteo.dart';
import 'package:test/test.dart';

void main() {
  group('satellite api', () {
    const latitude = 52.52, longitude = 13.405; // Berlin

    group('constructor', () {
      test('with defaults', () {
        expect(
            () => SatelliteRadiationApi(
                models: {OpenMeteoModel.satellite_radiation_seamless}),
            returnsNormally);
      });

      group('with custom', () {
        test('url/key', () {
          expect(
            () => SatelliteRadiationApi(
                apiUrl: 'https://api.custom.url/some/path',
                apiKey: 'idk-the-format-of-open-meteo-api-keys',
                models: {OpenMeteoModel.satellite_radiation_seamless}),
            returnsNormally,
          );
        });
        test('cell selection', () {
          expect(
            () => SatelliteRadiationApi(
                cellSelection: CellSelection.sea,
                models: {OpenMeteoModel.satellite_radiation_seamless}),
            returnsNormally,
          );
        });
      });
    });

    group('flatbuffers', () {
      late SatelliteRadiationApi api;
      setUp(() {
        api = SatelliteRadiationApi(
            models: {OpenMeteoModel.satellite_radiation_seamless});
      });

      group('enum deserialization', () {
        test('for hourly data', () async {
          final response = await api.request(
            locations: {
              OpenMeteoLocation(latitude: latitude, longitude: longitude)
            },
            hourly: SatelliteRadiationHourly.values.toSet(),
          );
          expect(
            response.segments[0].hourlyData.keys,
            containsAll(SatelliteRadiationHourly.values),
          );
        });
        test('for daily data', () async {
          final response = await api.request(
            locations: {
              OpenMeteoLocation(latitude: latitude, longitude: longitude)
            },
            daily: SatelliteRadiationDaily.values.toSet(),
          );
          expect(
            response.segments[0].dailyData.keys,
            containsAll(SatelliteRadiationDaily.values),
          );
        });
      });

      group('get', () {
        test('hourly diffuse radiation', () async {
          final result = await api.request(
            locations: {
              OpenMeteoLocation(latitude: latitude, longitude: longitude)
            },
            hourly: {SatelliteRadiationHourly.diffuse_radiation},
          );
          final temperature = result.segments[0]
              .hourlyData[SatelliteRadiationHourly.diffuse_radiation];
          expect(temperature, isNotNull);
          expect(temperature!.values, isNotEmpty);
        });
        test('daily shortwave radiation', () async {
          final result = await api.request(
            locations: {
              OpenMeteoLocation(latitude: latitude, longitude: longitude)
            },
            daily: {SatelliteRadiationDaily.shortwave_radiation_sum},
          );
          final temperature = result.segments[0]
              .dailyData[SatelliteRadiationDaily.shortwave_radiation_sum];
          expect(temperature, isNotNull);
          expect(temperature!.values, isNotEmpty);
        });
      });
    });

    group('json get', () {
      late SatelliteRadiationApi api;
      setUp(() {
        api = SatelliteRadiationApi(
            models: {OpenMeteoModel.satellite_radiation_seamless});
      });
      test('hourly diffuse radiation', () async {
        final result = await api.requestJson(
          locations: {
            OpenMeteoLocation(latitude: latitude, longitude: longitude)
          },
          hourly: {SatelliteRadiationHourly.diffuse_radiation},
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
          locations: {
            OpenMeteoLocation(latitude: latitude, longitude: longitude)
          },
          daily: {SatelliteRadiationDaily.shortwave_radiation_sum},
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
