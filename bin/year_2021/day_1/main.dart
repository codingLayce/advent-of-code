import '../../util.dart';

int main(List<String> args) {
  if (args.length != 1) {
    return 1;
  }

  List<int> data = readIntData(args[0]);

  processPuzzle(1, () => resolve1(data));

  processPuzzle(2, () => resolve2(data));

  return 0;
}

int resolve1(List<int> data) {
  int count = 0;

  for (int i = 1; i < data.length; i++) {
    if (data[i] > data[i - 1]) count++;
  }

  return count;
}

int resolve2(List<int> data) {
  int count = 0;
  int previousSum = double.maxFinite.toInt();

  for (int i = 2; i < data.length; i++) {
    int sum = data[i] + data[i - 1] + data[i - 2];
    if (sum > previousSum) {
      count++;
    }
    previousSum = sum;
  }

  return count;
}
