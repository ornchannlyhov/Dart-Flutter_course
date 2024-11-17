import 'package:flutter/material.dart';

class Temperature extends StatefulWidget {
  const Temperature({super.key});

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  final TextEditingController _controller = TextEditingController();  
  String fahrenheit = ''; 

  void convertToFahrenheit() {
    final celsius = double.tryParse(_controller.text);  
    if (celsius != null) {
      setState(() {
        fahrenheit = ((celsius * 9 / 5) + 32).toStringAsFixed(2); 
      });
    } else {
      setState(() {
        fahrenheit = 'Invalid Input';
      });
    }
  }

  final BoxDecoration textDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  );

  final InputDecoration inputDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white, width: 1.0),
      borderRadius: BorderRadius.circular(12),
    ),
    hintText: 'Enter a temperature',
    hintStyle: const TextStyle(color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.thermostat_outlined,
              size: 120,
              color: Colors.white,
            ),
            const Center(
              child: Text(
                "Converter",
                style: TextStyle(color: Colors.white, fontSize: 45),
              ),
            ),
            const SizedBox(height: 50),
            const Text("Temperature in Degrees (Celsius):"),
            const SizedBox(height: 10),
            TextField(
              controller: _controller, 
              decoration: inputDecoration,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  fahrenheit = ''; 
                });
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: convertToFahrenheit,  
              child: const Text('Convert'),
            ),
            const SizedBox(height: 30),
            const Text("Temperature in Fahrenheit:"),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: textDecoration,
              child: Text(
                fahrenheit.isEmpty ? '' : fahrenheit,  
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
