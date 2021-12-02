import '../../errors.dart';
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

Future<int> resolve1(List<String> data) async {
  int horizontal = 0;
  int depth = 0;

  if (data.isEmpty) throw EmptyDataException();

  for (String str in data) {
    var move = str.split(" ");
    String direction = move[0];
    int distance = int.parse(move[1]);

    switch (direction) {
      case "forward":
        horizontal += distance;
        break;
      case "down":
        depth += distance;
        break;
      case "up":
        depth -= distance;
        break;
      default:
        throw InvalidMoveException(direction);
    }
  }

  return horizontal * depth;
}

Future<int> resolve2(List<String> data) async {
  int horizontal = 0;
  int depth = 0;
  int aim = 0;

  if (data.isEmpty) throw EmptyDataException();

  for (String str in data) {
    var move = str.split(" ");
    String direction = move[0];
    int distance = int.parse(move[1]);

    switch (direction) {
      case "forward":
        horizontal += distance;
        depth += (aim * distance);
        break;
      case "down":
        aim += distance;
        break;
      case "up":
        aim -= distance;
        break;
      default:
        throw InvalidMoveException(direction);
    }
  }

  return horizontal * depth;
}
