# What is this repository ?

This repository contains my solutions for the advent of code [event](https://adventofcode.com/) ! 

This event takes place every year during december where every day two puzzles are revealed and you have to solve them.

I'am making my solutions in dart.

# How to use it ?

```
dart run bin/advent_of_code.dart -y <year> -d <day>
```

# How to run tests ?

### Single test

```
dart test test/year_xxxx/day_xx/test.dart
```

### All tests

```
for year in $(ls -d test/*/); do 
  for day in $(ls -d ${year}*/); do 
    dart test ${day}test.dart
  done
done
```