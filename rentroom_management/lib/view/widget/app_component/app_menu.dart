import 'package:flutter/material.dart';

class AppMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const AppMenu({super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onTap,
        backgroundColor: Colors.grey[850],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey, 
        selectedFontSize: 12.0, 
        unselectedFontSize: 12.0, 
        items: [
          BottomNavigationBarItem(
            icon: _buildMenuItem(Icons.history, 'History', 0),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildMenuItem(Icons.receipt, 'Receipt', 1),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildMenuItem(Icons.apartment, 'Building', 2),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildMenuItem(Icons.person, 'Client', 3),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, int index) {
    final bool isSelected = selectedIndex == index;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0), 
      decoration: isSelected
          ? BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8.0),
            )
          : null, 
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.grey,
          ),
          const SizedBox(height: 2.0),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
