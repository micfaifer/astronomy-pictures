import 'package:astronomy_pictures/data/apod_service.dart';
import 'package:astronomy_pictures/models/apod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'apod_service_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  late ApodService apodService;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    apodService = ApodService(httpClient: mockClient);
  });

  group('getAstronomyPictures', () {
    final DateTime startDate = DateTime(2023, 8, 1);
    final DateTime endDate = DateTime(2023, 8, 3);

    test('returns a list of Apod objects for a successful request', () async {
      final response = http.Response(
          '[{"title": "Title 1", "date": "2023-08-01", "explanation": "Description 1", "hdurl": "https://test.com/image1.jpg"}]',
          200);
      when(mockClient.get(any)).thenAnswer((_) async => response);

      final result = await apodService.getAstronomyPictures(startDate, endDate);

      expect(result, isA<List<Apod>>());
      expect(result.length, 1);
      expect(result[0].title, 'Title 1');
    });

    test('throws an exception for a failed request', () async {
      final response = http.Response('Error', 404);
      when(mockClient.get(any)).thenAnswer((_) async => response);

      final call = apodService.getAstronomyPictures(startDate, endDate);

      expect(call, throwsException);
    });
  });
}
