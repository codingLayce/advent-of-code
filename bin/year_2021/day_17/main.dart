import '../../util.dart';

const MAX_X = 1000;
const MAX_Y = 1000;
const MIN_X = -1000;
const MIN_Y = -1000;

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
  List<int> target = parse(data[0]);

  return findSolution(target);
}

Future<int> resolve2(List<String> data) async {
  List<int> target = parse(data[0]);

  return countSolution(target);
}

int countSolution(List<int> target) {
  List<Vector> velocities = [];

  for (int y = MAX_Y; y > MIN_Y; y--) {
    for (int x = MAX_X; x > MIN_X; x--) {
      Vector velocity = Vector(x, y);
      if (makeSteps(velocity, target)[0]) {
        velocities.add(velocity);
      }
    }
  }

  return velocities.length;
}

int findSolution(List<int> target) {
  int max = -9999999;
  for (int y = MAX_Y; y > 0; y--) {
    for (int x = MAX_X; x > 0; x--) {
      var res = makeSteps(Vector(x, y), target);
      if (res[0] && res[1] > max) {
        max = res[1];
      }
    }
  }

  return max;
}

List<dynamic> makeSteps(Vector velocity, List<int> target) {
  Vector pos = Vector(0, 0);
  int maxY = -9999999;

  int targetPosition = getPos(pos, target);
  while (targetPosition < 0) {
    pos.addVector(velocity);
    if (pos.y > maxY) {
      maxY = pos.y;
    }
    velocity = nextVelocity(velocity);
    targetPosition = getPos(pos, target);
  }

  return [targetPosition == 0, targetPosition == 0 ? maxY : -9999999];
}

Vector nextVelocity(Vector prev) {
  Vector next = Vector.copy(prev);
  if (next.x > 0) {
    next.minus(x: 1);
  } else if (next.x < 0) {
    next.add(x: 1);
  }
  next.minus(y: 1);
  return next;
}

//Return -1 if before, 0 inside, 1 after.
int getPos(Vector pos, List<int> target) {
  if (pos.x >= target[0] &&
      pos.x <= target[1] &&
      pos.y >= target[2] &&
      pos.y <= target[3]) return 0;
  if (pos.x > target[1]) return 1;
  if (target[2] < 0) {
    return pos.y < target[2] ? 1 : -1;
  } else {
    return pos.y > target[2] ? 1 : -1;
  }
}

List<int> parse(String data) {
  int start = data.indexOf("=");
  int end = data.indexOf(",");
  String xRange = data.substring(start + 1, end);
  var arr = xRange.split("..");

  int start2 = data.indexOf("=", end);
  String xRange2 = data.substring(start2 + 1);
  var arr2 = xRange2.split("..");

  int x1 = int.parse(arr[0]);
  int x2 = int.parse(arr[1]);

  int y1 = int.parse(arr2[0]);
  int y2 = int.parse(arr2[1]);

  return [x1, x2, y1, y2];
}
