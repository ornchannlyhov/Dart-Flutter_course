enum Skill {
  FLUTTER("Flutter"),
  DART("Dart"),
  PHP("PHP"),
  PYTHON("Python"),
  JAVA("Java"),
  JAVASCRIPT("JavaScript"),
  OTHER("Other");

  final String label;
  const Skill(this.label);
  String toString() => this.label;
}

class Address {
  String street;
  int zipCode;

  Address(this.street, this.zipCode);

  String toString() => 'street: $street, zip code: $zipCode';
}

class Employee {
  String _name;
  double _baseSalary;
  List<Skill>? _skill = [];
  int _experience;
  Address _address;

  // Default constructor
  Employee(
      this._name, this._skill, this._experience, this._baseSalary, this._address);

  // Named constructor for mobile developers
  Employee.mobileDev(
      {required this._name,
      required this._experience,
      required this._baseSalary,
      required this._address}) {
      this._skill = [Skill.FLUTTER, Skill.DART];
  }
  Employee.webDev(
      {required this._name,
      required this._experience,
      required this._baseSalary,
      required this._address}) {
      this._skill = [Skill.PHP, Skill.JAVASCRIPT, Skill.PYTHON];
  }
  Employee.androidDev(
      {required this._name,
      required this._experience,
      required this._baseSalary,
      required this._address}) {
      this._skill = [Skill.PYTHON, Skill.JAVA];
  }
}

void main() {
  // var emp1 = Employee('Sokea', 40000);
  // emp1.printDetails();

  // var emp2 = Employee('Ronan', 45000);
  // emp2.printDetails();
}
