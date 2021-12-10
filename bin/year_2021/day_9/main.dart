import '../../util.dart';

final directions = [Vector(1, 0), Vector(-1, 0), Vector(0, 1), Vector(0, -1)];

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
  List<List<int>> heightmap = _parse(data);

  int sum = 0;
  for (int y = 0; y < heightmap.length; y++) {
    for (int x = 0; x < heightmap[y].length; x++) {
      if (isLowestPoint(Vector(x, y), heightmap)) sum += (heightmap[y][x] + 1);
    }
  }

  return sum;
}

Future<int> resolve2(List<String> data) async {
  List<List<int>> heightmap = _parse(data);

  return solve(heightmap);
}

int solve(List<List<int>> heightmap) {
  List<List<Vector>> basins = [];

  for (int y = 0; y < heightmap.length; y++) {
    for (int x = 0; x < heightmap[y].length; x++) {
      if (heightmap[y][x] == 9 || isInABasin(Vector(x, y), basins)) continue;
      List<Vector> basin = [];
      putInBasinRec(Vector(x, y), heightmap, basin);
      basins.add(basin);
    }
  }

  List<int> largest = [0, 0, 0];
  for (List<Vector> basin in basins) {
    int lowest = smallestElement(largest);
    if (basin.length > lowest) {
      largest[largest.indexOf(lowest)] = basin.length;
    }
  }

  return largest.reduce((value, element) => value *= element);
}

bool isInABasin(Vector vec, List<List<Vector>> basins) {
  for (List<Vector> basin in basins) {
    if (basin.contains(vec)) return true;
  }
  return false;
}

void putInBasinRec(Vector vec, List<List<int>> heightmap, List<Vector> basin) {
  List<Vector> adjs = getAdjs(vec, heightmap);

  for (Vector adj in adjs) {
    if (heightmap[adj.y][adj.x] == 9 || basin.contains(adj)) continue;
    basin.add(adj);
    putInBasinRec(adj, heightmap, basin);
  }
}

bool isLowestPoint(Vector pos, List<List<int>> heightmap) {
  for (Vector adj in getAdjs(pos, heightmap)) {
    if (heightmap[adj.y][adj.x] <= heightmap[pos.y][pos.x]) return false;
  }
  return true;
}

List<Vector> getAdjs(Vector pos, List<List<int>> heightmap) {
  List<Vector> adjs = [];
  for (Vector dir in directions) {
    Vector adj = Vector.copy(pos)..addVector(dir);
    if (adj.y < 0 ||
        adj.y >= heightmap.length ||
        adj.x < 0 ||
        adj.x >= heightmap[adj.y].length) continue;
    adjs.add(adj);
  }
  return adjs;
}

List<List<int>> _parse(List<String> data) {
  return data
      .map((e) => e.split('').map((e) => int.parse(e)).toList())
      .toList();
}
