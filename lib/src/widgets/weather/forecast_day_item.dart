import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/weather_model.dart';

class ForecastDayItem extends StatelessWidget {
  final WeatherForecast forecast;

  const ForecastDayItem({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('EEEE, MMM d').format(forecast.date),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    forecast.description.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Image.network(
              'https://openweathermap.org/img/wn/${forecast.icon}@2x.png',
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${forecast.temperature.round()}°',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Humidity: ${forecast.humidity}%',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Wind: ${forecast.windSpeed.toStringAsFixed(1)} m/s',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
