enum Direction { north, east, south, west }

class Robot {
  int x, y;
  Direction direction;
  
  // constructor
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
    print('Initial Position: ($x, $y), Facing: $direction');
    
    for (var instruction in instructions.split('')) {
      if (instruction == 'R' || instruction == 'r') {
        turnRight();
      } else if (instruction == 'L' || instruction == 'l') {
        turnLeft();
      } else if (instruction == 'A' || instruction == 'a') {
        advance();
      }
    }

    print('Final Position: ($x, $y), Facing: $direction');
  }
}

void main() {
  var robot = Robot(7, 3, Direction.north);
  robot.execute('la');
}
