enum Color {
  red,
  green,
  blue,
  yellow,
  orange,
  purple,
  black,
  white,
  transparent;

  String get displayName {
    switch (this) {
      case Color.red:
        return 'Red';
      case Color.green:
        return 'Green';
      case Color.blue:
        return 'Blue';
      case Color.yellow:
        return 'Yellow';
      case Color.orange:
        return 'Orange';
      case Color.purple:
        return 'Purple';
      case Color.black:
        return 'Black';
      case Color.white:
        return 'White';
      case Color.transparent:
        return 'Transparent';
      default:
        return 'Unknown Color';
    }
  }
}

enum Country {
  CAMBODIA("Cambodia"),
  VIETNAM("Vietnam"),
  FRANCE("France");

  final String label;

  const Country(this.label);

  @override
  String toString() => label;
}

class Window {
  String side;
  int floor;
  Color color;

  // Constructor
  Window(
      {this.color = Color.transparent,
      required this.side,
      required this.floor});

  @override
  String toString() {
    return 'Window: Color: ${color.displayName}, Side: $side, Floor: $floor';
  }
}

class Roof {
  Color color;
  String type;

  // Constructor
  Roof(this.type, this.color);

  @override
  String toString() {
    return 'Roof: Type: $type, Color: ${color.displayName}';
  }
}

class Door {
  Color color;
  int floor;

  // Constructor
  Door(this.color, this.floor);

  @override
  String toString() {
    return 'Door: Color: ${color.displayName}';
  }
}

class Address {
  final Country country;
  final String city;
  final String street;

  Address(
      {this.country = Country.CAMBODIA,
      required this.city,
      required this.street});

  @override
  String toString() {
    return 'Address: $country, City: $city, Street: $street';
  }
}

class House {
  Address address;
  List<Window> windows;
  Roof roof;
  Door door;

  House(this.windows, this.roof, this.door, this.address);
  @override
  String toString() {
    return '-------------------------------------- \n'
        'My House:\n'
        '${address.toString()}\n'
        '${windows.map((window) => window.toString()).join('\n')}\n'
        '${roof.toString()}\n'
        '${door.toString()}\n'
        '--------------------------------------';
  }
}

void main() {
  // Create instances of components
  var window1 = Window(color: Color.blue, side: 'Front', floor: 1);
  var window2 = Window(color: Color.green, side: 'Front ', floor: 2);
  var roof = Roof('Gable', Color.red);
  var door = Door(Color.black, 1);
  var address = Address(city: 'Phnom Penh', street: 'Street 123');

  var house = House([window1, window2], roof, door, address);

  print(house);
}
