import 'dart:convert';
import 'dart:io';
import 'package:rentroom_management/data/model/service.dart';
import 'package:rentroom_management/data/model/building.dart';

class Room {
  final int roomNumber;
  final double roomPrice;
  double currentWaterUsed;
  double currentElecticUsed;
  double lastWaterUsed;
  double lastElecticUsed;
  final List<Service> servicese;
  final Building buildingName;

  static const String filePath = 'database/rooms.json';

  // Constructor
  Room({
    required this.roomNumber,
    required this.roomPrice,
    required this.currentWaterUsed,
    required this.currentElecticUsed,
    required this.lastWaterUsed,
    required this.lastElecticUsed,
    required this.servicese,
    required this.buildingName,
  });

  // Add a service to the room
  void addService(Service service) {
    servicese.add(service);
    saveRoomToFile();
  }

  // Remove a service from the room based on the service ID
  void removeService(int serviceId) {
    servicese.removeWhere((service) => service.serviceId == serviceId);
    saveRoomToFile();
  }

  // Update the last month's water and electric usage
  void updateUsage() {
    lastWaterUsed = currentWaterUsed;
    lastElecticUsed = currentElecticUsed;
    saveRoomToFile();
  }

  // Serialize the Room to JSON
  Map<String, dynamic> toJson() {
    return {
      'roomNumber': roomNumber,
      'roomPrice': roomPrice,
      'currentWaterUsed': currentWaterUsed,
      'currentElecticUsed': currentElecticUsed,
      'lastWaterUsed': lastWaterUsed,
      'lastElecticUsed': lastElecticUsed,
      'servicese': servicese.map((service) => service.toJson()).toList(),
      'buildingName': buildingName.name,
    };
  }

  // Deserialize a Room from JSON
  static Room fromJson(Map<String, dynamic> json) {
    return Room(
      roomNumber: json['roomNumber'] ?? '',
      roomPrice: (json['roomPrice'] ?? 0.0) as double, 
      currentWaterUsed:
          (json['currentWaterUsed'] ?? 0),
      currentElecticUsed:
          (json['currentElecticUsed'] ?? 0), 
      lastWaterUsed:
          (json['lastWaterUsed'] ?? 0), 
      lastElecticUsed:
          (json['lastElecticUsed'] ?? 0),
      servicese: (json['servicese'] as List<dynamic>?)
              ?.map((serviceJson) => Service.fromJson(serviceJson))
              .toList() ??
          [], 
      buildingName: Building.fromJson(
          json['building'] ?? {}),
    );
  }

  // Save the Room object to a JSON file
  Future<void> saveRoomToFile() async {
    final file = File(filePath);
    final jsonString = jsonEncode(toJson());
    await file.writeAsString(jsonString);
  }

  // Load a Room object from a JSON file
  static Future<Room> loadRoomFromFile() async {
    final file = File(filePath);

    if (!file.existsSync()) {
      file.createSync(recursive: true);
      await file.writeAsString(jsonEncode({}));
    }

    final jsonString = await file.readAsString();
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    return Room.fromJson(jsonData);
  }
}
