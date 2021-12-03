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
  String gammaRateStr = "";
  for (int i = 0; i < data[0].length; i++) {
    gammaRateStr = "$gammaRateStr${findMostCommonBit(data, i)}";
  }

  String epsilonRateStr = "";
  for (int i = 0; i < data[0].length; i++) {
    epsilonRateStr = "$epsilonRateStr${findLeastCommonBit(data, i)}";
  }

  int gammaRate = int.parse(gammaRateStr, radix: 2);
  int epsilonRate = int.parse(epsilonRateStr, radix: 2);

  return gammaRate * epsilonRate;
}

Future<int> resolve2(List<String> data) async {
  int oxygenGenratorRating = getOxygenGeneratorRating(List.from(data), 0);
  int co2ScrubberRating = getCo2ScrubberRating(List.from(data), 0);

  return oxygenGenratorRating * co2ScrubberRating;
}

int getCo2ScrubberRating(List<String> data, int index) {
  int leastCommonBit = findLeastCommonBit(data, index);
  data.removeWhere((element) => element[index] != "$leastCommonBit");
  if (data.length == 1) return int.parse(data.single, radix: 2);
  return getCo2ScrubberRating(data, index + 1);
}

int getOxygenGeneratorRating(List<String> data, int index) {
  int mostCommonBit = findMostCommonBit(data, index);
  data.removeWhere((element) => element[index] != "$mostCommonBit");
  if (data.length == 1) return int.parse(data.single, radix: 2);
  return getOxygenGeneratorRating(data, index + 1);
}

int findLeastCommonBit(List<String> data, int index) {
  return findMostCommonBit(data, index) == 1 ? 0 : 1;
}

int findMostCommonBit(List<String> data, int index) {
  int countSet = 0;

  for (String line in data) {
    if (line[index] == "1") countSet++;
  }

  return countSet >= data.length / 2 ? 1 : 0;
}
