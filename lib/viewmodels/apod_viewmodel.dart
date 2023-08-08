import 'package:astronomy_pictures/data/apod_service.dart';
import 'package:astronomy_pictures/models/apod.dart';
import 'package:flutter/material.dart';

class ApodViewModel extends ChangeNotifier {
  final ApodService _apodService;
  Apod? _apodData;

  ApodViewModel({required ApodService apodService}) : _apodService = apodService;

  Apod? get apodData => _apodData;

  Future<void> fetchAstronomyPictureOfTheDay() async {
    _apodData = await _apodService.getAstronomyPictureOfTheDay();
    notifyListeners();
  }
}