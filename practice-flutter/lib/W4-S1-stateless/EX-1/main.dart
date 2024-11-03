import 'package:flutter/material.dart';

void main() {
  runApp(const HobbyApp());
}

class HobbyApp extends StatelessWidget {
  const HobbyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Hobby Cards")),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HobbyCard(
                title: "Basketball",
                icon: Icons.sports_basketball,
                color: Colors.orange,
              ),
              SizedBox(height: 16),
              HobbyCard(
                title: "Photography",
                icon: Icons.camera_alt,
                color: Colors.teal,
              ),
              SizedBox(height: 16),
              HobbyCard(
                title: "Cooking",
                icon: Icons.kitchen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HobbyCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  // Constructor with required and optional parameters
  const HobbyCard({
    super.key,
    required this.title,
    required this.icon,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: Colors.white),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
