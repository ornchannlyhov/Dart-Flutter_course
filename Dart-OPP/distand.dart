class Distance {
  final double _meters;

  //default constructor
  Distance([double meters = 0]) : _meters = meters; // defualtly set meters to 0 if no argument 
  // named constructor
  Distance.kms(double kms) : _meters = kms * 1000;
  Distance.meters(double meters) : _meters = meters;
  Distance.cms(double cms) : _meters = cms / 100;

  double get kms => _meters / 1000;
  double get meters => _meters;
  double get cms => _meters * 100;

  // overload
  // Distance add (Distance other) => Distance.meters(_meters + other._meters);
  Distance operator +(Distance other) =>
      Distance.meters(_meters + other._meters);
}

void main() {

  //use named constructor
  Distance d1 = Distance.kms(3.4);
  Distance d2 = Distance.meters(1000);
  
  //use default constructor
  Distance d3 = Distance(500);

  print((d1 + d2).cms);
  print('-------------');
  print((d1 + d2).meters);
  print('-------------');
  print((d1 + d2).kms);
  print('-------------');
  print((d1 + d3).meters);
}
