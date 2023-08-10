import 'package:flutter_test/flutter_test.dart';
import 'package:astronomy_pictures/data/data_exceptions.dart';

void main() {
  group('RemoteDataException', () {
    test('should have correct default message', () {
      final exception = RemoteDataException();
      expect(exception.message, "Failed to fetch remote data. Please check your internet connection.");
    });

    test('toString() should return the exception message', () {
      final exception = RemoteDataException();
      expect(exception.toString(), "Failed to fetch remote data. Please check your internet connection.");
    });
  });

  group('LocalDataException', () {
    test('should have correct default message', () {
      final exception = LocalDataException();
      expect(exception.message, "Failed to get local data.");
    });

    test('toString() should return the exception message', () {
      final exception = LocalDataException();
      expect(exception.toString(), "Failed to get local data.");
    });
  });
}
