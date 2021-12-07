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
  List<int> values = stringListToIntList(data[0].split(","));

  // Dumb solution
  // Look for all possibilities from 0 to largest horizontal position,
  // and take the best one.
  int best = double.maxFinite.toInt();
  for (int i = 0; i < largestElement(values); i++) {
    int fuel = 0;
    for (int value in values) {
      fuel += (i - value).abs();
    }
    if (fuel < best) {
      best = fuel;
    }
  }

  return best;
}

Future<int> resolve2(List<String> data) async {
  List<int> values = stringListToIntList(data[0].split(","));

  // Still dumb solution.
  int best = double.maxFinite.toInt();
  for (int i = 0; i < largestElement(values); i++) {
    int fuel = 0;
    for (int value in values) {
      fuel += fuelPart2(value, i);
    }

    if (fuel < best) {
      best = fuel;
    }
  }

  return best;
}

int fuelPart2(int a, int b) {
  int v = (a - b).abs();
  int fuel = 0;

  for (int i = 1; i <= v; i++) {
    fuel += i;
  }

  return fuel;
}
