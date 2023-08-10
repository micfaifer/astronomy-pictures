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

  test('should update state and fetch local data on remote fetch failure',
      () async {
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

    when(mockDataManager.getAstronomyPictures(any, any))
        .thenAnswer((_) async => throw RemoteDataException());
    when(mockDataManager.getLocalAstronomyPictures())
        .thenAnswer((_) async => localApodList);

    await viewModel.getAstronomyPictures();

    expect(viewModel.isFetchingData, false);
    expect(viewModel.apodList, localApodList);
    expect(viewModel.error,
        "Failed to fetch remote data. Please check your internet connection.");
  });

  test('should update state when unexpected error occurs', () async {
    when(mockDataManager.getAstronomyPictures(any, any))
        .thenAnswer((_) async => throw Exception());

    await viewModel.getAstronomyPictures();

    expect(viewModel.isFetchingData, false);
    expect(viewModel.apodList, []);
    expect(viewModel.error, "An unexpected error occurred.");
  });

  // Search by terms
  test('searchByTerm updates apod list', () async {
    const searchTerm = '2';
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
    viewModel.searchByTerm(searchTerm);

    expect(viewModel.apodList, [apodList[1]]);
    expect(viewModel.searchTerm, "1");
  });
}
