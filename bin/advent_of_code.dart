import 'dart:io';

import 'package:args/args.dart';

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addOption("year", abbr: 'y')
    ..addOption("day", abbr: 'd');

  ArgResults argResults = parser.parse(arguments);
  int year;
  int day;

  if (!argResults.wasParsed("year")) {
    print("--year (-y) is mandatory !");
    exit(1);
  }

  if (!argResults.wasParsed("day")) {
    print("--day (-d) is mandatory !");
    exit(1);
  }

  try {
    year = int.parse(argResults["year"]);
    day = int.parse(argResults["day"]);
  } on Exception catch (e) {
    print("Impossible de convertir year et day en entier ! $e");
    exit(1);
  }

  Process.run('dart', [
    'run',
    'bin/year_$year/day_$day/main.dart',
    'bin/year_$year/day_$day/input.txt'
  ]).then((result) {
    stdout.write(result.stdout);
    stdout.write(result.stderr);
  });
}
