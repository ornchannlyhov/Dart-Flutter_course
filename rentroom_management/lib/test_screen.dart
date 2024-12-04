import 'package:flutter/material.dart';
import 'package:rentroom_management/view/screen/building_screen.dart';
import 'package:rentroom_management/view/screen/client_screen.dart';
import 'package:rentroom_management/view/screen/history_screen.dart';
import 'package:rentroom_management/view/screen/receipt_screen.dart';
import 'package:rentroom_management/view/widget/app_component/app_menu.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final _screens = [
    const ReceiptScreen(),
    const BuildingScreen(),
    const ClientScreen(),
    const HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[850],
        body: _screens[_selectedIndex],
        bottomNavigationBar: AppMenu(
          selectedIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }
}
