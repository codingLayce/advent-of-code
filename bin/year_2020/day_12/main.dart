import '../../util.dart';

int main(List<String> args) {
  if (args.length != 1) return 1;

  List<String> data = readStringData(args[0]);

  processPuzzle(1, () => resolve1(data));
  processPuzzle(2, () => resolve2(data));

  return 0;
}

resolve2(List<String> data) {
  Boat2 boat = Boat2();

  for (String action in data) {
    boat.process(action);
  }

  return boat.pos.x.abs() + boat.pos.y.abs();
}

resolve1(List<String> data) {
  Boat boat = Boat();

  for (String action in data) {
    boat.process(action);
  }

  return boat.pos.x.abs() + boat.pos.y.abs();
}

class Boat2 {
  Vector pos = Vector(0, 0);
  Vector waypoint = Vector(10, 1);

  void process(String action) {
    String op = action[0];
    int value = int.parse(action.substring(1));

    switch (op) {
      case "N":
        waypoint.add(y: value);
        break;
      case "S":
        waypoint.minus(y: value);
        break;
      case "E":
        waypoint.add(x: value);
        break;
      case "W":
        waypoint.minus(x: value);
        break;
      case "L":
        waypoint.rotate(360 - value);
        break;
      case "R":
        waypoint.rotate(value);
        break;
      case "F":
        pos.addVector(Vector.copy(waypoint)..multiply(value));
        break;
    }
  }
}

class Boat {
  Vector pos = Vector(0, 0);
  Vector direction = Vector(1, 0);

  void process(String action) {
    String op = action[0];
    int value = int.parse(action.substring(1));

    switch (op) {
      case "N":
        pos.add(y: value);
        break;
      case "S":
        pos.minus(y: value);
        break;
      case "E":
        pos.add(x: value);
        break;
      case "W":
        pos.minus(x: value);
        break;
      case "L":
        direction.rotate(360 - value);
        break;
      case "R":
        direction.rotate(value);
        break;
      case "F":
        pos.addVector(Vector.copy(direction)..multiply(value));
        break;
    }

    //print("$action --> ($x:$y) $direction");
  }
}
