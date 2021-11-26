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

// My first idea was to brute force, but use a little bit my brain and calculate a bigger step that only the first bus.
// But it's absolutly unefficient ! I know I have to use CRT to solve it, but...
resolve2(List<String> data) {
  List<int> buses = busesAsNum(data[1].split(","));
  int timestamp = buses[0];
  int max = largestElement(buses);
  int step = max - buses.indexOf(max);

  // Base the step on the max bus ID multiples - offset
  while (!satistied(buses, timestamp)) {
    timestamp += step;
  }

  return timestamp;
}

bool satistied(List<int> values, int timestamp) {
  int cur = timestamp;
  for (int value in values) {
    if ((value != -1) && ((cur % value) != 0)) return false;
    cur++;
  }

  return true;
}

List<int> busesAsNum(List<String> buses) {
  List<int> busesNum = [];

  for (String bus in buses) {
    if (bus == "x") {
      busesNum.add(-1);
    } else {
      busesNum.add(int.parse(bus));
    }
  }
  return busesNum;
}
