import 'dart:convert';
import '../config.dart';
import '../models/apod.dart';
import 'package:http/http.dart' as http;

class ApodService {
  final String baseUrl = 'https://api.nasa.gov/planetary/apod';
  final String apiKey = Config.apiKey;

  final http.Client _httpClient;

  ApodService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<Apod> getAstronomyPictureOfTheDay() async {
    final response = await _httpClient.get(Uri.parse('$baseUrl?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Apod(
        title: data['title'],
        date: data['date'],
        description: data['explanation'],
        imageUrl: data['hdurl'],
      );
    } else {
      throw Exception('Failed to load data');
    }
  }
}
