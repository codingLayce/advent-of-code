import '../../errors.dart';
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
  List<int> values = stringListToIntList(data[0].split(","));
  List<Board> boards = [];

  for (int i = 2; i < data.length - 5; i += 6) {
    Board b = Board.fromString(data.sublist(i, i + 5));
    boards.add(b);
  }

  for (int value in values) {
    markBoards(boards, value);
    List<Board> winners = getWinners(boards);
    if (winners.isNotEmpty) {
      return winners.first.puzzleValue * value;
    }
  }

  return 0;
}

Future<int> resolve2(List<String> data) async {
  List<int> values = stringListToIntList(data[0].split(","));
  List<Board> boards = [];
  int toReturn = -1;

  for (int i = 2; i < data.length - 5; i += 6) {
    Board b = Board.fromString(data.sublist(i, i + 5));
    boards.add(b);
  }

  for (int value in values) {
    markBoards(boards, value);
    List<Board> winners = getWinners(boards);
    if (winners.isNotEmpty && winners.length > 1) {
    } else if (winners.isNotEmpty && winners.length == 1) {
      toReturn = winners.single.puzzleValue * value;
    }
    boards.removeWhere((element) => winners.contains(element));
  }

  return toReturn;
}

List<Board> getWinners(List<Board> boards) {
  List<Board> winners = [];
  for (Board b in boards) {
    if (b.win()) winners.add(b);
  }
  return winners;
}

void markBoards(List<Board> boards, int value) {
  for (Board b in boards) {
    b.mark(value);
  }
}

class Number {
  final int value;
  bool marked = false;

  Number(this.value);
}

class Board {
  final List<Number> numbers;

  Board(this.numbers);

  factory Board.fromString(List<String> data) {
    List<Number> numbers = List.filled(25, Number(-1));
    int x = 0;
    int y = 0;

    for (String line in data) {
      var arr = line.split(" ");
      arr.removeWhere((e) => e == "");
      x = 0;
      for (String n in arr) {
        numbers[index2DIn1D(x, y, 5)] = Number(int.parse(n));
        x++;
      }
      y++;
    }

    return Board(numbers);
  }

  int get puzzleValue {
    int sum = 0;
    for (Number n in numbers) {
      sum += !n.marked ? n.value : 0;
    }
    return sum;
  }

  void mark(int value) {
    for (Number n in numbers) {
      if (n.value == value) n.marked = true;
    }
  }

  bool win() {
    for (int i = 0; i < 5; i++) {
      if (checkColumn(i)) return true;
      if (checkRow(i)) return true;
    }

    return false;
  }

  bool checkColumn(int col) {
    for (int i = 0; i < 5; i++) {
      if (!numbers[index2DIn1D(col, i, 5)].marked) return false;
    }
    return true;
  }

  bool checkRow(int row) {
    for (int i = 0; i < 5; i++) {
      if (!numbers[index2DIn1D(i, row, 5)].marked) return false;
    }
    return true;
  }
}
