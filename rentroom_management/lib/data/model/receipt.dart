import 'dart:convert';
import 'dart:io';
import 'package:rentroom_management/data/enum/payment_status.dart';
import 'package:rentroom_management/data/model/room.dart';

class Receipt {
  final DateTime date;
  final Room room;
  final PaymentStatus paymentStatus;

  static const String filePath = 'database/receipts.json';

  Receipt({
    required this.date,
    required this.room,
    required this.paymentStatus,
  });

  // Calculate total price using building's electric and water prices, plus service fees
  double calculateTotalPrice() {
    final electricPrice = room.buildingName.getElectricPrice;
    final waterPrice = room.buildingName.getWaterPrice;
    final electricUsage = room.currentElecticUsed - room.lastElecticUsed;
    final waterUsage = room.currentWaterUsed - room.lastWaterUsed;
    double serviceCost = 0.0;
    for (var service in room.servicese) {
      serviceCost += service.servicePrice;
    }
    if (room.lastWaterUsed != 0 && room.lastElecticUsed != 0) {
      room.lastWaterUsed = room.currentWaterUsed;
      room.lastElecticUsed = room.currentElecticUsed;
    }
    return room.roomPrice +
        (electricUsage * electricPrice) +
        (waterUsage * waterPrice) +
        serviceCost;
  }

  // Serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'room': room.toJson(),
      'paymentStatus': paymentStatus.toString().split('.').last,
    };
  }

  // Deserialize from JSON
  static Receipt fromJson(Map<String, dynamic> json) {
    return Receipt(
      date: DateTime.parse(json['date']),
      room: Room.fromJson(json['room']),
      paymentStatus: PaymentStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['paymentStatus'],
        orElse: () => PaymentStatus.notPaid, 
      ),
    );
  }

  // Save receipts to file
  static Future<void> saveReceiptsToFile(List<Receipt> receipts) async {
    try {
      final file = File(filePath);
      final jsonString =
          jsonEncode(receipts.map((receipt) => receipt.toJson()).toList());
      await file.writeAsString(jsonString);
    } catch (e) {
      // Handle any error that may occur during file writing
    }
  }

  // Load receipts from file
  static Future<List<Receipt>> loadReceiptsFromFile() async {
    try {
      final file = File(filePath);

      if (!file.existsSync()) {
        // If file doesn't exist, create it with an empty list
        await file.create(recursive: true);
        await file.writeAsString(jsonEncode([]));
      }

      final jsonString = await file.readAsString();
      final List<dynamic> jsonData = jsonDecode(jsonString);

      return jsonData
          .map((receiptJson) => Receipt.fromJson(receiptJson))
          .toList();
    } catch (e) {
      return [];  // Return empty list if any error occurs
    }
  }

  // Add a new receipt to file
  static Future<void> addReceipt(Receipt newReceipt) async {
    try {
      final receipts = await loadReceiptsFromFile();
      receipts.add(newReceipt);
      await saveReceiptsToFile(receipts);
    } catch (e) {
      // Handle any error that may occur during file reading or saving
    }
  }
}
