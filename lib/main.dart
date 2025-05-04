import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';


void main() async {
  final apiService = ApiService();
  final locationService = LocationService();
  final weatherRepository = WeatherRepository(
    apiService: apiService,
    locationService: locationService,
  );
  await dotenv.load(fileName: ".env");
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey.shade900,
        cardColor: Colors.grey.shade800,
      ),
      home: WeatherHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final TextEditingController _searchController = TextEditingController();
  WeatherData? _weatherData;
  bool _isLoading = false;
  String _errorMessage = '';
  bool _isDarkMode = false;

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
      Position position = await _determinePosition();
      await _fetchWeather(
        lat: position.latitude,
        lon: position.longitude,
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to get location: ${e.toString()}';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchWeatherByCity(String city) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      await _fetchWeather(city: city);
    } catch (e) {
      setState(() {
        _errorMessage = 'City not found. Please try again.';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchWeather({String? city, double? lat, double? lon}) async {
    final apiKey = dotenv.env['OPENWEATHER_API_KEY'];
    String url;

    if (city != null) {
      url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';
    } else {
      url = 'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
    }

    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _weatherData = WeatherData(
          city: data['name'],
          temperature: data['main']['temp'].round(),
          feelsLike: data['main']['feels_like'].round(),
          condition: data['weather'][0]['main'],
          description: data['weather'][0]['description'],
          humidity: data['main']['humidity'],
          windSpeed: data['wind']['speed'],
          pressure: data['main']['pressure'],
          iconCode: data['weather'][0]['icon'],
        );
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Weather Forecast'),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: _toggleDarkMode,
            ),
          ],
        ),
        body: _isLoading
            ? Center(child: SpinKitFadingCircle(color: Colors.blue))
            : RefreshIndicator(
                onRefresh: _fetchWeatherByLocation,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      if (_errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _errorMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      SearchBar(_searchController, _fetchWeatherByCity),
                      if (_weatherData != null) WeatherDisplay(_weatherData!),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}