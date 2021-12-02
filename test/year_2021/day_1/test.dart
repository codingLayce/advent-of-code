import 'package:test/test.dart';

import '../../../bin/errors.dart';
import '../../test_util.dart';
import '../../../bin/util.dart';
import '../../../bin/year_2021/day_1/main.dart';

List<Test> testCases1 = [
  Test(
      "Nominal example - OK",
      readStringData("bin/year_2021/day_1/input_example.txt"),
      resolve1,
      7,
      null),
  Test("Puzzle - OK", readStringData("bin/year_2021/day_1/input.txt"), resolve1,
      1215, null),
  Test("Empty data - KO", [], resolve1, null, isA<EmptyDataException>())
];

List<Test> testCases2 = [
  Test(
      "Nominal example - OK",
      readStringData("bin/year_2021/day_1/input_example.txt"),
      resolve2,
      5,
      null),
  Test("Puzzle - OK", readStringData("bin/year_2021/day_1/input.txt"), resolve2,
      1150, null),
  Test("Empty data - KO", [], resolve2, null, isA<EmptyDataException>())
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
