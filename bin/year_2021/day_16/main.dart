import '../../util.dart';

Map<String, String> mapping = {
  "0": "0000",
  "1": "0001",
  "2": "0010",
  "3": "0011",
  "4": "0100",
  "5": "0101",
  "6": "0110",
  "7": "0111",
  "8": "1000",
  "9": "1001",
  "A": "1010",
  "B": "1011",
  "C": "1100",
  "D": "1101",
  "E": "1110",
  "F": "1111",
};

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
  Solver solver = Solver(hexaToBinary(data[0]));
  solver.compute();
  return solver.sumVersions;
}

Future<int> resolve2(List<String> data) async {
  Solver solver = Solver(hexaToBinary(data[0]));
  return solver.compute();
}

String hexaToBinary(String hexa) {
  String mapped = "";

  for (int i = 0; i < hexa.length; i++) {
    mapped = "$mapped${mapping[hexa[i]]}";
  }

  return mapped;
}

class Solver {
  final String binary;
  int sumVersions = 0;

  int cursor = 0;

  Solver(this.binary);

  int compute() {
    String header = binary.substring(cursor, cursor + 6);
    int version = int.parse(header.substring(0, 3), radix: 2);
    int typeID = int.parse(header.substring(3), radix: 2);

    sumVersions += version;
    cursor += 6;

    if (typeID == 4) {
      String current = binary.substring(cursor, cursor + 5);
      cursor += 5;
      String number = "";
      while (current.startsWith("1")) {
        number = "$number${current.substring(1)}";
        current = binary.substring(cursor, cursor + 5);
        cursor += 5;
      }
      number = "$number${current.substring(1)}";

      return int.parse(number, radix: 2);
    }

    String lengthTypeID = binary[cursor];
    cursor++;

    List<int> values = [];
    if (lengthTypeID == "0") {
      String lengthSubStr = binary.substring(cursor, cursor + 15);
      cursor += 15;
      int lengthSub = int.parse(lengthSubStr, radix: 2);
      int toReach = cursor + lengthSub;
      while (cursor < toReach) {
        values.add(compute());
      }
    } else {
      String nbSubStr = binary.substring(cursor, cursor + 11);
      cursor += 11;
      int nbSub = int.parse(nbSubStr, radix: 2);
      int nb = 0;
      while (nb < nbSub) {
        values.add(compute());
        nb++;
      }
    }

    return computeValues(values, typeID);
  }

  int computeValues(List<int> values, int typeID) {
    switch (typeID) {
      case 0:
        return sumList(values);
      case 1:
        return productList(values);
      case 2:
        return smallestElement(values);
      case 3:
        return largestElement(values);
      case 5:
        return values[0] > values[1] ? 1 : 0;
      case 6:
        return values[0] > values[1] ? 0 : 1;
      case 7:
        return values[0] == values[1] ? 1 : 0;
    }

    return 0;
  }
}
