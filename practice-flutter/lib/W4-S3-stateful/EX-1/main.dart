import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          title: const Text("Custom Buttons"),
        ),
        body: const Center(
          child: SizedBox(
            width: 200,
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(),
                SizedBox(height: 8),
                CustomButton(),
                SizedBox(height: 8),
                CustomButton(),
                SizedBox(height: 8),
                CustomButton(),
              ],
            ),
          ),
        ),
      ),
    ));

class CustomButton extends StatefulWidget {
  const CustomButton({super.key});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isSelected = false;

  void toggleSelect() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: toggleSelect,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.white,
      ),
      child: Center(
        child: Text(
          isSelected ? "Selected" : "Not Selected",
          style: TextStyle(
            fontSize: 20,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
