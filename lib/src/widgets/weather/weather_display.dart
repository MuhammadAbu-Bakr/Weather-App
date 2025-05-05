import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/weather_model.dart';
import '../../providers/settings_provider.dart';
import 'weather_detail_card.dart';

class WeatherDisplay extends StatelessWidget {
  final WeatherModel weather;

  const WeatherDisplay({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return Column(
      children: [
        const SizedBox(height: 16),
        Image.network(
          weather.iconUrl,
          width: 120,
          height: 120,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 16),
        Text(
          settings.formatTemperature(weather.temperature),
          style: Theme.of(
            context,
          ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 8),
        Text(
          weather.description.toUpperCase(),
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Feels like ${settings.formatTemperature(weather.feelsLike)}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              WeatherDetailCard(
                icon: Icons.water_drop,
                title: 'Humidity',
                value: '${weather.humidity}%',
                color: Colors.blue,
              ),
              WeatherDetailCard(
                icon: Icons.air,
                title: 'Wind Speed',
                value: '${weather.windSpeed.toStringAsFixed(1)} m/s',
                color: Colors.green,
              ),
              WeatherDetailCard(
                icon: Icons.speed,
                title: 'Pressure',
                value: '${weather.pressure} hPa',
                color: Colors.orange,
              ),
              WeatherDetailCard(
                icon: Icons.thermostat,
                title: 'Feels Like',
                value: settings.formatTemperature(weather.feelsLike),
                color: Colors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
