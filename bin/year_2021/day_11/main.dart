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
  List<List<int>> octopuses = parse(data);

  int flashes = 0;

  for (int i = 0; i < 100; i++) {
    increase(octopuses);
    int tmp;
    while ((tmp = flash(octopuses)) != 0) {
      flashes += tmp;
    }
  }

  return flashes;
}

Future<int> resolve2(List<String> data) async {
  List<List<int>> octopuses = parse(data);

  int tour = 0;

  while (!allFlashed(octopuses)) {
    increase(octopuses);
    int tmp = 0;
    while ((tmp = flash(octopuses)) != 0) {}
    tour++;
  }

  return tour;
}

bool allFlashed(List<List<int>> octopuses) {
  for (int y = 0; y < octopuses.length; y++) {
    for (int x = 0; x < octopuses[0].length; x++) {
      if (octopuses[y][x] != 0) {
        return false;
      }
    }
  }
  return true;
}

int flash(List<List<int>> octopuses) {
  int flash = 0;

  for (int y = 0; y < octopuses.length; y++) {
    for (int x = 0; x < octopuses[0].length; x++) {
      if (octopuses[y][x] > 9) {
        octopuses[y][x] = 0;
        flash++;
        increaseAdj(octopuses, x, y);
      }
    }
  }

  return flash;
}

void increaseAdj(List<List<int>> octopuses, int posX, int posY) {
  for (int y = -1; y < 2; y++) {
    for (int x = -1; x < 2; x++) {
      if (posY + y < 0 ||
          posY + y >= octopuses.length ||
          posX + x < 0 ||
          posX + x >= octopuses[0].length) {
        continue;
      }
      if (octopuses[posY + y][posX + x] != 0) octopuses[posY + y][posX + x]++;
    }
  }
}

void increase(List<List<int>> octopuses) {
  for (int y = 0; y < octopuses.length; y++) {
    for (int x = 0; x < octopuses[0].length; x++) {
      octopuses[y][x]++;
    }
  }
}

List<List<int>> parse(List<String> data) {
  List<List<int>> octopuses = [];

  for (String line in data) {
    List<int> v = [];
    for (int i = 0; i < line.length; i++) {
      v.add(int.parse(line[i]));
    }
    octopuses.add(v);
  }

  return octopuses;
}
