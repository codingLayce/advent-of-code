import 'dart:io';
import 'package:quiver/core.dart';

// Maths
class Vector3 {
  int x;
  int y;
  int z;

  Vector3(this.x, this.y, this.z);

  static Vector3 copy(Vector3 vec) {
    return Vector3(vec.x, vec.y, vec.z);
  }

  @override
  String toString() {
    return "($x:$y:$z)";
  }

  @override
  bool operator ==(o) => o is Vector3 && o.x == x && o.y == y && o.z == z;

  void addVector(Vector3 other) {
    x += other.x;
    y += other.y;
    z += other.z;
  }

  void add({int x = 0, int y = 0, int z = 0}) {
    this.x += x;
    this.y += y;
    this.z = z;
  }

  void minusVector(Vector3 other) {
    x -= other.x;
    y -= other.y;
    z -= other.z;
  }

  void minus({int x = 0, int y = 0, int z = 0}) {
    this.x -= x;
    this.y -= y;
    this.z -= z;
  }

  void multiply(int scalar) {
    x *= scalar;
    y *= scalar;
    z *= scalar;
  }

  @override
  int get hashCode => hash3(x.hashCode, y.hashCode, z.hashCode);
}

class Vector {
  int x;
  int y;

  Vector(this.x, this.y);

  @override
  String toString() => "$x:$y";

  static Vector copy(Vector vec) {
    return Vector(vec.x, vec.y);
  }

  @override
  bool operator ==(o) => o is Vector && o.x == x && o.y == y;

  @override
  int get hashCode => hash2(x.hashCode, y.hashCode);

  bool equal(Vector other) {
    return (other.x == x && other.y == y);
  }

  void addVector(Vector other) {
    x += other.x;
    y += other.y;
  }

  void add({int x = 0, int y = 0}) {
    this.x += x;
    this.y += y;
  }

  void minusVector(Vector other) {
    x -= other.x;
    y -= other.y;
  }

  void minus({int x = 0, int y = 0}) {
    this.x -= x;
    this.y -= y;
  }

  void multiply(int scalar) {
    x *= scalar;
    y *= scalar;
  }

  Vector direction(Vector other) {
    int dirX;
    int dirY;

    if (x < other.x) {
      dirX = 1;
    } else if (x > other.x) {
      dirX = -1;
    } else {
      dirX = 0;
    }

    if (y < other.y) {
      dirY = 1;
    } else if (y > other.y) {
      dirY = -1;
    } else {
      dirY = 0;
    }

    return Vector(dirX, dirY);
  }

  // Can only rotate by 90° multiples
  void rotate(int degree) {
    switch (degree) {
      case 90:
        int newX = y;
        int newY = -x;
        x = newX;
        y = newY;
        break;
      case 180:
        x = -x;
        y = -y;
        break;
      case 270:
        int newX = -y;
        int newY = x;
        x = newX;
        y = newY;
    }
  }
}

List<int> stringListToIntList(List<String> list) {
  return list.map((e) => int.parse(e)).toList();
}

int sumList(List<int> numbers) {
  return numbers.reduce((value, element) => value + element);
}

int largestElement(List<int> list) {
  return list.reduce((value, element) => element > value ? element : value);
}

int smallestElement(List<int> list) {
  return list.reduce((value, element) => element < value ? element : value);
}

int mostOccuredElement(List<int> list) {
  Map<int, int> map = {};
  int max = 1;
  int res = -1;

  for (int i in list) {
    if (map.containsKey(i)) {
      map[i] = map[i]! + 1;
      if (map[i]! > max) {
        max = map[i]!;
        res = i;
      }
    } else {
      map[i] = 1;
    }
  }

  return res;
}

int index2DIn1D(int x, int y, int width) {
  return width * y + x;
}

// Lifecycle
void processPuzzle(index, Future<int> Function() resolver) async {
  Stopwatch s = Stopwatch()..start();
  resolver().then((value) {
    print("Puzzle ($index) $value in ${s.elapsed.inMilliseconds} ms");
  }).catchError((error) {
    print("Puzzle ($index) Error: $error");
  }).whenComplete(() => s.stop());
}

// Reading
List<int> readIntData(String path) {
  File file = File(path);
  List<String> lines = file.readAsLinesSync();

  return stringListToIntList(lines);
}

List<String> readStringData(String path) {
  File file = File(path);
  return file.readAsLinesSync();
}
