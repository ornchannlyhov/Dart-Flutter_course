import 'package:flutter/material.dart';
import 'package:rentroom_management/view/widget/card/building_card.dart';

class BuildingScreen extends StatelessWidget {
  const BuildingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buildings',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          IconButton(
              onPressed: null,
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.grey[850],
      ),
      body: ListView(
        children: const [
          BuildingCard(
            buildingName: 'Building Name',
            details: {
              'Water Price': '0.5\$',
              'Electric Price': '0.3\$',
              'Total Rooms': '20'
            },
          ),
        ],
      ),
    );
  }
}
