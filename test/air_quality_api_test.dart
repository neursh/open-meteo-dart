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
        test('past/forecast range', () {
          expect(
            () => AirQualityApi(
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
            () => AirQualityApi(
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
      late AirQualityApi api;
      setUp(() {
        api = AirQualityApi();
      });

      group('enum deserialization', () {
        test('for current data', () async {
          final response = await api.request(
            latitude: latitude,
            longitude: longitude,
            current: CurrentAirQuality.values,
          );
          expect(
              response.currentData.keys, containsAll(CurrentAirQuality.values));
        });
        test('for hourly data', () async {
          final response = await api.request(
            latitude: latitude,
            longitude: longitude,
            hourly: HourlyAirQuality.values,
          );
          expect(
              response.hourlyData.keys, containsAll(HourlyAirQuality.values));
        });
      });

      group('get', () {
        test('current aqi', () async {
          final result = await api.request(
            latitude: latitude,
            longitude: longitude,
            current: [CurrentAirQuality.european_aqi],
          );
          final temperature =
              result.currentData[CurrentAirQuality.european_aqi];
          expect(temperature, isNotNull);
          expect(temperature!.data.length, 1);
        });
        test('hourly aqi', () async {
          final result = await api.request(
            latitude: latitude,
            longitude: longitude,
            hourly: [HourlyAirQuality.european_aqi],
          );
          final temperature =
              result.hourlyData[HourlyAirQuality.european_aqi];
          expect(temperature, isNotNull);
          expect(temperature!.data, isNotEmpty);
        });
      });
    });

    group('json get', () {
      late AirQualityApi api;
      setUp(() {
        api = AirQualityApi();
      });

      test('current aqi', () async {
        final result = await api.rawRequest(
          latitude: latitude,
          longitude: longitude,
          current: [CurrentAirQuality.european_aqi],
        );
        expect(result['error'], isNot(true));
        expect(result['current'], isNotNull);
        expect(result['current']['european_aqi'], isNotNull);
      });
      test('hourly aqi', () async {
        final result = await api.rawRequest(
          latitude: latitude,
          longitude: longitude,
          hourly: [HourlyAirQuality.european_aqi],
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
