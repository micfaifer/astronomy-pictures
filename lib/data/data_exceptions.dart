class RemoteDataException implements Exception {
  final String message;

  RemoteDataException()
      : message =
            "Failed to fetch remote data. Please check your internet connection.";

  @override
  String toString() => message;
}

class LocalDataException implements Exception {
  final String message;

  LocalDataException() : message = "Failed to get local data.";

  @override
  String toString() => message;
}
