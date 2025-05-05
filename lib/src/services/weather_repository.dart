import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import 'weather_service.dart';
import 'location_service.dart';

class WeatherRepository {
  final WeatherService _weatherService = WeatherService();
  final LocationService _locationService = LocationService();

  Future<WeatherModel> getWeatherByCity(String city) async {
    final data = await _weatherService.getWeatherByCity(city);
    return WeatherModel.fromJson(data);
  }

  Future<WeatherModel> getWeatherByCurrentLocation() async {
    try {
      final position = await _getCurrentPosition();
      final data = await _weatherService.getWeatherByLocation(
        position.latitude,
        position.longitude,
      );
      return WeatherModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<WeatherForecast>> getForecast([String? city]) async {
    try {
      List<Map<String, dynamic>> data;
      if (city != null) {
        data = await _weatherService.getForecast(city);
      } else {
        final position = await _getCurrentPosition();
        data = await _weatherService.getForecast(
          '${position.latitude},${position.longitude}',
        );
      }
      return data.map((item) => WeatherForecast.fromJson(item)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<List<WeatherForecast>> getFiveDayForecast(
    double latitude,
    double longitude,
  ) async {
    final data = await _weatherService.getForecast(
      '$latitude,$longitude',
      days: 5,
    );
    return data.map((item) => WeatherForecast.fromJson(item)).toList();
  }
}

class AppConstants {
  static const String openWeatherApiKey =
      'YOUR_API_KEY'; // Replace with your actual API key
  static const String weatherBaseUrl =
      'https://api.openweathermap.org/data/2.5';
  static const String weatherIconUrl = 'https://openweathermap.org/img/wn';

  // Weather condition codes mapping
  static Map<String, String> weatherConditions = {
    '01d': 'clear_sky',
    '02d': 'few_clouds',
    '03d': 'scattered_clouds',
    '04d': 'broken_clouds',
    '09d': 'shower_rain',
    '10d': 'rain',
    '11d': 'thunderstorm',
    '13d': 'snow',
    '50d': 'mist',
    // Night icons
    '01n': 'clear_sky_night',
    '02n': 'few_clouds_night',
    '03n': 'scattered_clouds_night',
    '04n': 'broken_clouds_night',
  };
}
