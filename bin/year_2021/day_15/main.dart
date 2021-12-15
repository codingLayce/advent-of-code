import 'package:collection/collection.dart';

import '../../util.dart';

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
  List<List<Node>> map = parse(data);
  return run(map);
}

Future<int> resolve2(List<String> data) async {
  List<List<Node>> map = parse(data);

  int height = map.length;
  int width = map[0].length;

  // Duplicate the map to 5*5 and apply the weight modification
  for (int y = 0; y < height * 5; y++) {
    int shiftY = y ~/ height;
    if (shiftY != 0) map.add([]);

    for (int x = 0; x < width * 5; x++) {
      int shiftX = x ~/ width;
      if (shiftY == 0 && shiftX == 0) continue;

      int shiftedY = y - (height * shiftY);
      int shiftedX = x - (width * shiftX);
      int value = map[shiftedY][shiftedX].weight + (shiftX + shiftY);
      value %= 9;
      if (value == 0) value = 9;
      Node node = Node(Vector(x, y), value);
      map[y].add(node);
    }
  }

  return run(map);
}

// Solve using Dijkstra algorithm
int run(List<List<Node>> map) {
  // Starting point
  map[0][0].dist = 0;
  map[0][0].visited = true;

  final queue = PriorityQueue<Node>((a, b) => a.dist.compareTo(b.dist));
  queue.add(map[0][0]);

  while (queue.isNotEmpty) {
    Node n = queue.removeFirst();

    updateAdjDist(map, queue, n);
  }

  // Backtrack the path (because the node.parent is set during the Dijkstra algorithm)
  Node? cur = map[map.length - 1][map[0].length - 1];
  int risk = 0;
  while (cur!.parent != null) {
    risk += cur.weight;
    cur = cur.parent;
  }

  return risk;
}

void updateAdjDist(List<List<Node>> map, PriorityQueue queue, Node cur) {
  for (int x = cur.pos.x - 1; x < cur.pos.x + 2; x++) {
    if (x < 0 || x >= map[0].length || x == cur.pos.x) continue;
    if (map[cur.pos.y][x].visited ||
        map[cur.pos.y][x].dist <
            map[cur.pos.y][x].weight + map[cur.pos.y][cur.pos.x].dist) {
      continue;
    }
    map[cur.pos.y][x].updateDist(map[cur.pos.y][cur.pos.x].dist);
    map[cur.pos.y][x].visited = true;
    map[cur.pos.y][x].parent = cur;
    queue.add(map[cur.pos.y][x]);
  }

  for (int y = cur.pos.y - 1; y < cur.pos.y + 2; y++) {
    if (y < 0 || y >= map[0].length || y == cur.pos.y) continue;
    if (map[y][cur.pos.x].visited ||
        map[y][cur.pos.x].dist <
            map[y][cur.pos.x].weight + map[cur.pos.y][cur.pos.x].dist) {
      continue;
    }
    map[y][cur.pos.x].updateDist(map[cur.pos.y][cur.pos.x].dist);
    map[y][cur.pos.x].visited = true;
    map[y][cur.pos.x].parent = cur;
    queue.add(map[y][cur.pos.x]);
  }
}

List<List<Node>> parse(List<String> data) {
  List<List<Node>> map = [];

  int y = 0;
  for (String line in data) {
    List<Node> lineV = [];
    for (int i = 0; i < line.length; i++) {
      lineV.add(Node(Vector(i, y), int.parse(line[i])));
    }
    map.add(lineV);
    y++;
  }

  return map;
}

class Node {
  final int weight;
  final Vector pos;
  Node? parent;
  bool visited = false;
  int dist = double.maxFinite.toInt();

  Node(this.pos, this.weight);

  void updateDist(int d) {
    dist = d + weight;
  }
}
