import 'package:open_meteo/open_meteo.dart';
import 'package:test/test.dart';

void main() {
  group('elevation api', () {
    group('constructor', () {
      test('with defaults', () {
        expect(() => ElevationApi(), returnsNormally);
      });

      group('with custom', () {
        test('url/key', () {
          expect(
            () => ElevationApi(
              apiUrl: 'https://api.custom.url/some/path',
              apiKey: 'idk-the-format-of-open-meteo-api-keys',
            ),
            returnsNormally,
          );
        });
      });
    });

    group('json get', () {
      late ElevationApi api;
      setUp(() {
        api = ElevationApi();
      });

      test('single elevation', () async {
        final result = await api.request(
          latitudes: [52.52],
          longitudes: [13.41],
        );
        expect(result['error'], isNot(true));
        expect(result['elevation'], isNotNull);
        expect(result['elevation'][0], isA<num>());
      });
      test('multiple elevations', () async {
        final result = await api.request(
          latitudes: [52.52, 51.507],
          longitudes: [13.405, -0.128],
        );
        print(result);
        expect(result['error'], isNot(true));
        expect(result['elevation'], isNotNull);
        expect(result['elevation'][0], isA<num>());
        expect(result['elevation'][1], isA<num>());
      });
    });
  });
}
