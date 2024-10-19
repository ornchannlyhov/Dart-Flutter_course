enum Skill {
  FLUTTER("Flutter", 5000),
  DART("Dart", 3000),
  PHP("PHP", 2000),
  PYTHON("Python", 3500),
  JAVA("Java", 4500),
  JAVASCRIPT("JavaScript", 3200),
  OTHER("Other", 1000);

  final String label;
  final double salaryBase;
  const Skill(this.label, this.salaryBase);
  
  String toString() => this.label;
}

class Address {
  String _street;
  int _zipCode;
  Address(this._street, this._zipCode);
  String get street => _street;
  int get zipCode => _zipCode;

  String toString() => 'street: $_street, zip code: $_zipCode';
}

class Employee {
  final String _name;
  final double _baseSalary;
  List<Skill> _skill = [];
  final int _experience;
  final Address _address;

  // Default constructor
  Employee(this._name, this._skill, this._experience, this._baseSalary,
      this._address);

  // Named constructor for mobile developers
  Employee.mobileDev(
      {required String name,
      required int experience,
      required double baseSalary,
      required Address address})
      : _name = name,
        _experience = experience,
        _baseSalary = baseSalary,
        _address = address {
    _skill = [Skill.FLUTTER, Skill.DART];
  }

  // Named constructor for web developers
  Employee.webDev(
      {required String name,
      required int experience,
      required double baseSalary,
      required Address address})
      : _name = name,
        _experience = experience,
        _baseSalary = baseSalary,
        _address = address {
    _skill = [Skill.PHP, Skill.JAVASCRIPT, Skill.PYTHON];
  }

  // Named constructor for Android developers
  Employee.androidDev(
      {required String name,
      required int experience,
      required double baseSalary,
      required Address address})
      : _name = name,
        _experience = experience,
        _baseSalary = baseSalary,
        _address = address {
    _skill = [Skill.JAVA, Skill.OTHER];
  }

  // Getters for private attributes
  String get name => _name;
  double get baseSalary => _baseSalary;
  List<Skill> get skill => List.unmodifiable(_skill);
  int get experience => _experience;
  Address get address => _address;

  //compute salary
  double salaryCompute() {
    return _baseSalary +
        _skill.fold(0, (total, skill) => total + skill.salaryBase) +
        _experience * 2000;
  }

  
  String toString() {
    return 'Name: $_name\n'
        'Skills: $_skill\n'
        'Experience: $_experience years \n'
        'Base Salary: $_baseSalary\n'
        'Address: $_address\n'
        'Total Salary: ${salaryCompute()} \$ \n'
        '---------------------------------';
  }
}

void main() {
  var emp1 = Employee.webDev(
    name: 'Sokea',
    experience: 6,
    baseSalary: 40000,
    address: Address('123 Main St', 12345),
  );
  print(emp1);
  var emp2 = Employee.mobileDev(
    name: 'Ronan',
    experience: 4,
    baseSalary: 45000,
    address: Address('123 Main St', 12345),
  );
  print(emp2);
}
