import '../../util.dart';

Map<int, int> mappingByLength = {2: 1, 3: 7, 4: 4, 7: 8};

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
  int count = 0;
  List<int> easyLength = [2, 3, 4, 7];

  for (String line in data) {
    var arr = line.split(" | ");
    for (String output in arr[1].split(" ")) {
      if (easyLength.contains(output.length)) count++;
    }
  }

  return count;
}

Future<int> resolve2(List<String> data) async {
  List<Wires> wires = [];
  for (String line in data) {
    wires.add(Wires.fromString(line));
  }

  int sum = 0;
  for (Wires w in wires) {
    sum += w.process();
  }

  return sum;
}

class Wires {
  final List<String> wires;
  final List<int> correspondings = List.filled(10, -1);
  final List<String> output;

  Wires(this.wires, this.output);

  factory Wires.fromString(String line) {
    List<String> wires = [];
    List<String> output = [];

    var arr = line.split(" | ");
    for (String wire in arr[1].split(" ")) {
      output.add(wire);
    }
    for (String wire in arr[0].split(" ")) {
      wires.add(wire);
    }

    return Wires(wires, output);
  }

  int _decode() {
    String decoded = "";
    for (String wire in output) {
      decoded = "$decoded${_findCorresponding(wire)}";
    }
    return int.parse(decoded);
  }

  int process() {
    for (int i = 0; i < wires.length; i++) {
      String wire = wires[i];
      if (mappingByLength.containsKey(wire.length)) {
        correspondings[mappingByLength[wire.length]!] = i;
      }
    }
    _determineLength5();
    _determineLength6();

    return _decode();
  }

  int _findCorresponding(String wire) {
    for (int i = 0; i < correspondings.length; i++) {
      String mapped = wires[correspondings[i]];
      if (wire.length == mapped.length &&
          _countCommon(wire, mapped) == wire.length) return i;
    }

    return -1;
  }

  void _determineLength6() {
    // Find 6 & 9 & 0
    List<String> possibles = _getOfLength(6);

    // Find 9 (the only one which includes all the parts of 4)
    String neuf = "";
    String quatre = wires[correspondings[4]];
    for (String wire in possibles) {
      if (_countCommon(quatre, wire) == quatre.length) {
        neuf = wire;
        break;
      }
    }
    correspondings[9] = wires.indexOf(neuf);
    possibles.remove(neuf);

    String un = wires[correspondings[1]];

    // Find 0 (the only one which includes all the parts of 1) and 6 (the one remaining)
    if (_countCommon(possibles[0], un) == 2) {
      correspondings[0] = wires.indexOf(possibles[0]);
      correspondings[6] = wires.indexOf(possibles[1]);
    } else {
      correspondings[0] = wires.indexOf(possibles[1]);
      correspondings[6] = wires.indexOf(possibles[0]);
    }
  }

  void _determineLength5() {
    // Find the 2, 3 & 5
    List<String> possibles = _getOfLength(5);

    // Find the 3 (the only one which includes all the parts of 1)
    String trois = _getTrois(possibles);
    correspondings[3] = wires.indexOf(trois);
    possibles.remove(trois);

    // Find the 5 (the only one with 3 parts included in 4)
    String cinq = _getFive(possibles);
    correspondings[5] = wires.indexOf(cinq);

    // Find 2 (the one remaining)
    possibles.remove(cinq);
    correspondings[2] = wires.indexOf(possibles.first);
  }

  String _getFive(List<String> possibles) {
    String quatre = wires[correspondings[4]];
    for (String wire in possibles) {
      if (_countCommon(quatre, wire) == 3) {
        return wire;
      }
    }
    return "";
  }

  List<String> _getOfLength(int length) {
    List<String> get = [];
    for (int i = 0; i < wires.length; i++) {
      if (wires[i].length == length) get.add(wires[i]);
    }
    return get;
  }

  String _getTrois(List<String> possibles) {
    String un = wires[correspondings[1]];
    for (String wire in possibles) {
      if (_countCommon(un, wire) == 2) {
        return wire;
      }
    }
    return "";
  }

  int _countCommon(String a, String b) {
    int count = 0;

    for (int i = 0; i < a.length; i++) {
      for (int j = 0; j < b.length; j++) {
        if (a[i] == b[j]) count++;
      }
    }

    return count;
  }
}
