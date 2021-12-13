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
  Node root = parse(data);

  Solver solver = Solver();
  solver.distinctPaths(root, "");

  return solver.count;
}

Future<int> resolve2(List<String> data) async {
  Node root = parse(data);

  Solver2 solver = Solver2();
  solver.distinctPaths(root, Path());

  return solver.count;
}

Node parse(List<String> data) {
  List<Node> nodes = [];

  for (String line in data) {
    var arr = line.split("-");

    Node? a = getNode(nodes, arr[0]);
    Node? b = getNode(nodes, arr[1]);

    a ??= Node(arr[0]);
    b ??= Node(arr[1]);

    a.connect(b);
    b.connect(a);

    nodes.add(a);
    nodes.add(b);
  }

  return nodes.firstWhere((element) => element.name == "start");
}

Node? getNode(List<Node> nodes, String name) {
  try {
    return nodes.firstWhere((element) => element.name == name);
  } catch (e) {
    return null;
  }
}

class Node {
  final String name;
  final List<Node> connections = [];

  bool get isBigCave => name.toUpperCase() == name;

  Node(this.name);

  void connect(Node other) {
    connections.add(other);
  }
}

class Path {
  String path = "";
  bool hasDouble = false;

  Path copy() {
    Path p = Path();

    p.path = path;
    p.hasDouble = hasDouble;

    return p;
  }

  bool canAdd(Node node) {
    if (node.name == "start" ||
        (!node.isBigCave && hasDouble && path.contains(node.name))) {
      return false;
    }
    return true;
  }

  void add(Node node) {
    if (!node.isBigCave && !hasDouble && path.contains(node.name)) {
      hasDouble = true;
    }
    path = "$path${node.name},";
  }
}

class Solver2 {
  int count = 0;

  void distinctPaths(Node node, Path path) {
    if (node.name == "end") {
      count++;
      return;
    }

    path.add(node);

    for (Node child in node.connections) {
      if (path.canAdd(child)) distinctPaths(child, path.copy());
    }
  }
}

class Solver {
  int count = 0;

  void distinctPaths(Node node, String path) {
    if (node.name == "end") count++;

    path = "$path,${node.name}";
    for (Node child in node.connections) {
      if (!child.isBigCave && path.contains(child.name)) continue;
      distinctPaths(child, path);
    }
  }
}
