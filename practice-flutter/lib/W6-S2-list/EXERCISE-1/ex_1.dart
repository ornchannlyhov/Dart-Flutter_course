import 'package:flutter/material.dart';

List<String> colors = ["red", "blue", "green"];

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const Label("Method 1: Loop in Array", bold: true),
            Column(
              children: [
                for (var color in colors)
                  Text(
                    color,
                    style: const TextStyle(fontSize: 16),
                  ),
              ],
            ),
            const Label("Method 2: Map", bold: true),
            Column(
              children: colors
                  .map((color) => Text(
                        color,
                        style: const TextStyle(fontSize: 16),
                      ))
                  .toList(),
            ),
            const Label("Method 3: Dedicated Function", bold: true),
            Column(
              children: getLabels(colors),
            ),
          ],
        ),
      ),
    ),
  ));
}

class Label extends StatelessWidget {
  const Label(this.text, {super.key, this.bold = false});

  final bool bold;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(fontWeight: (bold ? FontWeight.bold : FontWeight.normal)),
    );
  }
}

List<Widget> getLabels(List<String> items) {
  return items
      .map((item) => Text(item, style: const TextStyle(fontSize: 16)))
      .toList();
}

//Q1
// For loop is simple and efficient for small, straightforward tasks.
// Map offers a functional, concise approach but can become harder to maintain if the logic is complex.
// Dedicated function is ideal for reusable and more complex widget generation logic, improving readability and maintainability.