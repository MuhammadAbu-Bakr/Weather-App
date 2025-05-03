import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
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
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: WeatherScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade600,
              Colors.blue.shade400,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with location and search
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.menu, color: Colors.white),
                      onPressed: () {},
                    ),
                    Column(
                      children: [
                        Text(
                          'New York, NY',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Partly Cloudy',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              
              // Main weather display
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/weather-partly-cloudy.svg',
                        width: 150,
                        height: 150,
                        color: Colors.white,
                      ),
                      SizedBox(height: 16),
                      Text(
                        '72°',
                        style: TextStyle(
                          fontSize: 72,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'H:78° L:64°',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Updated 10 min ago',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Bottom sheet with forecast and details
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Hourly forecast
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hourly Forecast',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'See More',
                            style: TextStyle(
                              color: Colors.blue.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          HourlyForecastItem(
                            time: 'Now', 
                            temp: '72°', 
                            icon: Icons.wb_sunny,
                            isNow: true,
                          ),
                          HourlyForecastItem(time: '1 PM', temp: '74°', icon: Icons.wb_sunny),
                          HourlyForecastItem(time: '2 PM', temp: '75°', icon: Icons.wb_cloudy),
                          HourlyForecastItem(time: '3 PM', temp: '76°', icon: Icons.wb_cloudy),
                          HourlyForecastItem(time: '4 PM', temp: '75°', icon: Icons.wb_cloudy),
                          HourlyForecastItem(time: '5 PM', temp: '73°', icon: Icons.wb_cloudy),
                        ],
                      ),
                    ),
                    
                    Divider(height: 40, thickness: 1, color: Colors.grey.shade200),
                    
                    // Weather details
                    Text(
                      'Weather Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      children: [
                        WeatherDetailItem(
                          icon: Icons.air,
                          title: 'Wind',
                          value: '8 mph',
                          color: Colors.blue.shade100,
                        ),
                        WeatherDetailItem(
                          icon: Icons.opacity,
                          title: 'Humidity',
                          value: '65%',
                          color: Colors.lightBlue.shade100,
                        ),
                        WeatherDetailItem(
                          icon: Icons.visibility,
                          title: 'Visibility',
                          value: '10 mi',
                          color: Colors.blueGrey.shade100,
                        ),
                        WeatherDetailItem(
                          icon: Icons.grain,
                          title: 'Pressure',
                          value: '1012 hPa',
                          color: Colors.cyan.shade100,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final String temp;
  final IconData icon;
  final bool isNow;

  const HourlyForecastItem({
    required this.time,
    required this.temp,
    required this.icon,
    this.isNow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isNow ? Colors.blue.shade100 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: isNow ? Border.all(color: Colors.blue.shade300, width: 1.5) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 14,
              color: isNow ? Colors.blue.shade800 : Colors.grey.shade800,
              fontWeight: isNow ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Icon(
            icon,
            size: 24,
            color: isNow ? Colors.amber : Colors.blue.shade700,
          ),
          Text(
            temp,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isNow ? Colors.blue.shade900 : Colors.grey.shade900,
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherDetailItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const WeatherDetailItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.blue.shade700,
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}