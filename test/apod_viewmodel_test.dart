import 'package:astronomy_pictures/data/data_exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:astronomy_pictures/data/data_manager.dart';
import 'package:astronomy_pictures/models/apod.dart';
import 'package:astronomy_pictures/viewmodels/apod_viewmodel.dart';

import 'apod_viewmodel_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DataManager>()])

void main() {
  late ApodViewModel viewModel;
  late MockDataManager mockDataManager;

  setUp(() {
    mockDataManager = MockDataManager();
    viewModel = ApodViewModel(dataManager: mockDataManager);
  });

  test('should update state when fetching data successfully', () async {
    final apodList = [
      Apod(
        title: 'Title 1',
        date: '2023-08-01',
        description: 'Description 1',
        imageUrl: 'https://example.com/image1.jpg',
      ),
      Apod(
        title: 'Title 2',
        date: '2023-08-02',
        description: 'Description 2',
        imageUrl: 'https://example.com/image2.jpg',
      ),
    ];

    when(mockDataManager.getAstronomyPictures(any, any))
        .thenAnswer((_) async => apodList);

    await viewModel.getAstronomyPictures();

    expect(viewModel.isFetchingData, false);
    expect(viewModel.apodList, apodList);
    expect(viewModel.error, isEmpty);
  });

  test('should update state when remote data fetch fails', () async {
    when(mockDataManager.getAstronomyPictures(any, any))
        .thenThrow(RemoteDataException());

    await viewModel.getAstronomyPictures();

    expect(viewModel.isFetchingData, false);
    expect(viewModel.apodList, []);
    expect(viewModel.error, isNotEmpty);
  });

  test('should update state and fetch local data on remote fetch failure', () async {
    final currentDate = DateTime.now();
    final startDate = currentDate.subtract(const Duration(days: 7));
    final endDate = currentDate;

    final localApodList = [
      Apod(
        title: 'Local Title 1',
        date: '2023-08-01',
        description: 'Local Description 1',
        imageUrl: 'https://example.com/local_image1.jpg',
      ),
      Apod(
        title: 'Local Title 2',
        date: '2023-08-02',
        description: 'Local Description 2',
        imageUrl: 'https://example.com/local_image2.jpg',
      ),
    ];

    when(mockDataManager.getAstronomyPictures(startDate, endDate))
        .thenThrow(RemoteDataException());
    when(mockDataManager.getLocalAstronomyPictures())
        .thenAnswer((_) async => localApodList);

    await viewModel.getAstronomyPictures();

    expect(viewModel.isFetchingData, false);
    expect(viewModel.apodList, localApodList);
    expect(viewModel.error, isEmpty);
  });

  test('should update state when unexpected error occurs', () async {
    final currentDate = DateTime.now();
    final startDate = currentDate.subtract(const Duration(days: 7));
    final endDate = currentDate;

    when(mockDataManager.getAstronomyPictures(startDate, endDate))
        .thenThrow(Exception());

    await viewModel.getAstronomyPictures();

    expect(viewModel.isFetchingData, false);
    expect(viewModel.apodList, []);
    expect(viewModel.error, '');
  });
}
