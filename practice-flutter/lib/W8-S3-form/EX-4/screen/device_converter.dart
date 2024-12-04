import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Device {
  riel(4000),
  dong(23000),
  euro(0.9);

  final double conversionRate;

  const Device(this.conversionRate);
}

class DeviceConverter extends StatefulWidget {
  const DeviceConverter({super.key});

  @override
  State<DeviceConverter> createState() => _DeviceConverterState();
}

class _DeviceConverterState extends State<DeviceConverter> {
  Device? selectedDevice;
  final dollarController = TextEditingController();
  double convertedAmount = 0.0;

  void _convert() {
    if (selectedDevice != null) {
      final double? dollars = double.tryParse(dollarController.text);
      if (dollars != null) {
        setState(() {
          convertedAmount = dollars * selectedDevice!.conversionRate;
        });
      } else {
        setState(() {
          convertedAmount = 0.0;
        });
      }
    }
  }

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
              Icons.money,
              size: 60,
              color: Colors.white,
            ),
            const Center(
              child: Text(
                "Converter",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            const SizedBox(height: 50),
            const Text("Amount in dollars:",
                style: TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            TextField(
              controller: dollarController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: InputDecoration(
                prefix: const Text('\$ '),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Enter an amount in dollars',
                hintStyle: const TextStyle(color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                _convert();
              },
            ),
            const SizedBox(height: 30),
            const Text("Device:", style: TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            DropdownButton<Device>(
              value: selectedDevice,
              dropdownColor: Colors.grey,
              isExpanded: true,
              items: Device.values.map((device) {
                return DropdownMenuItem<Device>(
                  value: device,
                  child: Text(
                    device.name.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (Device? value) {
                setState(() {
                  selectedDevice = value;
                  _convert();
                });
              },
            ),
            const SizedBox(height: 30),
            const Text("Amount in selected device:",
                style: TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                selectedDevice != null
                    ? convertedAmount.toStringAsFixed(2)
                    : 'Select a device',
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
