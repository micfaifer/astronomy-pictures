import 'package:flutter/material.dart';
import 'package:astronomy_pictures/data/data_manager.dart';
import 'package:astronomy_pictures/models/apod.dart';
import '../data/data_exceptions.dart';

class ApodViewModel extends ChangeNotifier {
  final DataManager _apodDataManager;

  ApodViewModel({required DataManager dataManager})
      : _apodDataManager = dataManager;

  String _searchTerm = "";
  List<Apod>? _apodList;
  String _error = "";
  bool _isFetchingData = false;

  String get error => _error;
  bool get hasError => _error.isNotEmpty;
  bool get isFetchingData => _isFetchingData;

  DateTimeRange get selectedDateRange => _selectedDateRange;
  DateTimeRange get availableDateTimeRange => _availableDateTimeRange;

  List<Apod>? get apodList {
    if (_searchTerm.isEmpty) {
      return _apodList;
    }
    final filteredList = _apodList!.where((apod) {
      final title = apod.title.toLowerCase();
      return title.contains(_searchTerm.toLowerCase());
    }).toList();
    return filteredList;
  }

  late DateTimeRange _selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 7)),
    end: DateTime.now(),
  );

  final DateTimeRange _availableDateTimeRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  );

  set selectedDateRange(DateTimeRange value) {
    if (_selectedDateRange != value) {
      _selectedDateRange = value;
      getAstronomyPictures();
      notifyListeners();
    }
  }

  Future<void> getAstronomyPictures() async {
    try {
      _error = "";
      _isFetchingData = true;
      _apodList = await _apodDataManager.getAstronomyPictures(
        _selectedDateRange.start,
        _selectedDateRange.end,
      );
    } on RemoteDataException catch (e) {
      _error = e.message;
      notifyListeners();
      try {
        _apodList = await _apodDataManager.getLocalAstronomyPictures();
      } on LocalDataException catch (e) {
        _error = e.message;
      }
    } catch (e) {
      _error = "An unexpected error occurred.";
    } finally {
      _isFetchingData = false;
      notifyListeners();
    }
  }

  Future<void> searchByTerm(String searchTerm) async {
    if (_apodList == null) return;
    _searchTerm = searchTerm;
    notifyListeners();
  }
}
