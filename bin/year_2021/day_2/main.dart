import '../../util.dart';

int main(List<String> args) {
  if (args.length != 1) {
    return 1;
  }

  List<String> data = readStringData(args[0]);

  processPuzzle(1, () => resolve1(data));

  processPuzzle(2, () => resolve2(data));

  return 0;
}

int resolve1(List<String> data) {
  int horizontal = 0;
  int depth = 0;

  for (String str in data) {
    var move = str.split(" ");
    String direction = move[0];
    int distance = int.parse(move[1]);

    if (direction == "forward") {
      horizontal += distance;
    } else if (direction == "down") {
      depth += distance;
    } else {
      depth -= distance;
    }
  }

  return horizontal * depth;
}

int resolve2(List<String> data) {
  int horizontal = 0;
  int depth = 0;
  int aim = 0;

  for (String str in data) {
    var move = str.split(" ");
    String direction = move[0];
    int distance = int.parse(move[1]);

    if (direction == "forward") {
      horizontal += distance;
      depth += (aim * distance);
    } else if (direction == "down") {
      aim += distance;
    } else {
      aim -= distance;
    }
  }

  return horizontal * depth;
}
