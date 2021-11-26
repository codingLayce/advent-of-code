import '../../util.dart';

int main(List<String> args) {
  if (args.length != 1) return 1;

  List<String> data = readStringData(args[0]);
  List<Cube> cubes = parse(data);

  processPuzzle(1, () => resolve1(cubes));
  processPuzzle(2, () => resolve2(cubes));

  return 0;
}

resolve2(List<Cube> cubes) {
  return 0;
}

resolve1(List<Cube> cubes) {
  return 0;
}

class Cube {
  Vector3 pos;
  bool state;

  Cube(this.pos, this.state);
}

Cube getCube(List<Cube> cubes, Vector3 pos) {
  return cubes.firstWhere((cube) => cube.pos.equal(pos));
}

List<Cube> parse(List<String> data) {
  List<Cube> cubes = [];

  int y = 0;
  for (String line in data) {
    int x = 0;
    for (int i = 0; i < data.length; i++) {
      cubes.add(Cube(Vector3(x, y, 0), line[i] == "#"));
      x++;
    }
    y++;
  }

  return cubes;
}
