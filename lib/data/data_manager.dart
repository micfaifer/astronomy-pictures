import 'package:astronomy_pictures/data/apod_service.dart';
import 'package:astronomy_pictures/models/apod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'data_exceptions.dart';

class DataManager {
  final ApodService _apiService;
  final SharedPreferences _sharedPreferences;

  DataManager(this._apiService, this._sharedPreferences);

  Future<List<Apod>> getAstronomyPictures(
      DateTime startDate, DateTime endDate) async {
    try {
      final apodList =
      await _apiService.getAstronomyPictures(startDate, endDate);
      final List<String> apodStringList = apodList.map((apod) {
        final json = apod.toJson();
        return jsonEncode(json);
      }).toList();
      await _sharedPreferences.setStringList('apodList', apodStringList);
      return apodList;
    } catch (e) {
      throw RemoteDataException();
    }
  }

  Future<List<Apod>> getLocalAstronomyPictures() async {
    final List<String>? apodStringList =
    _sharedPreferences.getStringList('apodList');
    if (apodStringList != null) {
      return apodStringList.map((jsonString) {
        final json = jsonDecode(jsonString);
        return Apod.fromJson(json);
      }).toList();
    } else {
      throw LocalDataException();
    }
  }
}
