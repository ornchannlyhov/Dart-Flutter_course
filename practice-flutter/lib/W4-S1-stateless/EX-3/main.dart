import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Custom Buttons')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomButton(
              label: 'Submit',
              iconPosition: IconPosition.left,
              buttonType: ButtonType.primary,
            ),
            CustomButton(
              label: 'Time',
              iconPosition: IconPosition.right,
              buttonType: ButtonType.secondary,
            ),
            CustomButton(
              label: 'Disabled Button',
              iconPosition: IconPosition.right,
              buttonType: ButtonType.disabled,
            ),
          ],
        ),
      ),
    ),
  ));
}

enum ButtonType {
  primary(Colors.blue, Icons.check),
  secondary(Colors.green, Icons.access_time),
  disabled(Colors.grey, Icons.account_tree);

  final Color color;
  final IconData icon;
  const ButtonType(this.color, this.icon);
}

enum IconPosition { left, right }

class CustomButton extends StatelessWidget {
  final String label;
  final IconPosition iconPosition;
  final ButtonType buttonType;

  const CustomButton({
    super.key,
    required this.label,
    this.iconPosition = IconPosition.left,
    this.buttonType = ButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: buttonType.color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: iconPosition == IconPosition.left
            ? [
                Icon(buttonType.icon, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    decoration: TextDecoration.none,
                  ),
                ),
              ]
            : [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(buttonType.icon, color: Colors.white),
              ],
      ),
    );
  }
}
