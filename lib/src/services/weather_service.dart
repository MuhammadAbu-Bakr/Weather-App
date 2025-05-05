import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
  final String baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Map<String, dynamic>> getWeatherByCity(String city) async {
    try {
      final apiKey = dotenv.env['OPENWEATHERMAP_API_KEY'];
      if (apiKey == null) throw Exception('API key not found in .env file');

      final url = '$baseUrl/weather?q=$city&appid=$apiKey&units=metric';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        throw Exception(
          'Invalid API key. Please check your OpenWeatherMap API key',
        );
      } else if (response.statusCode == 404) {
        throw Exception('City not found. Please check the city name');
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getWeatherByLocation(
    double latitude,
    double longitude,
  ) async {
    try {
      final apiKey = dotenv.env['OPENWEATHERMAP_API_KEY'];
      if (apiKey == null) throw Exception('API key not found in .env file');

      final url =
          '$baseUrl/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        throw Exception(
          'Invalid API key. Please check your OpenWeatherMap API key',
        );
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getForecast(
    String location, {
    int days = 5,
  }) async {
    try {
      final apiKey = dotenv.env['OPENWEATHERMAP_API_KEY'];
      if (apiKey == null) throw Exception('API key not found in .env file');

      final url =
          '$baseUrl/forecast?q=$location&appid=$apiKey&units=metric&cnt=$days';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['list']);
      } else if (response.statusCode == 401) {
        throw Exception(
          'Invalid API key. Please check your OpenWeatherMap API key',
        );
      } else {
        throw Exception('Failed to load forecast data: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
