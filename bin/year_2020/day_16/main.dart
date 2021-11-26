import '../../util.dart';

class Range {
  int start;
  int end;

  Range(this.start, this.end);

  factory Range.fromString(String str) {
    var arr = str.split("-");
    return Range(int.parse(arr[0]), int.parse(arr[1]));
  }

  bool contained(int value) {
    return start <= value && value <= end;
  }
}

class Ticket {
  List<int> values;
  bool valid = true;

  Ticket(this.values);
}

class Solver {
  Map<String, List<Range>> classes = {};
  List<Ticket> tickets = [];
  List<int> personalTicket = [];
  Map<String, int> founded = {};
  List<List<String>> fields = [];

  int solve() {
    fields = List.filled(personalTicket.length, []);

    for (Ticket ticket in tickets) {
      for (int i = 0; i < ticket.values.length; i++) {
        int value = ticket.values[i];
        List<String> possibles = getPossibleClasses(value);

        if (fields[i].isEmpty) {
          fields[i] = List.from(possibles);
        } else if (fields[i].length != 1) {
          fields[i].removeWhere((element) => !possibles.contains(element));
          if (fields[i].length == 1) {
            founded[fields[i].single] = i;
          }
        }
      }
    }

    int sum = 0;
    for (MapEntry<String, int> entry in founded.entries) {
      if (entry.key.contains("departure")) {
        if (sum == 0) {
          sum = personalTicket[entry.value];
        } else {
          sum *= personalTicket[entry.value];
        }
      }
    }

    return sum;
  }

  List<String> getPossibleClasses(int value) {
    List<String> possibles = [];
    for (MapEntry<String, List<Range>> clas in classes.entries) {
      if (founded.containsKey(clas.key)) continue;

      for (Range range in clas.value) {
        if (range.contained(value)) {
          if (!possibles.contains(clas.key)) possibles.add(clas.key);
        }
      }
    }

    return possibles;
  }

  int countInvalid() {
    int sum = 0;

    for (Ticket ticket in tickets) {
      for (int value in ticket.values) {
        bool contained = false;
        for (MapEntry<String, List<Range>> clas in classes.entries) {
          for (Range range in clas.value) {
            if (range.contained(value)) contained = true;
          }
        }

        if (!contained) {
          ticket.valid = false;
          sum += value;
        }
      }
    }

    tickets.removeWhere((element) => !element.valid);

    return sum;
  }

  void parse(List<String> data) {
    int state = 0;

    for (String line in data) {
      if (line.isEmpty) {
        state++;
        continue;
      }

      if (line == "your ticket:" || line == "nearby tickets:") continue;

      if (state == 0) {
        parseClass(line);
      } else if (state == 1) {
        personalTicket = line.split(",").map((e) => int.parse(e)).toList();
      } else if (state == 2) {
        tickets.add(Ticket(line.split(",").map((e) => int.parse(e)).toList()));
      }
    }
  }

  void parseClass(String line) {
    var arr = line.split(":");
    String clas = arr[0];
    var arrr = arr[1].split("or");
    List<Range> ranges = [];
    for (String str in arrr) {
      ranges.add(Range.fromString(str.trim()));
    }
    classes[clas] = ranges;
  }
}

int main(List<String> args) {
  if (args.length != 1) return 1;

  List<String> data = readStringData(args[0]);

  processPuzzle(1, () => resolve1(data));
  processPuzzle(2, () => resolve2(data));

  return 0;
}

resolve1(List<String> data) {
  Solver solv = Solver();
  solv.parse(data);

  return solv.countInvalid();
}

resolve2(List<String> data) {
  Solver solv = Solver();
  solv.parse(data);
  solv.countInvalid();

  return solv.solve();
}
