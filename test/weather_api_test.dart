import 'package:open_meteo/open_meteo.dart';
import 'package:test/test.dart';

void main() {
  group('weather api', () {
    const latitude = 52.52, longitude = 13.405; // Berlin

    group('constructor', () {
      test('with defaults', () {
        expect(() => WeatherApi(), returnsNormally);
      });

      group('with custom', () {
        test('url/key', () {
          expect(
            () => WeatherApi(
              apiUrl: 'https://api.custom.url/some/path',
              apiKey: 'idk-the-format-of-open-meteo-api-keys',
            ),
            returnsNormally,
          );
        });
        test('units', () {
          expect(
            () => WeatherApi(
              windspeedUnit: WindspeedUnit.mph,
              temperatureUnit: TemperatureUnit.fahrenheit,
              precipitationUnit: PrecipitationUnit.inch,
            ),
            returnsNormally,
          );
        });
        test('cell selection', () {
          expect(
            () => WeatherApi(cellSelection: CellSelection.sea),
            returnsNormally,
          );
        });
      });
    });

    group('flatbuffers', () {
      late WeatherApi api;
      setUp(() {
        api = WeatherApi();
      });

      group('enum deserialization', () {
        test('for current data', () async {
          final response = await api.request(
            latitude: latitude,
            longitude: longitude,
            current: WeatherCurrent.values.toSet(),
          );
          expect(
            response.currentData.keys,
            containsAll(WeatherCurrent.values),
          );
        });
        test('for hourly data', () async {
          final response = await api.request(
            latitude: latitude,
            longitude: longitude,
            hourly: WeatherHourly.values.toSet(),
          );
          expect(
            response.hourlyData.keys,
            containsAll(WeatherHourly.values),
          );
        });
        test('for daily data', () async {
          final response = await api.request(
            latitude: latitude,
            longitude: longitude,
            daily: WeatherDaily.values.toSet(),
          );
          expect(
            response.dailyData.keys,
            containsAll(WeatherDaily.values),
          );
        });
      });

      group('get', () {
        test('current temperature', () async {
          final result = await api.request(
            latitude: latitude,
            longitude: longitude,
            current: {WeatherCurrent.temperature_2m},
          );
          final temperature = result.currentData[WeatherCurrent.temperature_2m];
          expect(temperature, isNotNull);
        });
        test('hourly temperature', () async {
          final result = await api.request(
            latitude: latitude,
            longitude: longitude,
            hourly: {WeatherHourly.temperature_2m},
          );
          final temperature = result.hourlyData[WeatherHourly.temperature_2m];
          expect(temperature, isNotNull);
          expect(temperature!.values, isNotEmpty);
        });
        test('daily temperature max', () async {
          final result = await api.request(
            latitude: latitude,
            longitude: longitude,
            daily: {WeatherDaily.temperature_2m_max},
          );
          final temperature = result.dailyData[WeatherDaily.temperature_2m_max];
          expect(temperature, isNotNull);
          expect(temperature!.values, isNotEmpty);
        });
      });
    });

    group('json get', () {
      late WeatherApi api;
      setUp(() {
        api = WeatherApi();
      });

      test('current temperature', () async {
        final result = await api.requestJson(
          latitude: latitude,
          longitude: longitude,
          current: {WeatherCurrent.temperature_2m},
        );
        expect(result['error'], isNot(true));
        expect(result['current'], isNotNull);
        expect(result['current']['temperature_2m'], isNotNull);
      });
      test('hourly temperature', () async {
        final result = await api.requestJson(
          latitude: latitude,
          longitude: longitude,
          hourly: {WeatherHourly.temperature_2m},
        );
        expect(result['error'], isNot(true));
        expect(result['hourly'], isNotNull);
        expect(result['hourly']['temperature_2m'], isNotNull);
        expect(
          result['hourly']['time'].length,
          result['hourly']['temperature_2m'].length,
        );
      });
      test('daily temperature max', () async {
        final result = await api.requestJson(
          latitude: latitude,
          longitude: longitude,
          daily: {WeatherDaily.temperature_2m_max},
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
