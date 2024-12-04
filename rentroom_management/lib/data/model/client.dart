import 'dart:convert';
import 'dart:io';

class Client {
  final String fullName;
  final int phoneNumber;
  final String nationalId;

  // Static file path
  static const String filePath = 'database/client.json';

  // Constructor
  Client({
    required this.fullName,
    required this.phoneNumber,
    required this.nationalId,
  });

  // Serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'nationalId': nationalId,
    };
  }

  // Deserialize from JSON
  static Client fromJson(Map<String, dynamic> json) {
    return Client(
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      nationalId: json['nationalId'],
    );
  }

  // Load clients from file
  static Future<List<Client>> loadClients() async {
    final file = File(filePath);

    // Create file if it doesn't exist
    if (!file.existsSync()) {
      file.createSync(recursive: true);
      await file.writeAsString(jsonEncode([]));
    }

    final jsonString = await file.readAsString();
    final List<dynamic> jsonData = jsonDecode(jsonString);

    return jsonData.map((clientJson) => Client.fromJson(clientJson)).toList();
  }

  // Save clients to file
  static Future<void> saveClients(List<Client> clients) async {
    final file = File(filePath);
    final jsonString =
        jsonEncode(clients.map((client) => client.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  // Add a client
  static Future<void> addClient(Client newClient) async {
    final clients = await loadClients();
    if (clients.any((client) => client.nationalId == newClient.nationalId)) {
      return;
    }
    clients.add(newClient);
    await saveClients(clients);
  }

  // Remove a client
  static Future<void> removeClient(String nationalId) async {
    final clients = await loadClients();
    final updatedClients =
        clients.where((client) => client.nationalId != nationalId).toList();
    if (clients.length == updatedClients.length) {
      return;
    }
    await saveClients(updatedClients);
  }

  // Update a client
  static Future<void> updateClient(
      String nationalId, Client updatedClient) async {
    final clients = await loadClients();
    final index =
        clients.indexWhere((client) => client.nationalId == nationalId);
    if (index == -1) {
      return;
    }
    clients[index] = updatedClient;
    await saveClients(clients);
  }
}
