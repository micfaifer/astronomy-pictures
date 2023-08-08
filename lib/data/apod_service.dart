import 'dart:convert';
import 'package:intl/intl.dart';

import '../config.dart';
import '../models/apod.dart';
import 'package:http/http.dart' as http;

class ApodService {
  final String url = 'api.nasa.gov';
  final String baseUrl = 'https://api.nasa.gov/planetary/apod';
  final String apiKey = Config.apiKey;

  final http.Client _httpClient;

  ApodService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<List<Apod>> getAstronomyPictures(
      DateTime startDate, DateTime endDate) async {
    final response = await _httpClient.get(
      Uri(
        scheme: "https",
        host: url,
        path: "planetary/apod",
        queryParameters: {
          "start_date": DateFormat('yyyy-MM-dd').format(startDate).toString(),
          "end_date": DateFormat('yyyy-MM-dd').format(endDate).toString(),
          "api_key": apiKey
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body);
      final List<Apod> apodList = dataList.map((data) {
        return Apod(
          title: data['title'],
          date: data['date'],
          description: data['explanation'],
          imageUrl: data['hdurl'],
        );
      }).toList();

      return apodList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
