import '../../util.dart';

const List<int> inputs = [0, 1, 5, 10, 3, 12, 19];
const List<int> exampleInputs = [0, 3, 6];

int main(List<String> args) {
  if (args.length != 1) return 1;

  processPuzzle(1, () => resolve1(inputs));
  processPuzzle(2, () => resolve2(inputs));

  return 0;
}

resolve2(List<int> values) {
  Map<int, int> spoken = {};
  int last = values[values.length - 1];

  for (int i = 0; i < values.length - 1; i++) {
    spoken.putIfAbsent(values[i], () => i + 1);
  }

  for (int turn = values.length; turn < 30000000; turn++) {
    if (!spoken.containsKey(last)) {
      spoken[last] = turn;
      last = 0;
    } else {
      int tmp = turn - spoken[last]!;
      spoken[last] = turn;
      last = tmp;
    }
  }

  return last;
}

resolve1(List<int> values) {
  Map<int, int> spoken = {};
  int last = values[values.length - 1];

  for (int i = 0; i < values.length - 1; i++) {
    spoken.putIfAbsent(values[i], () => i + 1);
  }

  for (int turn = values.length; turn < 2020; turn++) {
    if (!spoken.containsKey(last)) {
      spoken[last] = turn;
      last = 0;
    } else {
      int tmp = turn - spoken[last]!;
      spoken[last] = turn;
      last = tmp;
    }
  }

  return last;
}
