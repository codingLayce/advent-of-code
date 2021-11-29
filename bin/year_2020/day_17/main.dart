import '../../util.dart';

int main(List<String> args) {
  if (args.length != 1) return 1;

  List<String> data = readStringData(args[0]);

  processPuzzle(1, () => resolve1(data));
  processPuzzle(2, () => resolve2(data));

  return 0;
}

resolve2(List<String> data) {
  return 0;
}

resolve1(List<String> data) {
  List<Vector3> activeCubes = parse(data);

  for (int i = 0; i < 6; i++) {
    activeCubes = step(activeCubes);
  }

  return activeCubes.length;
}

List<Vector3> step(List<Vector3> activeCubes) {
  List<Vector3> next = [];

  int minX = getBound(activeCubes, (e) => e.x, smallestElement) - 1;
  int maxX = getBound(activeCubes, (e) => e.x, largestElement) + 2;
  int minY = getBound(activeCubes, (e) => e.y, smallestElement) - 1;
  int maxY = getBound(activeCubes, (e) => e.y, largestElement) + 2;
  int minZ = getBound(activeCubes, (e) => e.z, smallestElement) - 1;
  int maxZ = getBound(activeCubes, (e) => e.z, largestElement) + 2;

  print("$minX:$maxX $minY:$maxY $minZ:$maxZ");

  for (int x = minX; x < maxX; x++) {
    for (int y = minY; y < maxY; y++) {
      for (int z = minZ; z < maxZ; z++) {
        Vector3 vec = Vector3(x, y, z);
        int activeNeighbors = countNeighborsActive(vec, activeCubes);
        if (activeCubes.contains(vec) &&
            (activeNeighbors == 2 || activeNeighbors == 3)) {
          next.add(vec);
        } else if (!activeCubes.contains(vec) && activeNeighbors == 3) {
          next.add(vec);
        }
      }
    }
  }

  return next;
}

int getBound(List<Vector3> cubes, int Function(Vector3) mapper,
    int Function(List<int>) extracter) {
  List<int> axis = cubes.map<int>(mapper).toList();
  return extracter(axis);
}

int countNeighborsActive(Vector3 vec, List<Vector3> cubes) {
  int count = 0;

  for (int dx = -1; dx < 2; dx++) {
    for (int dy = -1; dy < 2; dy++) {
      for (int dz = -1; dz < 2; dz++) {
        if (dx == 0 && dy == 0 && dz == 0) continue;
        if (cubes.contains(Vector3.copy(vec)..add(x: dx, y: dy, z: dz))) {
          count++;
        }
      }
    }
  }

  return count;
}

List<Vector3> parse(List<String> data) {
  List<Vector3> cubes = [];

  int y = 0;
  for (String line in data) {
    int x = 0;
    for (int i = 0; i < data.length; i++) {
      if (line[i] == "#") cubes.add(Vector3(x, y, 0));
      x++;
    }
    y++;
  }

  return cubes;
}
