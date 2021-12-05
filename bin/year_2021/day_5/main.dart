import '../../util.dart';

int main(List<String> args) {
  if (args.length != 1) {
    return 1;
  }

  List<String> data = readStringData(args[0]);

  processPuzzle(1, () => resolve1(List.from(data)));

  processPuzzle(2, () => resolve2(List.from(data)));

  return 0;
}

Future<int> resolve1(List<String> data) async {
  List<Line> lines = parse(data);
  return compute(lines, (line) => line.isHorOrVer);
}

Future<int> resolve2(List<String> data) async {
  List<Line> lines = parse(data);
  return compute(lines, (line) => true);
}

int compute(List<Line> lines, bool Function(Line) isValid) {
  Map<Vector, int> points = {};

  for (Line line in lines) {
    if (!isValid(line)) continue;

    List<Vector> traversedPoints = line.traversedPoints();
    for (Vector point in traversedPoints) {
      if (points.containsKey(point)) {
        points.update(point, (value) => value + 1);
      } else {
        points.putIfAbsent(point, () => 1);
      }
    }
  }

  // Here I sort by values to get all the values >= 2 in one single linear chunk
  List<int> values = points.values.toList();
  values.sort();
  return values.length - values.indexOf(2);
}

List<Line> parse(List<String> data) {
  List<Line> lines = [];
  for (String line in data) {
    lines.add(Line.fromString(line));
  }
  return lines;
}

class Line {
  final Vector start;
  final Vector end;

  Line(this.start, this.end);

  bool get isHorOrVer => end.x == start.x || end.y == start.y;

  List<Vector> traversedPoints() {
    List<Vector> points = [];
    Vector direction = start.direction(end);
    Vector point = Vector.copy(start);

    while (point != end) {
      points.add(Vector.copy(point));
      point = Vector.copy(point..addVector(direction));
    }

    points.add(end);

    return points;
  }

  factory Line.fromString(String str) {
    var arr = str.split(" -> ");

    var startSplit = arr[0].split(",");
    var endSplit = arr[1].split(",");

    Vector start = Vector(int.parse(startSplit[0]), int.parse(startSplit[1]));
    Vector end = Vector(int.parse(endSplit[0]), int.parse(endSplit[1]));

    return Line(start, end);
  }
}
