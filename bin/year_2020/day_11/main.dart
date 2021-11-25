import '../../util.dart';

int main(List<String> args) {
  if (args.length != 1) return 1;

  List<String> data = readStringData(args[0]);

  processPuzzle(1, () => resolve1(data));
  processPuzzle(2, () => resolve2(data));

  return 0;
}

resolve2(List<String> data) {
  final int height = data.length;
  final int width = data[0].length;
  List<String> plane = getPlane(data);
  List<String> previousPlane = [];

  while (!areEquals(previousPlane, plane)) {
    previousPlane = List.from(plane);

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        String seat = plane[index2DIn1D(x, y, width)];
        if (seat == "L") {
          if (nbOccupiedSee(previousPlane, x, y, width, height) == 0) {
            plane[index2DIn1D(x, y, width)] = "#";
          }
        } else if (seat == "#") {
          if (nbOccupiedSee(previousPlane, x, y, width, height) >= 5) {
            plane[index2DIn1D(x, y, width)] = "L";
          }
        }
      }
    }
  }

  return nbOccupied(plane);
}

resolve1(List<String> data) {
  final int height = data.length;
  final int width = data[0].length;
  List<String> plane = getPlane(data);
  List<String> previousPlane = [];

  while (!areEquals(previousPlane, plane)) {
    previousPlane = List.from(plane);

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        String seat = plane[index2DIn1D(x, y, width)];
        if (seat == "L") {
          if (nbOccupiedAdj(previousPlane, x, y, width, height) == 0) {
            plane[index2DIn1D(x, y, width)] = "#";
          }
        } else if (seat == "#") {
          if (nbOccupiedAdj(previousPlane, x, y, width, height) >= 4) {
            plane[index2DIn1D(x, y, width)] = "L";
          }
        }
      }
    }
  }

  return nbOccupied(plane);
}

List<String> getPlane(List<String> data) {
  List<String> plane = List.filled(data.length * data[0].length, ".");

  for (int y = 0; y < data.length; y++) {
    String line = data[y];
    for (int x = 0; x < line.length; x++) {
      plane[index2DIn1D(x, y, line.length)] = line[x];
    }
  }

  return plane;
}

bool areEquals(List<String> previous, List<String> current) {
  if (previous.length != current.length) return false;
  for (int i = 0; i < previous.length; i++) {
    if (previous[i] != current[i]) return false;
  }
  return true;
}

int nbOccupiedAdj(List<String> plane, int x, int y, int width, int height) {
  int count = 0;
  if (occupied(plane, x - 1, y, width, height)) count++;
  if (occupied(plane, x - 1, y - 1, width, height)) count++;
  if (occupied(plane, x, y - 1, width, height)) count++;
  if (occupied(plane, x + 1, y - 1, width, height)) count++;
  if (occupied(plane, x + 1, y, width, height)) count++;
  if (occupied(plane, x + 1, y + 1, width, height)) count++;
  if (occupied(plane, x, y + 1, width, height)) count++;
  if (occupied(plane, x - 1, y + 1, width, height)) count++;
  return count;
}

bool occupiedSee(List<String> plane, int x, int y, int width, int height,
    int xMove, int yMove) {
  int curX = x;
  int curY = y;

  do {
    curX += xMove;
    curY += yMove;
  } while (boundCheck(curX, curY, width, height) &&
      plane[index2DIn1D(curX, curY, width)] == ".");

  if (boundCheck(curX, curY, width, height)) {
    return plane[index2DIn1D(curX, curY, width)] == "#";
  }
  return false;
}

int nbOccupiedSee(List<String> plane, int x, int y, int width, int height) {
  int count = 0;

  count += occupiedSee(plane, x, y, width, height, -1, 0) ? 1 : 0;
  count += occupiedSee(plane, x, y, width, height, -1, -1) ? 1 : 0;
  count += occupiedSee(plane, x, y, width, height, 0, -1) ? 1 : 0;
  count += occupiedSee(plane, x, y, width, height, 1, -1) ? 1 : 0;
  count += occupiedSee(plane, x, y, width, height, 1, 0) ? 1 : 0;
  count += occupiedSee(plane, x, y, width, height, 1, 1) ? 1 : 0;
  count += occupiedSee(plane, x, y, width, height, 0, 1) ? 1 : 0;
  count += occupiedSee(plane, x, y, width, height, -1, 1) ? 1 : 0;

  return count;
}

bool boundCheck(int x, int y, int width, int height) {
  return (x >= 0 && x < width && y >= 0 && y < height);
}

bool occupied(List<String> plane, int x, int y, int width, int height) {
  if (x >= 0 && x < width && y >= 0 && y < height) {
    return plane[index2DIn1D(x, y, width)] == "#";
  }
  return false;
}

int nbOccupied(List<String> plane) {
  int count = 0;

  for (String seat in plane) {
    count += seat == "#" ? 1 : 0;
  }

  return count;
}

void printPlane(List<String> plane, int width, int height) {
  for (int y = 0; y < height; y++) {
    String str = "";
    for (int x = 0; x < width; x++) {
      str += plane[index2DIn1D(x, y, width)];
    }
    print(str);
  }
  print("");
}
