import '../../util.dart';

int main(List<String> args) {
  if (args.length != 1) return 1;

  List<String> data = readStringData(args[0]);

  processPuzzle(1, () => resolve1(data));
  processPuzzle(2, () => resolve2(data));

  return 0;
}

resolve2(List<String> data) {
  int sum = 0;
  List<List<String>> groups = getGroups(data);

  for (List<String> group in groups) {
    List<String> answered = [];

    for (int i = 0; i < group[0].length; i++) {
      answered.add(group[0][i]);
    }

    for (int i = 1; i < group.length; i++) {
      var person = group[i];
      List<String> toRemove = [];
      for (int j = 0; j < answered.length; j++) {
        if (!person.contains(answered[j])) {
          toRemove.add(answered[j]);
        }
      }

      for (String answer in toRemove) {
        answered.remove(answer);
      }
    }

    sum += answered.length;
  }

  return sum;
}

resolve1(List<String> data) {
  int sum = 0;
  List<List<String>> groups = getGroups(data);

  for (List<String> group in groups) {
    List<String> answered = [];

    for (String person in group) {
      for (int i = 0; i < person.length; i++) {
        if (!answered.contains(person[i])) {
          answered.add(person[i]);
        }
      }
    }

    sum += answered.length;
  }

  return sum;
}

getGroups(List<String> data) {
  List<List<String>> groups = [];
  List<String> group = [];

  for (String line in data) {
    if (line.isEmpty) {
      groups.add(List.from(group));
      group.clear();
    } else {
      group.add(line);
    }
  }

  // Add the last group
  groups.add(List.from(group));

  return groups;
}
