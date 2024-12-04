import 'package:rentroom_management/data/model/building.dart';
import 'package:rentroom_management/data/model/room.dart';
import 'package:rentroom_management/data/model/service.dart';
import 'package:rentroom_management/data/model/receipt.dart';
import 'package:rentroom_management/data/enum/payment_status.dart';

void main() async {
  Service wifiService =
      Service(serviceId: 1, serviceName: 'WiFi', servicePrice: 30.0);
  Service cleaningService =
      Service(serviceId: 2, serviceName: 'Cleaning', servicePrice: 50.0);

  await Service.addService(wifiService);
  await Service.addService(cleaningService);

  Building building = Building(
    name: 'Building A',
    electricPrice: 1.5,
    waterPrice: 2.0,
    rooms: [],
  );

  await building.saveBuildingToFile(); 

  Room room1 = Room(
    roomNumber: 101,
    roomPrice: 200.0,
    currentWaterUsed: 50,
    currentElecticUsed: 30,
    lastWaterUsed: 40, 
    lastElecticUsed: 25, 
    servicese: [wifiService, cleaningService],
    buildingName: building,
  );

  await room1.saveRoomToFile(); 

  building.rooms.add(room1); 

  await building.saveBuildingToFile();

  double totalPriceFirstMonth = Receipt(
    date: DateTime.now(),
    room: room1,
    paymentStatus: PaymentStatus.paid,
  ).calculateTotalPrice();

  print('First Month - Total Price for Room 101: \$${totalPriceFirstMonth.toStringAsFixed(2)}');

  Receipt receiptFirstMonth = Receipt(
    date: DateTime.now(),
    room: room1,
    paymentStatus: PaymentStatus.paid,
  );
  await Receipt.saveReceiptsToFile([receiptFirstMonth]);

  room1.currentWaterUsed = 60; 
  room1.currentElecticUsed = 40; 

  await room1.saveRoomToFile(); 

  double totalPriceSecondMonth = Receipt(
    date: DateTime.now(),
    room: room1,
    paymentStatus: PaymentStatus.paid,
  ).calculateTotalPrice();

  print('Second Month - Total Price for Room 101: \$${totalPriceSecondMonth.toStringAsFixed(2)}');

  Receipt receiptSecondMonth = Receipt(
    date: DateTime.now(),
    room: room1,
    paymentStatus: PaymentStatus.paid,
  );
  await Receipt.saveReceiptsToFile([receiptSecondMonth]);

  List<Receipt> receipts = await Receipt.loadReceiptsFromFile();
  for (var r in receipts) {
    print('Receipt Date: ${r.date.toIso8601String()} - Status: ${r.paymentStatus}');
  }

  Room loadedRoom = await Room.loadRoomFromFile();
  print('--- Room 101 Info ---');
  print('Room Number: ${loadedRoom.roomNumber}');
  print('Price: \$${loadedRoom.roomPrice}');
  print('Current Water Used: ${loadedRoom.currentWaterUsed}');
  print('Current Electric Used: ${loadedRoom.currentElecticUsed}');
}
