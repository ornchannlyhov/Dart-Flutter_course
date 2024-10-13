String scoreCheck(List<int> score) {
  var passed = score.where((s) => s >= 50);
  int totalPassed = passed.length;

  String result = '${passed.toString()}\n$totalPassed students passed';
  return result;
}

void main() {
  print(scoreCheck([45, 78, 62, 49, 85, 33, 90, 50]));
}
