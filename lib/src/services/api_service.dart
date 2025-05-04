import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../../constants/app_constants.dart';

class ApiService {
  final String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  final String _apiKey = AppConstants.openWeatherApiKey;

  Future<WeatherData> fetchCurrentWeather(String city) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/weather?q=$city&appid=$_apiKey&units=metric')
      );

      if (response.statusCode == 200) {
        return WeatherData.fromJson(json.decode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception('City not found');
      } else {
        throw Exception('Failed to fetch weather data');
      }
    } catch (e) {
      log('Error fetching weather: $e');
      rethrow;
    }
  }

  Future<WeatherData> fetchWeatherByLocation(double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/weather?lat=$lat&lon=$lon&appid=$_apiKey&units=metric')
      );

      if (response.statusCode == 200) {
        return WeatherData.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to fetch weather data');
      }
    } catch (e) {
      log('Error fetching location weather: $e');
      rethrow;
    }
  }

  Future<List<WeatherForecast>> fetchFiveDayForecast(double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/forecast?lat=$lat&lon=$lon&appid=$_apiKey&units=metric&cnt=5')
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['list'] as List)
            .map((item) => WeatherForecast.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to fetch forecast data');
      }
    } catch (e) {
      log('Error fetching forecast: $e');
      rethrow;
    }
  }
}