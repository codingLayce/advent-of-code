import 'dart:io';

// Lifecycle
void processPuzzle(index, resolver) {
  Stopwatch s = Stopwatch()..start();

  int result = resolver();
  s.stop();
  print("Puzzle $index: $result in ${s.elapsed.inMilliseconds} ms");
  s.reset();
}

// Reading
List<int> readIntData(String path) {
  File file = File(path);
  List<String> lines = file.readAsLinesSync();

  return lines.map((e) => int.parse(e)).toList();
}

List<String> readStringData(String path) {
  File file = File(path);
  return file.readAsLinesSync();
}
