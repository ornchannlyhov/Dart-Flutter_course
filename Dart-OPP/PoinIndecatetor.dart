class PointIndicator {
  final int? _x;
  final int? _y;

  // Constructor
  PointIndicator({int? x, int? y})
      : _x = x,
        _y = y;

  // Getters
  int? get x => _x;
  int? get y => _y;

  PointIndicator translate(int dx, int dy) {
    final newX = (_x ?? 0) + dx;
    final newY = (_y ?? 0) + dy;
    return PointIndicator(x: newX, y: newY);
  }

  Map<String, int> getWidthAndHeight(PointIndicator other) {
    final width = (_x ?? 0) - (other.x ?? 0);
    final height = (_y ?? 0) - (other.y ?? 0);

    return {
      'width': width.abs(),
      'height': height.abs(),
    };
  }

  @override
  String toString() {
    return 'Point (x: $_x, y: $_y)';
  }
}

void main() {
  PointIndicator point1 = PointIndicator(x: 3, y: 5);
  PointIndicator point2 = PointIndicator(x: 1, y: 2);

  Map<String, int> dimensions = point1.getWidthAndHeight(point2);
  print('Width: ${dimensions['width']}, Height: ${dimensions['height']}');
}
