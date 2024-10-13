enum Direction { north, east, south, west }

class Robot {
  int x, y;
  Direction direction;

  Robot(this.x, this.y, this.direction);

  void turnRight() {
    direction = Direction.values[(direction.index + 1) % 4];
  }

  void turnLeft() {
    direction = Direction.values[(direction.index + 3) % 4];
  }

  void advance() {
    switch (direction) {
      case Direction.north:
        y++;
        break;
      case Direction.east:
        x++;
        break;
      case Direction.south:
        y--;
        break;
      case Direction.west:
        x--;
        break;
    }
  }

  void execute(String instructions) {
    for (var instruction in instructions.split('')) {
      if (instruction == 'R') {
        turnRight();
      } else if (instruction == 'L') {
        turnLeft();
      } else if (instruction == 'A') {
        advance();
      }
    }
  }

  @override
  String toString() {
    return 'Position: {$x, $y}, Facing: $direction';
  }
}

void main() {
  var robot = Robot(7, 3, Direction.north);
  robot.execute('RAALAL');
  print(robot);
}
