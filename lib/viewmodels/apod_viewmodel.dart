import 'package:astronomy_pictures/data/apod_service.dart';
import 'package:astronomy_pictures/models/apod.dart';
import 'package:flutter/material.dart';

class ApodViewModel extends ChangeNotifier {
  final ApodService _apodService;

  String _searchTerm = "";

  List<Apod>? _apodList;

  ApodViewModel({required ApodService apodService}) : _apodService = apodService;

  List<Apod>? get apodList {
    if (_searchTerm.isEmpty) { return _apodList;}
    final filteredList = _apodList!.where((apod) {
      final title = apod.title.toLowerCase();
      return title.contains(_searchTerm.toLowerCase());
    }).toList();
    return filteredList;
  }

  Future<void> fetchAstronomyPictureOfTheDay() async {
    _apodList = await _apodService.getAstronomyPictures();
    notifyListeners();
  }

  Future<void> searchByTerm(String searchTerm) async {
    if (_apodList == null) return;
    _searchTerm = searchTerm;
    notifyListeners();
  }
}