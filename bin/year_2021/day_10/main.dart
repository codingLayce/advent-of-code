import '../../util.dart';

final List<String> openings = ["(", "[", "{", "<"];
final Map<String, String> mapping = {"(": ")", "[": "]", "{": "}", "<": ">"};
final Map<String, int> pointsPart1 = {")": 3, "]": 57, "}": 1197, ">": 25137};
final Map<String, int> pointsPart2 = {")": 1, "]": 2, "}": 3, ">": 4};

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
  List<String> illegalChars = [];
  List<String> tmp = List.from(data);

  for (String line in tmp) {
    List<String> openChunks = [];
    bool founded = false;

    for (int i = 0; i < line.length && !founded; i++) {
      if (openings.contains(line[i])) {
        openChunks.add(line[i]);
      } else {
        String opener = openChunks.removeLast();
        if (mapping[opener]! != line[i]) {
          illegalChars.add(line[i]);
          founded = true;
          data.remove(
              line); // Here is to simplify the part 2, because the remaining ones are the incomplete
        }
      }
    }
  }

  return illegalChars.fold<int>(
      0, (previousValue, element) => previousValue + pointsPart1[element]!);
}

Future<int> resolve2(List<String> data) async {
  List<int> points = [];

  for (String line in data) {
    List<String> openChunks = [];

    for (int i = 0; i < line.length; i++) {
      if (openings.contains(line[i])) {
        openChunks.add(line[i]);
      } else {
        openChunks.removeLast();
      }
    }

    points.add(openChunks.reversed.fold<int>(
        0,
        (previousValue, element) =>
            previousValue * 5 + pointsPart2[mapping[element]]!));
  }

  points.sort();

  return points[(points.length / 2).floor()];
}
