import '../../util.dart';

class Passport {
  int? byr;
  int? iyr;
  int? eyr;
  String hgt = "null";
  String hcl = "null";
  String ecl = "null";
  String pid = "null";
  int? cid;

  @override
  String toString() => pid;

  bool get isValidV1 =>
      (byr != null) &&
      (iyr != null) &&
      (eyr != null) &&
      (hgt != "null") &&
      (hcl != "null") &&
      (ecl != "null") &&
      (pid != "null");

  bool get isValidV2 => (isByrValid &&
      isIyrValid &&
      isEyrValid &&
      isHgtValid &&
      isHclValid &&
      isEclValid &&
      isPidValid);

  bool get isPidValid {
    if (pid.length != 9) return false;
    var digits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
    for (int i = 0; i < pid.length; i++) {
      if (!digits.contains(pid[i])) {
        return false;
      }
    }
    return true;
  }

  bool get isEclValid {
    return (ecl == "amb" ||
        ecl == "blu" ||
        ecl == "brn" ||
        ecl == "gry" ||
        ecl == "grn" ||
        ecl == "hzl" ||
        ecl == "oth");
  }

  bool get isHclValid {
    if (hcl[0] != "#") return false;
    return hcl.length == 7;
  }

  bool get isHgtValid {
    if (hgt == "null") return false;

    var unit = hgt.substring(hgt.length - 2);
    var value = int.tryParse(hgt.substring(0, hgt.length - 2));
    if (value == null) return false;

    if (unit == "cm") return (value >= 150 && value <= 193);
    return (value >= 59 && value <= 76);
  }

  bool get isEyrValid {
    if (eyr == null) return false;
    return (eyr! >= 2020 && eyr! <= 2030);
  }

  bool get isByrValid {
    if (byr == null) return false;
    return (byr! >= 1920 && byr! <= 2002);
  }

  bool get isIyrValid {
    if (iyr == null) return false;
    return (iyr! >= 2010 && iyr! <= 2020);
  }

  void set(String key, String value) {
    switch (key) {
      case "byr":
        byr = int.parse(value);
        break;
      case "iyr":
        iyr = int.parse(value);
        break;
      case "eyr":
        eyr = int.parse(value);
        break;
      case "hgt":
        hgt = value;
        break;
      case "hcl":
        hcl = value;
        break;
      case "ecl":
        ecl = value;
        break;
      case "pid":
        pid = value;
        break;
      case "cid":
        cid = int.parse(value);
        break;
    }
  }
}

int main(List<String> args) {
  if (args.length != 1) return 1;

  List<String> data = readStringData(args[0]);
  List<Passport> passports = getPassports(data);

  processPuzzle(1, () => resolve1(passports));
  processPuzzle(2, () => resolve2(passports));

  return 0;
}

resolve2(List<Passport> data) {
  int counter = 0;

  for (Passport pass in data) {
    counter += pass.isValidV2 ? 1 : 0;
  }

  return counter;
}

resolve1(List<Passport> data) {
  int counter = 0;

  for (Passport pass in data) {
    counter += pass.isValidV1 ? 1 : 0;
  }

  return counter;
}

getPassports(List<String> data) {
  List<Passport> passports = [];
  Passport pass = Passport();

  for (String line in data) {
    if (line.isEmpty) {
      passports.add(pass);
      pass = Passport();
      continue;
    }

    var pairs = line.split(" ");
    for (String pair in pairs) {
      var keyValue = pair.split(":");
      pass.set(keyValue[0], keyValue[1]);
    }
  }

// Add the last passport
  passports.add(pass);

  return passports;
}
