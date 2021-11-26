import 'dart:collection';

import '../../util.dart';

int main(List<String> args) {
  if (args.length != 1) return 1;

  List<int> data = readIntData(args[0]);

  processPuzzle(1, () => resolve1(data));
  processPuzzle(2, () => resolve2(data));

  return 0;
}

resolve2(List<int> data) {
  int invalidValue = resolve1(data);

  List<int> list = [];
  int index = 0;

  while (index < data.length) {
    for (int i = index; i < data.length; i++) {
      list.add(data[i]);

      if (sumList(list) == invalidValue) {
        return sumSmallLarge(list);
      } else if (sumList(list) > invalidValue) {
        break;
      }
    }

    list.clear();
    index++;
  }

  return -1;
}

resolve1(List<int> data) {
  ListQueue<int> lastNumbers = ListQueue(25);

  for (int i = 0; i < data.length; i++) {
    int val = data[i];
    if (i < 25) {
      lastNumbers.addFirst(val);
    } else {
      if (!solutionExists(lastNumbers, val)) return val;
      lastNumbers.removeLast();
      lastNumbers.addFirst(val);
    }
  }

  return -1;
}

bool solutionExists(ListQueue<int> numbers, int value) {
  for (int a in numbers) {
    for (int b in numbers) {
      if (a != b && a + b == value) return true;
    }
  }

  return false;
}

int sumSmallLarge(List<int> numbers) {
  return smallestElement(numbers) + largestElement(numbers);
}
