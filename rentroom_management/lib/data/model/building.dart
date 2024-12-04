import 'dart:convert';
import 'dart:io';
import 'package:rentroom_management/data/model/room.dart';

class Building {
  final String name;
  final double _electricPrice;
  final double _waterPrice;
  List<Room> rooms;

  static const String filePath = 'database/building.json';

  Building({
    required this.name,
    required double electricPrice,
    required double waterPrice,
    required this.rooms,
  })  : _electricPrice = electricPrice,
        _waterPrice = waterPrice;

  void addRoom(Room room) {
    rooms.add(room);
    saveBuildingToFile();
  }

  void removeRoom(int roomNumber) {
    rooms.removeWhere((room) => room.roomNumber == roomNumber);
    saveBuildingToFile();
  }

  Room? getRoom(int roomNumber) {
    return rooms.firstWhere(
      (room) => room.roomNumber == roomNumber,
      // ignore: cast_from_null_always_fails
      orElse: () => null as Room,
    );
  }

  double get getElectricPrice => _electricPrice;
  double get getWaterPrice => _waterPrice;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'electricPrice': getElectricPrice,
      'waterPrice': getWaterPrice,
      'rooms': rooms
          .map((room) => {
                'roomNumber': room.roomNumber,
              })
          .toList(),
    };
  }

  // Deserialize a Building object from JSON
  static Building fromJson(Map<String, dynamic> json) {
    return Building(
      name: json['name'] ?? '',
      electricPrice:
          (json['electricPrice'] ?? 0.0) as double,
      waterPrice:
          (json['waterPrice'] ?? 0.0) as double,
      rooms: (json['rooms'] as List<dynamic>?)
              ?.map((roomJson) => Room.fromJson(roomJson))
              .toList() ??
          [],
    );
  }

  // Save the Building object to a JSON file
  Future<void> saveBuildingToFile() async {
    final file = File(filePath);
    final jsonString = jsonEncode(toJson());
    await file.writeAsString(jsonString);
  }

  // Load a Building object from a JSON file
  static Future<Building> loadBuildingFromFile() async {
    final file = File(filePath);

    if (!file.existsSync()) {
      file.createSync(recursive: true);
      await file.writeAsString(jsonEncode({}));
    }

    final jsonString = await file.readAsString();
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    return Building.fromJson(jsonData);
  }
}
