import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'src/screens/home_screen.dart';
import 'src/screens/forecast_screen.dart';
import 'src/screens/settings_screen.dart';
import 'src/services/weather_repository.dart';
import 'src/providers/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Debug logging
  print(
    'API Key loaded: ${dotenv.env['OPENWEATHERMAP_API_KEY']?.substring(0, 5)}...',
  );

  final weatherRepository = WeatherRepository();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        Provider.value(value: weatherRepository),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final isDark = settings.isDarkMode;

    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/':
            (context) => HomeScreen(
              weatherRepository: context.read<WeatherRepository>(),
            ),
        '/forecast':
            (context) => ForecastScreen(
              weatherRepository: context.read<WeatherRepository>(),
            ),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
