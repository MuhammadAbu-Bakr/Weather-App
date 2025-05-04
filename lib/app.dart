import 'package:flutter/material.dart';
import 'package:weather_app/src/screens/home_screen.dart';
import 'package:weather_app/src/screens/forecast_screen.dart';
import 'package:weather_app/src/screens/settings_screen.dart';
import 'package:weather_app/src/services/weather_repository.dart';

class WeatherApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  const WeatherApp({Key? key, required this.weatherRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(weatherRepository: weatherRepository),
        '/forecast': (context) => ForecastScreen(weatherRepository: weatherRepository),
        '/settings': (context) => const SettingsScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}