import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/src/models/weather_model.dart';
import 'package:weather_app/src/services/weather_repository.dart';
import 'package:weather_app/src/widgets/weather/weather_display.dart';
import 'package:weather_app/src/widgets/common/search_bar.dart';

class HomeScreen extends StatefulWidget {
  final WeatherRepository weatherRepository;

  const HomeScreen({Key? key, required this.weatherRepository}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherData? _weatherData;
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _fetchWeatherByCity(String city) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final weather = await widget.weatherRepository.getWeatherByCity(city);
      setState(() => _weatherData = weather);
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchWeatherByLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final weather = await widget.weatherRepository.getWeatherByCurrentLocation();
      setState(() => _weatherData = weather);
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeatherByLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Weather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.ref