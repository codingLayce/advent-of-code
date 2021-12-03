import 'package:test/test.dart';

import '../../../bin/errors.dart';
import '../../test_util.dart';
import '../../../bin/util.dart';
import '../../../bin/year_2021/day_3/main.dart';

List<Test> testCases1 = [
  Test(
      "Nominal example - OK",
      readStringData("bin/year_2021/day_3/input_example.txt"),
      resolve1,
      198,
      null),
  Test("Puzzle - OK", readStringData("bin/year_2021/day_3/input.txt"), resolve1,
      1092896, null),
];

List<Test> testCases2 = [
  Test(
      "Nominal example - OK",
      readStringData("bin/year_2021/day_3/input_example.txt"),
      resolve2,
      230,
      null),
  Test("Puzzle - OK", readStringData("bin/year_2021/day_3/input.txt"), resolve2,
      4672151, null),
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
