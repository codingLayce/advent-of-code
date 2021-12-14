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
  return run(data, 10);
}

Future<int> resolve2(List<String> data) async {
  return run(data, 40);
}

int run(List<String> data, int maxSteps) {
  Map<String, String> pairs = parsePairs(data.sublist(2));

  Map<String, int> polymer = getModel(data[0]);
  for (int i = 0; i < maxSteps; i++) {
    polymer = apply2(pairs, polymer);
  }

  return count2(polymer);
}

int count2(Map<String, int> polymer) {
  Map<String, int> map = {};

  for (MapEntry<String, int> entry in polymer.entries) {
    int value = entry.value ~/ 2;
    map.update(entry.key[0], (existing) => existing + value,
        ifAbsent: () => value);
    map.update(entry.key[1], (existing) => existing + value,
        ifAbsent: () => value);
  }

  return largestElement(map.values.toList()) -
      smallestElement(map.values.toList());
}

Map<String, int> apply2(Map<String, String> pairs, Map<String, int> polymer) {
  Map<String, int> next = {};

  for (MapEntry<String, int> entry in polymer.entries) {
    if (pairs.containsKey(entry.key)) {
      String pair1 = "${entry.key[0]}${pairs[entry.key]}";
      String pair2 = "${pairs[entry.key]}${entry.key[1]}";
      next.update(pair1, (existing) => existing + entry.value,
          ifAbsent: () => entry.value);
      next.update(pair2, (existing) => existing + entry.value,
          ifAbsent: () => entry.value);
    }
  }

  return next;
}

Map<String, int> getModel(String polymerStr) {
  Map<String, int> polymer = {};
  for (int i = 1; i < polymerStr.length; i++) {
    polymer.update(
        polymerStr.substring(i - 1, i + 1), (existing) => existing + 1,
        ifAbsent: () => 1);
  }
  return polymer;
}

Map<String, String> parsePairs(List<String> data) {
  Map<String, String> pairs = {};

  for (String line in data) {
    var arr = line.split(" -> ");
    pairs[arr[0]] = arr[1];
  }

  return pairs;
}
