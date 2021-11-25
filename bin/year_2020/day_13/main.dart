import '../../util.dart';

int main(List<String> args) {
  if (args.length != 1) return 1;

  List<String> data = readStringData(args[0]);

  processPuzzle(1, () => resolve1(data));
  processPuzzle(2, () => resolve2(data));

  return 0;
}

resolve1(List<String> data) {
  int timestamp = int.parse(data[0]);
  var list = data[1].split(",");

  int earliest = double.maxFinite.toInt();
  int earliestBus = 0;

  for (String bus in list) {
    if (bus == "x") continue;

    int num = int.parse(bus);

    int cur = timestamp;
    while (cur % num != 0) {
      cur++;
    }

    if (cur < earliest) {
      earliest = cur;
      earliestBus = num;
    }
  }

  int diff = earliest - timestamp;
  return earliestBus * diff;
}

resolve2(List<String> data) {
  return 0;
}
