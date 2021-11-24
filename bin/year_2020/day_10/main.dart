import '../../util.dart';

int main(List<String> args) {
  if (args.length != 1) return 1;

  List<int> data = readIntData(args[0]);

  processPuzzle(1, () => resolve1(data));

  return 0;
}

resolve1(List<int> data) {}
