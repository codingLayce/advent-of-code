import 'dart:ffi';
import 'dart:io';

import 'dart:typed_data';

// Maths
class Vector {
  int x;
  int y;

  Vector(this.x, this.y);

  static Vector copy(Vector vec) {
    return Vector(vec.x, vec.y);
  }

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

// Lifecycle
void processPuzzle(index, resolver) {
  Stopwatch s = Stopwatch()..start();

  num result = resolver();
  s.stop();
  print("Puzzle $index: $result in ${s.elapsed.inMilliseconds} ms");
  s.reset();
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

int largestElement(List<int> list) {
  return list.reduce((value, element) => element > value ? element : value);
}

int smallestElement(List<int> list) {
  return list.reduce((value, element) => element < value ? element : value);
}

int index2DIn1D(int x, int y, int width) {
  return width * y + x;
}
