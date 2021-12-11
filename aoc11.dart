import 'dart:math';

import 'package:tuple/tuple.dart';

List<List<int>> parse(String s) {
  return s.split('\n').map((l) => l.split('').map(int.parse).toList()).toList();
}

out(List<List<int>> grid) {
  return grid.map((row) => row.join()).join('\n');
}

calc1(String s, int steps) {
  var grid = parse(s);
  var flashes = 0;
  for (var i = 0; i < steps; i++) {
    // print('Step $i:\n${out(grid)}\n');
    var toVisit = <Tuple2<int, int>>[];
    // grow and flash
    for (var y = 0; y < grid.length; y++) {
      for (var x = 0; x < grid[y].length; x++) {
        if (grid[y][x] < 10) {
          grid[y][x]++;
          if (grid[y][x] > 9) {
            flashes++;
            for (var i = -1; i <= 1; i++) {
              for (var j = -1; j <= 1; j++) {
                var t = Tuple2(x + i, y + j);
                if ((i != 0 || j != 0) &&
                    t.item1 >= 0 &&
                    t.item1 < grid[y].length &&
                    t.item2 >= 0 &&
                    t.item2 < grid.length) {
                  toVisit.add(Tuple2(x + i, y + j));
                }
              }
            }
          }
        }
      }
    }
    // chain flash
    while (toVisit.isNotEmpty) {
      var t = toVisit.first;
      toVisit.removeAt(0);
      var x = t.item1;
      var y = t.item2;
      if (grid[y][x] < 10) {
        grid[y][x]++;
        if (grid[y][x] > 9) {
          flashes++;
          for (var i = -1; i <= 1; i++) {
            for (var j = -1; j <= 1; j++) {
              var t = Tuple2(x + i, y + j);
              if ((i != 0 || j != 0) &&
                  t.item1 >= 0 &&
                  t.item1 < grid[y].length &&
                  t.item2 >= 0 &&
                  t.item2 < grid.length) {
                toVisit.add(Tuple2(x + i, y + j));
              }
            }
          }
        }
      }
    }
    // reset
    for (var y = 0; y < grid.length; y++) {
      for (var x = 0; x < grid[y].length; x++) {
        if (grid[y][x] > 9) {
          grid[y][x] = 0;
        }
      }
    }
  }
  // print('Step $steps:\n${out(grid)}\n');
  return flashes;
}

calc2(String s) {
  var grid = parse(s);
  var flashes = 0;
  for (var i = 0; i < 0x7fffffff; i++) {
    // print('Step $i:\n${out(grid)}\n');
    var toVisit = <Tuple2<int, int>>[];
    // grow and flash
    for (var y = 0; y < grid.length; y++) {
      for (var x = 0; x < grid[y].length; x++) {
        if (grid[y][x] < 10) {
          grid[y][x]++;
          if (grid[y][x] > 9) {
            flashes++;
            for (var i = -1; i <= 1; i++) {
              for (var j = -1; j <= 1; j++) {
                var t = Tuple2(x + i, y + j);
                if ((i != 0 || j != 0) &&
                    t.item1 >= 0 &&
                    t.item1 < grid[y].length &&
                    t.item2 >= 0 &&
                    t.item2 < grid.length) {
                  toVisit.add(Tuple2(x + i, y + j));
                }
              }
            }
          }
        }
      }
    }
    // chain flash
    while (toVisit.isNotEmpty) {
      var t = toVisit.first;
      toVisit.removeAt(0);
      var x = t.item1;
      var y = t.item2;
      if (grid[y][x] < 10) {
        grid[y][x]++;
        if (grid[y][x] > 9) {
          flashes++;
          for (var i = -1; i <= 1; i++) {
            for (var j = -1; j <= 1; j++) {
              var t = Tuple2(x + i, y + j);
              if ((i != 0 || j != 0) &&
                  t.item1 >= 0 &&
                  t.item1 < grid[y].length &&
                  t.item2 >= 0 &&
                  t.item2 < grid.length) {
                toVisit.add(Tuple2(x + i, y + j));
              }
            }
          }
        }
      }
    }
    // reset
    for (var y = 0; y < grid.length; y++) {
      for (var x = 0; x < grid[y].length; x++) {
        if (grid[y][x] > 9) {
          grid[y][x] = 0;
        }
      }
    }
    // check
    var allFlashed = true;
    for (var y = 0; y < grid.length; y++) {
      if (allFlashed) {
        for (var x = 0; x < grid[y].length; x++) {
          if (grid[y][x] == 0) {
            // cool
          } else {
            allFlashed = false;
            break;
          }
        }
      } else {
        break;
      }
    }
    if (allFlashed) {
      return i + 1;
    }
  }
  // print('Step $steps:\n${out(grid)}\n');
  return -1;
}

aoc11() {
  return calc2(input);
}

const inputTT = '''11111
19991
19191
19991
11111''';

const inputT = '''5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526''';

const input = '''1254117228
4416873224
8354381553
1372637614
5586538553
7213333427
3571362825
1681126243
8718312138
5254266347''';
