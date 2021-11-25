import 'dart:collection';

import '../../util.dart';

// My Solver is totaly working, but the number of solution is so huge that it never ends.
class Solver {
  int count = 0;

  void backtrack(List<int> data, int current, int target) {
    if ((current >= target - 3) && (current < target)) {
      count++;
    } else {
      List<int> possibles = getPossibles(data, current);

      for (int possible in possibles) {
        backtrack(data, possible, target);
      }
    }
  }
}

// Dynamic programming solution with cache
class Solver2 {
  Map<int, int> cache = {};

  int nbPathsFromIndex(List<int> data, int index) {
    if (index == data.length - 1) return 1;

    List<int> possibles = getPossiblesIndexes(data, index);

    int sum = 0;
    for (int possible in possibles) {
      if (cache.containsKey(possible)) {
        sum += cache[possible]!;
      } else {
        sum += nbPathsFromIndex(data, possible);
      }
    }

    cache[index] = sum;

    return sum;
  }

  List<int> getPossiblesIndexes(List<int> data, int index) {
    List<int> indexes = [];

    for (int j = index + 1; j <= index + 3; j++) {
      if (j > data.length - 1) return indexes;

      if (data[j] <= data[index] + 3) {
        indexes.add(j);
      }
    }

    return indexes;
  }
}

int main(List<String> args) {
  if (args.length != 1) return 1;

  List<int> data = readIntData(args[0]);

  processPuzzle(1, () => resolve1(data));
  processPuzzle(2, () => resolve2(data));

  return 0;
}

resolve2(List<int> data) {
  int largest = largestElement(data);
  data.add(0);
  data.add(largest + 3);
  data.sort();
  Solver2 solv = Solver2();
  return solv.nbPathsFromIndex(data, 0);
}

resolve1(List<int> data) {
  ListQueue<int> chain = run(List.from(data), 0, ListQueue(), data.length);
  int largest = largestElement(data);
  chain.add(largest + 3);

  return countDifferences(chain);
}

int countDifferences(ListQueue<int> chain) {
  int diff1 = 0;
  int diff3 = 0;
  int previous = 0;

  while (chain.isNotEmpty) {
    int cur = chain.removeFirst();
    if (cur - previous == 1) diff1++;
    if (cur - previous == 3) diff3++;
    previous = cur;
  }

  return diff1 * diff3;
}

ListQueue<int> run(
    List<int> unused, int joltage, ListQueue<int> chain, int target) {
  if (unused.isEmpty) return chain;

  List<int> possibles = getPossibles(unused, joltage);

  int small = smallestElement(possibles);
  return run(unused..remove(small), small, chain..add(small), target);
}

List<int> getPossibles(List<int> unused, int joltage) {
  List<int> possible = List.from(unused);
  possible.removeWhere(
      (element) => (element <= joltage) || (element > joltage + 3));
  return possible;
}
