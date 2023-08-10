import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';
import 'package:astronomy_pictures/data/data_manager.dart';
import 'package:astronomy_pictures/data/apod_service.dart';
import 'package:astronomy_pictures/models/apod.dart';
import 'package:astronomy_pictures/data/data_exceptions.dart';

import 'data_manager_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>(), MockSpec<ApodService>()])
void main() {
  late DataManager dataManager;
  late MockApodService mockApodService;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockApodService = MockApodService();
    mockSharedPreferences = MockSharedPreferences();
    dataManager = DataManager(mockApodService, mockSharedPreferences);
  });

  group('getAstronomyPictures', () {
    test('should return a list of Apod instances', () async {
      final startDate = DateTime(2023, 1, 1);
      final endDate = DateTime(2023, 1, 7);
      final apodList = [
        Apod(
          title: 'Title 1',
          date: '2023-01-01',
          description: 'Description 1',
          imageUrl: 'https://example.com/image1.jpg',
        ),
      ];

      when(mockApodService.getAstronomyPictures(any, any))
          .thenAnswer((_) async => apodList);

      final result = await dataManager.getAstronomyPictures(startDate, endDate);

      expect(result, equals(apodList));
    });

    test('should throw RemoteDataException on service error', () async {
      when(mockApodService.getAstronomyPictures(any, any))
          .thenAnswer((_) async => throw RemoteDataException());
      expect(() async {
        await dataManager.getAstronomyPictures(
            DateTime.now().subtract(const Duration(days: 7)), DateTime.now());
      }, throwsA(isInstanceOf<RemoteDataException>()));
    });
  });
}
