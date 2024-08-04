import 'package:open_meteo/open_meteo.dart';
import 'package:test/test.dart';

void main() {
  group('weather api', () {
    const latitude = 52.52, longitude = 13.41; // Berlin

    group('constructor', () {
      test('with defaults', () {});
      test('with custom url/key', () {
        expect(
          () => WeatherApi(
            apiUrl: 'https://api.custom.url/some/path',
            apiKey: 'idk-the-format-of-open-meteo-api-keys',
          ),
          returnsNormally,
        );
      });
      test('with custom units', () {
        expect(
          () => WeatherApi(
            windspeedUnit: WindspeedUnit.mph,
            temperatureUnit: TemperatureUnit.fahrenheit,
            precipitationUnit: PrecipitationUnit.inch,
          ),
          returnsNormally,
        );
      });
      test('with custom elevation', () {
        expect(
          () => WeatherApi(elevation: 10),
          returnsNormally,
        );
      });
      test('with custom cell selection', () {
        expect(
          () => WeatherApi(cellSelection: CellSelection.sea),
          returnsNormally,
        );
      });
      test('with custom past/forecast range', () {
        expect(
          () => WeatherApi(
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
      test('with custom start/end times', () {
        expect(
          () => WeatherApi(
            startDate: DateTime.now(),
            endDate: DateTime.now().add(const Duration(days: 1)),
            startHour: DateTime.now(),
            endHour: DateTime.now().add(const Duration(hours: 1)),
          ),
          returnsNormally,
        );
      });
    });

    group('enum parameters', () {
      late WeatherApi api;
      setUp(() {
        api = WeatherApi();
      });

      test('for current data', () async {
        final response = await api.request(
          latitude: latitude,
          longitude: longitude,
          current: CurrentWeather.values,
        );
        expect(response.currentData.length, CurrentWeather.values.length);
      });
      test('for hourly data', () async {
        final response = await api.request(
          latitude: latitude,
          longitude: longitude,
          hourly: HourlyWeather.values,
        );
        expect(response.hourlyData.length, HourlyWeather.values.length);
      });
      test('for daily data', () async {
        final response = await api.request(
          latitude: latitude,
          longitude: longitude,
          daily: DailyWeather.values,
        );
        expect(response.dailyData.length, DailyWeather.values.length);
      });
    });

    group('data', () {
      late WeatherApi api;
      setUp(() {
        api = WeatherApi();
      });

      test('get current temperature', () async {
        final result = await api.request(
          latitude: latitude,
          longitude: longitude,
          current: [CurrentWeather.temperature_2m],
        );
        final temperature = result.currentData[CurrentWeather.temperature_2m];
        expect(temperature, isNotNull);
        expect(temperature!.data.length, 1);
      });
      test('get hourly temperature', () async {
        final result = await api.request(
          latitude: latitude,
          longitude: longitude,
          hourly: [HourlyWeather.temperature_2m],
        );
        final temperature = result.hourlyData[HourlyWeather.temperature_2m];
        expect(temperature, isNotNull);
        expect(temperature!.data, isNotEmpty);
      });
      test('get daily temperature max', () async {
        final result = await api.request(
          latitude: latitude,
          longitude: longitude,
          daily: [DailyWeather.temperature_2m_max],
        );
        final temperature = result.dailyData[DailyWeather.temperature_2m_max];
        expect(temperature, isNotNull);
        expect(temperature!.data, isNotEmpty);
      });
    });
  });
}
