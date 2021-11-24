import '../../util.dart';

class Instruction {
  String op;
  int value;
  bool visited = false;

  Instruction(this.op, this.value);

  factory Instruction.fromString(String line) {
    var arr = line.split(" ");
    int value = int.parse(arr[1]);
    return Instruction(arr[0], value);
  }

  @override
  String toString() => "$op $value";

  void setVisited(bool v) => visited = v;

  void toggleJmpNop() {
    if (op == "jmp") {
      op = "nop";
    } else if (op == "nop") {
      op = "jmp";
    }
  }
}

class Program {
  int accumulator = 0;
  List<Instruction> instructions;

  int _cursor = 0;

  Program(this.instructions);

  factory Program.parse(List<String> data) {
    List<Instruction> instructions = [];

    for (String instruction in data) {
      instructions.add(Instruction.fromString(instruction));
    }

    return Program(instructions);
  }

  void reset() {
    _cursor = 0;
    accumulator = 0;
    for (Instruction ins in instructions) {
      ins.setVisited(false);
    }
  }

  int runInstruction(Instruction ins) {
    if (ins.op == "acc") {
      accumulator += ins.value;
    } else if (ins.op == "jmp") {
      return ins.value;
    }

    return 1;
  }

  bool run() {
    // If on last instruction
    if (_cursor == instructions.length) return true;
    if (_cursor > instructions.length) return false;

    Instruction ins = instructions[_cursor];
    if (ins.visited) {
      return false;
    }

    _cursor += runInstruction(ins);

    ins.setVisited(true);

    return run();
  }

  void toggleJmpNop(int index) {
    instructions[index].toggleJmpNop();
  }
}

int main(List<String> args) {
  if (args.length != 1) return 1;

  List<String> data = readStringData(args[0]);
  Program prog = Program.parse(data);

  processPuzzle(1, () => resolve1(prog));
  processPuzzle(2, () => resolve2(prog));

  return 0;
}

resolve2(Program prog) {
  for (int i = 0; i < prog.instructions.length; i++) {
    prog.toggleJmpNop(i);
    if (prog.run()) {
      return prog.accumulator;
    }
    prog.toggleJmpNop(i);
    prog.reset();
  }

  return -1;
}

resolve1(Program prog) {
  prog.run();
  return prog.accumulator;
}
