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

resolve2(List<int> data) {
  for (int i = 0; i < data.length; i++) {
    for (int j = 0; j < data.length; j++) {
      for (int k = 0; k < data.length; k++) {
        if (data[i] + data[j] + data[k] == 2020) {
          return data[i] * data[j] * data[k];
        }
      }
    }
  }

  return 0;
}

resolve1(List<int> data) {
  for (int i = 0; i < data.length; i++) {
    for (int j = 0; j < data.length; j++) {
      if (data[i] + data[j] == 2020) {
        return data[i] * data[j];
      }
    }
  }

  return 0;
}
