import '../../util.dart';

int main(List<String> args) {
  if (args.length != 1) return 1;

  List<String> data = readStringData(args[0]);

  processPuzzle(1, () => resolve1(data));
  processPuzzle(2, () => resolve2(data));

  return 0;
}

resolve2(List<String> data) {
  List<bool> seats = List.filled(128 * 8, false);
  Map<int, List<int>> map = {};

  for (String line in data) {
    int row = get(line.substring(0, 7), 127);
    int col = get(line.substring(7), 7);
    seats[col * 128 + row] = true;
    int id = getId(row, col);
    map[id] = [row, col];
  }

  for (int x = 0; x < 128; x++) {
    for (int y = 0; y < 8; y++) {
      if (!seats[y * 128 + x]) {
        int id = getId(x, y);
        if (map.containsKey(id - 1) && map.containsKey(id + 1)) {
          return id;
        }
      }
    }
  }

  return 0;
}

resolve1(List<String> data) {
  int maxID = 0;

  for (String line in data) {
    int row = get(line.substring(0, 7), 127);
    int col = get(line.substring(7), 7);
    int id = getId(row, col);
    if (id > maxID) maxID = id;
  }

  return maxID;
}

getId(x, y) {
  return x * 8 + y;
}

get(String value, int max) {
  int lo = 0;
  int hi = max;

  for (int i = 0; i < value.length - 1; i++) {
    int gap = hi - lo + 1;
    int moving = (gap / 2).floor();
    if (value[i] == "F" || value[i] == "L") {
      hi -= moving;
    } else {
      lo += moving;
    }
  }

  if (value[value.length - 1] == "F" || value[value.length - 1] == "L") {
    return lo;
  }

  return hi;
}
