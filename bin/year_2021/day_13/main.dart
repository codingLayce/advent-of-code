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
  List<Vector> dots = parse(data);

  String fold = data[firstFold(data)];
  if (fold.contains("x")) {
    return foldX(dots, int.parse(fold.substring(fold.indexOf("x") + 2))).length;
  }
  return foldY(dots, int.parse(fold.substring(fold.indexOf("y") + 2))).length;
}

Future<int> resolve2(List<String> data) async {
  List<Vector> dots = parse(data);

  int index = firstFold(data);
  for (int i = index; i < data.length; i++) {
    String fold = data[i];
    if (fold.contains("x")) {
      dots = foldX(dots, int.parse(fold.substring(fold.indexOf("x") + 2)));
    } else {
      dots = foldY(dots, int.parse(fold.substring(fold.indexOf("y") + 2)));
    }
  }

  int maxX = largestElement(dots.map((e) => e.x).toList());
  int maxY = largestElement(dots.map((e) => e.y).toList());

  List<List<String>> map = List.generate(
      maxY + 1, (index) => List.generate(maxX + 1, (index) => "."));

  for (Vector v in dots) {
    map[v.y][v.x] = "#";
  }

  for (int y = 0; y <= maxY; y++) {
    String line = "";
    for (int x = 0; x <= maxX; x++) {
      line = "$line${map[y][x]}";
    }
    print(line);
  }

  return 0;
}

List<Vector> foldX(List<Vector> dots, int value) {
  List<Vector> merged = List.from(dots)..removeWhere((dot) => dot.x >= value);
  List<Vector> bottom = List.from(dots)..removeWhere((dot) => dot.x < value);

  for (Vector dot in bottom) {
    int x = (value - (value - dot.x).abs());
    merged.add(Vector(x, dot.y));
  }

  return merged.toSet().toList();
}

List<Vector> foldY(List<Vector> dots, int value) {
  List<Vector> merged = List.from(dots)..removeWhere((dot) => dot.y >= value);
  List<Vector> bottom = List.from(dots)..removeWhere((dot) => dot.y < value);

  for (Vector dot in bottom) {
    int y = (value - (value - dot.y).abs());
    merged.add(Vector(dot.x, y));
  }

  return merged.toSet().toList();
}

List<Vector> parse(List<String> data) {
  List<Vector> dots = [];

  for (String line in data) {
    if (line.isEmpty) return dots;
    var arr = line.split(",");
    dots.add(Vector(int.parse(arr[0]), int.parse(arr[1])));
  }

  return dots;
}

int firstFold(List<String> data) {
  int index = 0;
  for (String line in data) {
    if (line.contains("fold along")) return index;
    index++;
  }
  return -1;
}
