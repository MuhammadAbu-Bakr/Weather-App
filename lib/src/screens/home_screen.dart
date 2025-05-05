import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../models/weather_model.dart';
import '../services/weather_repository.dart';
import '../widgets/weather/weather_display.dart';
import '../widgets/common/weather_search_bar.dart';

class HomeScreen extends StatefulWidget {
  final WeatherRepository weatherRepository;

  const HomeScreen({Key? key, required this.weatherRepository})
    : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  WeatherModel? _weather;
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchWeatherByLocation();
  }

  Future<void> _fetchWeatherByLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final weather =
          await widget.weatherRepository.getWeatherByCurrentLocation();
      setState(() => _weather = weather);
    } catch (e) {
      setState(() => _errorMessage = _getErrorMessage(e.toString()));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _searchWeather(String city) async {
    if (city.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final weather = await widget.weatherRepository.getWeatherByCity(city);
      setState(() => _weather = weather);
    } catch (e) {
      setState(() => _errorMessage = _getErrorMessage(e.toString()));
    } finally {
      setState(() => _isLoading = false);
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
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.8),
              Theme.of(context).primaryColor.withOpacity(0.4),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: const Text('Weather App'),
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
                WeatherSearchBar(
                  controller: _searchController,
                  onSubmitted: _searchWeather,
                  onLocationPressed: _fetchWeatherByLocation,
                ),
                _isLoading
                    ? const Center(
                        child: SpinKitPulse(color: Colors.white, size: 50.0),
                      )
                    : _errorMessage.isNotEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            _errorMessage,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    : _weather != null
                    ? WeatherDisplay(weather: _weather!)
                    : const Center(
                        child: Text(
                          'Search for a city to get started',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
