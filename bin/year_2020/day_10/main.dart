import 'dart:collection';

import '../../util.dart';

int main(List<String> args) {
  if (args.length != 1) return 1;

  List<int> data = readIntData(args[0]);

  processPuzzle(1, () => resolve1(data));

  return 0;
}

resolve1(List<int> data) {
  ListQueue<int> chain = run(List.from(data), 0, ListQueue(), data.length);

  print(chain);

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

  List<int> possible = getPossibles(unused, joltage);

  for (int val in possible) {
    chain.add(val);
    unused.remove(val);
    ListQueue<int> sub = run(unused, val, chain, target);
    if (sub.length == target) return sub;
  }

  return chain;
}

List<int> getPossibles(List<int> unused, int joltage) {
  List<int> possible = List.from(unused);
  possible.removeWhere(
      (element) => (element <= joltage) || (element > joltage + 3));
  return possible;
}
