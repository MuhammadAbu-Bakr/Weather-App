import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: Column(
          children: [
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.blue.shade800),
                    onPressed: () {},
                  ),
                  Column(
                    children: [
                      Text(
                        'New York, NY',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      Text(
                        'Partly Cloudy',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.blue.shade800),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            
            
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/weather-partly-cloudy.svg',
                      width: 150,
                      height: 150,
                      color: Colors.blue.shade700,
                    ),
                    SizedBox(height: 16),
                    Text(
                      '72°',
                      style: TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.w300,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'H:78° L:64°',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  
                  SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        HourlyForecastItem(time: 'Now', temp: '72°', icon: Icons.wb_sunny),
                        HourlyForecastItem(time: '1 PM', temp: '74°', icon: Icons.wb_sunny),
                        HourlyForecastItem(time: '2 PM', temp: '75°', icon: Icons.wb_cloudy),
                        HourlyForecastItem(time: '3 PM', temp: '76°', icon: Icons.wb_cloudy),
                        HourlyForecastItem(time: '4 PM', temp: '75°', icon: Icons.wb_cloudy),
                        HourlyForecastItem(time: '5 PM', temp: '73°', icon: Icons.wb_cloudy),
                      ],
                    ),
                  ),
                  
                  Divider(height: 32, thickness: 1),
                  
                  
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      WeatherDetailItem(icon: Icons.air, title: 'Wind', value: '8 mph'),
                      WeatherDetailItem(icon: Icons.opacity, title: 'Humidity', value: '65%'),
                      WeatherDetailItem(icon: Icons.visibility, title: 'Visibility', value: '10 mi'),
                      WeatherDetailItem(icon: Icons.grain, title: 'Pressure', value: '1012 hPa'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final String temp;
  final IconData icon;

  HourlyForecastItem({required this.time, required this.temp, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(time, style: TextStyle(fontSize: 14, color: Colors.blue.shade800)),
          Icon(icon, size: 24, color: Colors.blue.shade700),
          Text(temp, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue.shade900)),
        ],
      ),
    );
  }
}

class WeatherDetailItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  WeatherDetailItem({required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 24, color: Colors.blue.shade700),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
            Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue.shade900)),
          ],
        ),
      ],
    );
  }
}