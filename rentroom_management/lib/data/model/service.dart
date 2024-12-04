import 'dart:convert';
import 'dart:io';

class Service {
  final int serviceId;
  final String serviceName;
  final double servicePrice;

  static const String filePath = 'database/services.json';

  Service({
    required this.serviceId,
    required this.serviceName,
    required this.servicePrice,
  });

  // Serialize the Service to JSON
  Map<String, dynamic> toJson() {
    return {
      'serviceId': serviceId,
      'serviceName': serviceName,
      'servicePrice': servicePrice,
    };
  }

  // Deserialize a Service from JSON
  static Service fromJson(Map<String, dynamic> json) {
    return Service(
      serviceId: json['serviceId'] ?? 0, 
      serviceName: json['serviceName'] ?? '',
      servicePrice:
          (json['servicePrice'] ?? 0.0) as double,
    );
  }

  // Save a list of services to a JSON file
  static Future<void> saveServicesToFile(List<Service> services) async {
    final file = File(filePath);
    final jsonString =
        jsonEncode(services.map((service) => service.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  static Future<List<Service>> loadServicesFromFile() async {
    final file = File(filePath);
    if (!file.existsSync()) {
      await file.create(recursive: true);
      await file.writeAsString(jsonEncode([]));
    }
    try {
      final jsonString = await file.readAsString();
      if (jsonString.isEmpty) {
        return [];
      }
      final List<dynamic> jsonData = jsonDecode(jsonString);
      return jsonData
          .map((serviceJson) => Service.fromJson(serviceJson))
          .toList();
    } catch (e) {
      await file.writeAsString(jsonEncode([]));
      return [];
    }
  }

  // Add a new service to the JSON file
  static Future<void> addService(Service newService) async {
    final services = await loadServicesFromFile();
    services.add(newService);
    await saveServicesToFile(services);
  }

  // Remove a service by its ID
  static Future<void> removeService(int serviceId) async {
    final services = await loadServicesFromFile();
    services.removeWhere((service) => service.serviceId == serviceId);
    await saveServicesToFile(services);
  }

  // Update an existing service in the JSON file
  static Future<void> updateService(Service updatedService) async {
    final services = await loadServicesFromFile();
    final index = services
        .indexWhere((service) => service.serviceId == updatedService.serviceId);
    if (index != -1) {
      services[index] = updatedService;
      await saveServicesToFile(services);
    }
  }
}
