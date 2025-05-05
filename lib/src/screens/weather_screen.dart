import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../models/weather_model.dart';
import '../services/weather_repository.dart';
import '../utils/weather_theme.dart';

class WeatherScreen extends StatefulWidget {
  final WeatherRepository weatherRepository;

  const WeatherScreen({super.key, required this.weatherRepository});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _searchController = TextEditingController();
  WeatherModel? _weather;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _getCurrentLocationWeather();
  }

  Future<void> _getCurrentLocationWeather() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final weather =
          await widget.weatherRepository.getWeatherByCurrentLocation();
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = _getErrorMessage(e.toString());
        _isLoading = false;
      });
    }
  }

  Future<void> _searchWeather(String city) async {
    if (city.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final weather = await widget.weatherRepository.getWeatherByCity(city);
      setState(() {
        _weather = weather;
        _isLoading = false;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _error = _getErrorMessage(e.toString());
        _isLoading = false;
      });
    }
  }

  String _getErrorMessage(String error) {
    if (error.contains('Location services are disabled')) {
      return 'Please enable location services in your device settings';
    } else if (error.contains('Location permissions are denied')) {
      return 'Please grant location permission to get weather data';
    } else if (error.contains('Location permissions are permanently denied')) {
      return 'Location permission is permanently denied. Please enable it in settings';
    } else if (error.contains('Failed to load weather data')) {
      return 'Unable to fetch weather data. Please check your internet connection';
    } else if (error.contains('City not found')) {
      return 'City not found. Please check the spelling and try again';
    }
    return 'An unexpected error occurred. Please try again';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient:
              _weather != null
                  ? WeatherTheme.getGradient(_weather!.icon)
                  : LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue[50]!,
                      Colors.blue[50]!.withOpacity(0.6),
                    ],
                  ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () {
                      Navigator.pushNamed(context, '/forecast');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search city...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.my_location),
                      onPressed: _getCurrentLocationWeather,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onSubmitted: _searchWeather,
                ),
              ),
              Expanded(
                child:
                    _isLoading
                        ? const SpinKitPulse(color: Colors.white)
                        : _error != null
                        ? Center(child: Text(_error!))
                        : _weather != null
                        ? _buildWeatherInfo()
                        : const Center(
                          child: Text('Search for a city to get started'),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherInfo() {
    return RefreshIndicator(
      onRefresh: () async {
        if (_searchController.text.isNotEmpty) {
          await _searchWeather(_searchController.text);
        } else {
          await _getCurrentLocationWeather();
        }
      },
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            _weather!.cityName,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Image.network(_weather!.iconUrl, height: 100, width: 100),
          Text(
            '${_weather!.temperature.round()}°C',
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          Text(
            _weather!.description.toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          _buildWeatherDetails(),
        ],
      ),
    );
  }

  Widget _buildWeatherDetails() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDetailRow(
              'Feels Like',
              '${_weather!.feelsLike.round()}°C',
              Icons.thermostat,
            ),
            _buildDetailRow(
              'Humidity',
              '${_weather!.humidity}%',
              Icons.water_drop,
            ),
            _buildDetailRow(
              'Wind Speed',
              '${_weather!.windSpeed} m/s',
              Icons.air,
            ),
            _buildDetailRow(
              'Pressure',
              '${_weather!.pressure} hPa',
              Icons.speed,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(label),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
