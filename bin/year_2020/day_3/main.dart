import '../../util.dart';

int main(List<String> args) {
  if (args.length != 1) return 1;

  List<String> data = readStringData(args[0]);

  processPuzzle(1, () => resolve1(data));
  processPuzzle(2, () => resolve2(data));

  return 0;
}

resolve2(List<String> data) {
  return count(data, 1, 1) *
      count(data, 3, 1) *
      count(data, 5, 1) *
      count(data, 7, 1) *
      count(data, 1, 2);
}

resolve1(List<String> data) {
  return count(data, 3, 1);
}

count(List<String> data, int right, int down) {
  int counter = 0;
  int x = 0;
  int y = 0;
  final int sizeOfChunk = data[0].length;

  while (y < data.length) {
    int relativeX = x % sizeOfChunk;

    if (data[y][relativeX] == "#") counter++;

    x += right;
    y += down;
  }

  return counter;
}
