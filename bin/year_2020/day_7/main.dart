import '../../util.dart';

class Bag {
  String color;
  Map<String, int> contains;

  @override
  String toString() => "$color -> $contains";

  Bag(this.color, this.contains);

  factory Bag.fromString(String str) {
    var arr = str.split(" ");
    String col = "${arr[0]} ${arr[1]}";

    arr = str.split(",");
    Map<String, int> bags = {};

    for (String inside in arr) {
      var splittedInside = inside.split(" ");
      String nb = splittedInside[splittedInside.length - 4];
      int? parsed = int.tryParse(nb);
      if (parsed == null) {
        break;
      }
      String insideCol =
          "${splittedInside[splittedInside.length - 3]} ${splittedInside[splittedInside.length - 2]}";
      bags[insideCol] = int.parse(nb);
    }

    return Bag(col, bags);
  }

  bool canContainsShinyGold(List<Bag> bags) {
    if (contains.containsKey("shiny gold")) return true;
    for (MapEntry entry in contains.entries) {
      if (getBag(bags, entry.key).canContainsShinyGold(bags)) return true;
    }
    return false;
  }

  int nbBagsInside(List<Bag> bags) {
    int nb = 0;
    for (MapEntry<String, int> entry in contains.entries) {
      nb += entry.value * (getBag(bags, entry.key).nbBagsInside(bags) + 1);
    }
    return nb;
  }
}

int main(List<String> args) {
  if (args.length != 1) return 1;

  List<String> data = readStringData(args[0]);
  List<Bag> bags = getBags(data);

  processPuzzle(1, () => resolve1(bags));
  processPuzzle(2, () => resolve2(bags));

  return 0;
}

resolve2(List<Bag> bags) {
  return getBag(bags, "shiny gold").nbBagsInside(bags);
}

resolve1(List<Bag> bags) {
  int sum = 0;

  for (Bag bag in bags) {
    if (bag.canContainsShinyGold(bags)) sum++;
  }

  return sum;
}

getBags(List<String> data) {
  List<Bag> bags = [];

  for (String bag in data) {
    bags.add(Bag.fromString(bag));
  }

  return bags;
}

Bag getBag(List<Bag> bags, String color) {
  return bags[bags.indexWhere((element) => element.color == color)];
}
