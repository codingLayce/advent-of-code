import 'package:test/test.dart';

import '../../../bin/errors.dart';
import '../../../bin/test_util.dart';
import '../../../bin/util.dart';
import '../../../bin/year_2021/day_2/main.dart';

List<Test> testCases1 = [
  Test(
      "Nominal example - OK",
      readStringData("bin/year_2021/day_2/input_example.txt"),
      resolve1,
      150,
      null),
  Test("Puzzl - OK", readStringData("bin/year_2021/day_2/input.txt"), resolve1,
      1714680, null),
  Test("Empty data - KO", [], resolve1, null, isA<EmptyDataException>()),
  Test("Unknown move - KO", ["forward 1", "up 5", "left 8", "down 2"], resolve1,
      null, isA<InvalidMoveException>()),
  Test("Distance not integer - KO", ["forward 1", "up cinq", "down 2"],
      resolve1, null, isA<FormatException>())
];

List<Test> testCases2 = [
  Test(
      "Nominal example - OK",
      readStringData("bin/year_2021/day_2/input_example.txt"),
      resolve2,
      900,
      null),
  Test("Puzzl - OK", readStringData("bin/year_2021/day_2/input.txt"), resolve2,
      1963088820, null),
  Test("Empty data - KO", [], resolve2, null, isA<EmptyDataException>()),
  Test("Unknown move - KO", ["forward 1", "up 5", "left 8", "down 2"], resolve2,
      null, isA<InvalidMoveException>()),
  Test("Distance not integer - KO", ["forward 1", "up cinq", "down 2"],
      resolve2, null, isA<FormatException>())
];

void main() {
  group('Puzzle 1', () {
    for (Test t in testCases1) {
      test(t.name, () async {
        if (t.expectedResult != null) {
          t.testResult();
        } else {
          t.testError();
        }
      });
    }
  });

  group('Puzzle 2', () {
    for (Test t in testCases2) {
      test(t.name, () async {
        if (t.expectedResult != null) {
          t.testResult();
        } else {
          t.testError();
        }
      });
    }
  });
}
