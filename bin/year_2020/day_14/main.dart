import '../../util.dart';
import '../day_9/main.dart';

int main(List<String> args) {
  if (args.length != 1) return 1;

  List<String> data = readStringData(args[0]);

  processPuzzle(1, () => resolve1(data));
  processPuzzle(2, () => resolve2(data));

  return 0;
}

resolve1(List<String> data) {
  String mask = data[0].split(" ")[2];
  Map<String, int> memory = {};

  for (String line in data) {
    var arr = line.split(" ");
    if (arr[0] == "mask") {
      mask = arr[2];
    } else {
      String memAddr =
          arr[0].substring(arr[0].indexOf("[") + 1, arr[0].indexOf("]"));
      int value = int.parse(arr[2]);
      memory[memAddr] = maskedValue(mask, value);
    }
  }

  return sumList(memory.values.toList());
}

int maskedValue(String mask, int value) {
  var str = value.toRadixString(2);

  while (str.length != 36) {
    str = "0$str";
  }

  for (int i = 0; i < mask.length; i++) {
    if (mask[i] != "X") {
      str = replaceAtIndex(str, mask[i], i);
    }
  }

  return int.parse(str, radix: 2);
}

String replaceAtIndex(String str, String char, int index) {
  return str.substring(0, index) + char + str.substring(index + 1);
}

resolve2(List<String> data) {
  String mask = data[0].split(" ")[2];
  Map<String, int> memory = {};

  for (String line in data) {
    var arr = line.split(" ");
    if (arr[0] == "mask") {
      mask = arr[2];
    } else {
      String memAddr =
          arr[0].substring(arr[0].indexOf("[") + 1, arr[0].indexOf("]"));
      int value = int.parse(arr[2]);
      for (String addr in maskedAddr(mask, int.parse(memAddr))) {
        memory[addr] = value;
      }
    }
  }

  return sumList(memory.values.toList());
}

List<String> maskedAddr(String mask, int memAddr) {
  List<String> addresses = [];
  String mem = memAddr.toRadixString(2);

  while (mem.length != 36) {
    mem = "0$mem";
  }

  for (int i = 0; i < mask.length; i++) {
    if (mask[i] != "0") {
      mem = replaceAtIndex(mem, mask[i], i);
    }
  }

  populate(addresses, mem, 0);

  return addresses;
}

void populate(List<String> list, String addr, int index) {
  if (!addr.contains("X")) {
    if (!list.contains(addr)) {
      list.add(addr);
    }
    return;
  }
  if (addr[index] == "X") {
    populate(list, replaceAtIndex(addr, "1", index), index + 1);
    populate(list, replaceAtIndex(addr, "0", index), index + 1);
  } else {
    populate(list, addr, index + 1);
  }
}
