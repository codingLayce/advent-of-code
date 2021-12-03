import '../../errors.dart';
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
  List<int> bitsSet = List.filled(data[0].length, 0);
  List<int> bitsUnset = List.filled(data[0].length, 0);

  for (int i = 0; i < data[0].length; i++) {
    for (String line in data) {
      if (line[i] == "1") {
        bitsSet[i]++;
      } else {
        bitsUnset[i]++;
      }
    }
  }

  String gammaRateStr = "";
  for (int i = 0; i < bitsSet.length; i++) {
    if (bitsSet[i] > bitsUnset[i]) {
      gammaRateStr = "${gammaRateStr}1";
    } else {
      gammaRateStr = "${gammaRateStr}0";
    }
  }

  String epsilonRateStr = "";
  for (int i = 0; i < gammaRateStr.length; i++) {
    if (gammaRateStr[i] == "1") {
      epsilonRateStr = "${epsilonRateStr}0";
    } else {
      epsilonRateStr = "${epsilonRateStr}1";
    }
  }

  int gammaRate = int.parse(gammaRateStr, radix: 2);
  int epsilonRate = int.parse(epsilonRateStr, radix: 2);

  return gammaRate * epsilonRate;
}

Future<int> resolve2(List<String> data) async {
  return 0;
}
