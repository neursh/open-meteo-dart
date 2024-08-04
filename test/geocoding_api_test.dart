import 'package:open_meteo/open_meteo.dart';
import 'package:test/test.dart';

void main() {
  group('geocoding api', () {
    group('constructor', () {
      test('with defaults', () {
        expect(() => GeocodingApi(), returnsNormally);
      });

      group('with custom', () {
        test('url/key', () {
          expect(
            () => GeocodingApi(
              apiUrl: 'https://api.custom.url/some/path',
              apiKey: 'idk-the-format-of-open-meteo-api-keys',
            ),
            returnsNormally,
          );
        });
        test('language', () {
          expect(
            () => GeocodingApi(language: 'fr'),
            returnsNormally,
          );
        });
      });
    });

    group('json get', () {
      late GeocodingApi api;
      setUp(() {
        api = GeocodingApi();
      });

      test('location of Berlin', () async {
        final result = await api.rawRequest(name: 'Berlin');
        expect(result['error'], isNot(true));
        expect(result['results'], isNotNull);
        expect(result['results'][0]['name'], 'Berlin');
      });
    });
  });
}
