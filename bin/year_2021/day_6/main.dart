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
  return solve(data, 80);
}

Future<int> resolve2(List<String> data) async {
  return solve(data, 256 * 10000);
}

int solve(List<String> data, int max) {
  List<int> lanternFishes = stringListToIntList(data[0].split(","));

  List<int> cache = List.filled(max, 0);

  for (int i = max - 1; i > 0; i--) {
    int count = 1;

    if (i + 7 < max) {
      count += cache[i + 7 - 1];
    }
    if (i + 9 < max) {
      count += cache[i + 9 - 1];
    }

    cache[i - 1] = count;
  }

  int sum = lanternFishes.length;
  for (int i in lanternFishes) {
    sum += cache[i - 1];
  }

  return sum;
}
