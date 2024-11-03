import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(3),
        child: Column(
          children: [
            WeatherForecast(
              condition: WeatherCondition.sunny,
              minTemp: 25,
              maxTemp: 32,
              dayOfWeek: 'Mon',
            ),
            WeatherForecast(
              condition: WeatherCondition.rainy,
              minTemp: 18,
              maxTemp: 22,
              dayOfWeek: 'Tue',
            ),
            WeatherForecast(
              condition: WeatherCondition.cloudy,
              minTemp: 20,
              maxTemp: 25,
              dayOfWeek: 'Wed',
            ),
            WeatherForecast(
              condition: WeatherCondition.snowy,
              minTemp: -5,
              maxTemp: 0,
              dayOfWeek: 'Thu',
            ),
          ],
        ),
      ),
    ),
  ));
}

enum WeatherCondition {
  sunny(Colors.orange, Icons.wb_sunny),
  rainy(Colors.blue, Icons.umbrella),
  cloudy(Colors.grey, Icons.cloud),
  snowy(Colors.lightBlue, Icons.ac_unit);

  final Color color;
  final IconData icon;

  const WeatherCondition(this.color, this.icon);
}

class WeatherForecast extends StatelessWidget {
  final WeatherCondition condition;
  final int minTemp;
  final int maxTemp;
  final String dayOfWeek;

  const WeatherForecast({
    super.key,
    required this.condition,
    required this.minTemp,
    required this.maxTemp,
    required this.dayOfWeek,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),  
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),  
      decoration: BoxDecoration(
        color: condition.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            dayOfWeek,
            style: const TextStyle(
              fontSize: 16,  
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8), 
          Icon(
            condition.icon,
            size: 30,  
            color: Colors.white,
          ),
          const SizedBox(height: 8),  
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Min: $minTemp°C',
                style: const TextStyle(fontSize: 14),  
              ),
              const SizedBox(width: 5),  
              Text(
                'Max: $maxTemp°C',
                style: const TextStyle(fontSize: 14),  
              ),
            ],
          ),
        ],
      ),
    );
  }
}
