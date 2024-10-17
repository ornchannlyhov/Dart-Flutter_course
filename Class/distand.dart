class Distance {
  final double _meters;
  
  // named constructor
  Distance.kms(double kms) : _meters = kms * 1000;
  Distance.meters(double meters) : _meters = meters;
  Distance.cms(double cms) : _meters = cms / 100;

  double get kms => _meters / 1000;
  double get meters => _meters;
  double get cms => _meters * 100;

  Distance operator+ (Distance other) => Distance.meters(_meters + other._meters);
}

void main() {
  Distance d1 = Distance.kms(3.4);
  Distance d2 = Distance.meters(1000);

  print((d1 + d2).kms);
}
