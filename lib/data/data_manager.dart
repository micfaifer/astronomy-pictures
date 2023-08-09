import 'package:astronomy_pictures/data/apod_service.dart';
import 'package:astronomy_pictures/models/apod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DataManager {
  final ApodService _apiService;

  DataManager(this._apiService);

  Future<List<Apod>> getAstronomyPictures(
      DateTime startDate, DateTime endDate) async {
    try {
      final apodList =
      await _apiService.getAstronomyPictures(startDate, endDate);
      final sharedPreferences = await SharedPreferences.getInstance();
      final List<String> apodStringList = apodList.map((apod) {
        final json = apod.toJson();
        return jsonEncode(json);
      }).toList();
      await sharedPreferences.setStringList('apodList', apodStringList);
      return apodList;
    } catch (e) {
      return _getLocalAstronomyPictures();
    }
  }

  Future<List<Apod>> _getLocalAstronomyPictures() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final List<String>? apodStringList =
    sharedPreferences.getStringList('apodList');
    if (apodStringList != null) {
      return apodStringList.map((jsonString) {
        final json = jsonDecode(jsonString);
        return Apod.fromJson(json);
      }).toList();
    }
    return [];
  }

}
