import 'dart:io';

import '../../util.dart';

class Data {
  int lowerBound;
  int higherBound;
  String char;
  String password;

  bool get isValidOldPolicy {
    int occurence = password.split(char).length - 1;

    if (lowerBound <= occurence && higherBound >= occurence) {
      return true;
    }

    return false;
  }

  bool get isValidNewPolicy =>
      (password[lowerBound - 1] == char) ^ (password[higherBound - 1] == char);

  Data(this.lowerBound, this.higherBound, this.char, this.password);

  factory Data.fromString(String str) {
    int indexOfSeparator = str.indexOf("-");
    int indexOfSeparator2 = str.indexOf(" ");
    int indexOfSeparator3 = str.lastIndexOf(" ");

    return Data(
        int.parse(str.substring(0, indexOfSeparator)),
        int.parse(str.substring(indexOfSeparator + 1, indexOfSeparator2)),
        str[indexOfSeparator2 + 1],
        str.substring(indexOfSeparator3 + 1));
  }
}

List<Data> readData(String path) {
  File file = File(path);
  List<String> lines = file.readAsLinesSync();

  return lines.map((e) => Data.fromString(e)).toList();
}

int main(List<String> args) {
  if (args.length != 1) return 1;

  List<Data> data = readData(args[0]);

  processPuzzle(1, () => resolve1(data, (Data data) => data.isValidOldPolicy));
  processPuzzle(2, () => resolve1(data, (Data data) => data.isValidNewPolicy));

  return 0;
}

resolve1(List<Data> data, validator) {
  int counter = 0;

  for (Data d in data) {
    counter += validator(d) ? 1 : 0;
  }

  return counter;
}
