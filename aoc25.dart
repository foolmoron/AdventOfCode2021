enum Space { none, right, down }

class Map {
  late List<List<Space>> grid;

  Map(String s) {
    grid = s
        .split('\n')
        .map((e) => e
            .split('')
            .map(
                (x) => {'.': Space.none, '>': Space.right, 'v': Space.down}[x]!)
            .toList())
        .toList();
  }

  int runRight() {
    final moves = List.filled(grid[0].length, false, growable: false);
    var yLen = grid.length;
    var xLen = grid[0].length;
    var moveCount = 0;
    for (var y = 0; y < yLen; y++) {
      moves.fillRange(0, xLen, false);
      for (var x = 0; x < xLen; x++) {
        var next = (x + 1) % xLen;
        if (grid[y][x] == Space.right && grid[y][next] == Space.none) {
          moves[x] = true;
        }
      }
      for (var x = 0; x < xLen; x++) {
        if (moves[x]) {
          var next = (x + 1) % xLen;
          grid[y][x] = Space.none;
          grid[y][next] = Space.right;
          moveCount++;
        }
      }
    }
    return moveCount;
  }

  int runDown() {
    final moves = List.filled(grid[0].length, false, growable: false);
    var yLen = grid.length;
    var xLen = grid[0].length;
    var moveCount = 0;
    for (var x = 0; x < xLen; x++) {
      moves.fillRange(0, yLen, false);
      for (var y = 0; y < yLen; y++) {
        var next = (y + 1) % yLen;
        if (grid[y][x] == Space.down && grid[next][x] == Space.none) {
          moves[y] = true;
        }
      }
      for (var y = 0; y < yLen; y++) {
        if (moves[y]) {
          var next = (y + 1) % yLen;
          grid[y][x] = Space.none;
          grid[next][x] = Space.down;
          moveCount++;
        }
      }
    }
    return moveCount;
  }

  int run() {
    return runRight() + runDown();
  }

  @override
  String toString() {
    return grid
        .map((e) => e
            .map((e) => {Space.none: '.', Space.right: '>', Space.down: 'v'}[e])
            .join())
        .join('\n');
  }
}

int calc1(String s) {
  var x = Map(s);
  print('0:\n$x');
  var i = 0;
  while (true) {
    i++;
    var count = x.run();
    print('$i:\n$x');
    if (count == 0) {
      return i;
    }
  }
}

calc2(String s) {
  var x = Map(s);
  return x;
}

aoc25() {
  return calc1(input);
}

const inputTT = '''..........
.>v....v..
.......>..
..........''';

const inputT = '''v...>>.vv>
.vv>>.vv..
>>.>v>...v
>>v>>.>.v.
v>v.vv.v..
>.>>..v...
.vv..>.>v.
v.v..>>v.v
....v..v.>''';

const input =
    '''v>..v.v>.>..>.......>v>v>v.vvv>..v...vv.>>......v..>...v....>>v...v..v.v...>v..>v>>..>v>.v..>>v...vv.v>..>vvv..>v...>.vv>vv.v>>.....v>v.v.>
>v.>.v.v.....>v>>v..v...>.>..>.>.vvvv..>vv.>.>v>.....v>>v>v.....>.v.>...>....v>......>v>>vv>v......v>.vv.>v.v.v..v.vv>vvvv>..v.>.v...v.>>.>
v.>...>....vv.v>.>.v.v...v.v>...>.vv..>>v>>>..>>.v..vv>.>..>.vv.>vv.v....vvv>.vv.vv.>..>>....>>>.>.>..>.v.v.v...>.v..v.>..>..v.v...v.v>.>>.
.>..>>.>.....vv..vvv...>>>v.>v..v.>.v..>.v..vv..>....>........v.v>v..v>..v>>v>v>v.vvv.v>>vv.vv.>>...vv.>>..>......>v>>>>.v...>..>.....v.v.v
>v>>..>.v........>....>v>.v.....v.v.v...v>..vv.v.>..>....>..v>.v....>>>v>v.v...vvv>v..>.....>>>vv>>vv..v.>v>....>>..>.v>...v.vv.>>v..v>>v.v
..>>v>....>..v>v..v.v..>.....v.>vv....v>....v.v>.>v>....v>.>..>>.vv.>>>..v.v>v..v.v..v>v.>v.>v.>v..>v.>...v...vv>>.>>....vvv....vv>>v..>.vv
..>..>.v>>...>.>>v...>>.v>vv.>>.>v>.v....v>vv.v>>v.vvv......vvv>...vvv>>v..>.vv.>vv..>>..>..>v...>v..v>v.v.vv>.....>.vv>..>>..v>>....>>vvv>
..>.>>v.>>..v.>vv.>.....>.....v..>>.>......>>..v>...v....v..v.v.v..v..>..v...>>>v.....v...>.v>...v>vv.vv>.vv>.vv>.v.vvvvv>vv>..>..>>.v>v..v
..v>.v..v>...>.>.>v.>..>...>>v..v>.......vv.>......>>.v...v.v.v.v..>>>>..>.v..>vv.>.v.vv.>>v>vvvv.v>v>..>>.v..v.>..>>....>v.....>>..v.v>v.>
v>>.v.vvv>.>.>>>vv.vv..>>.>>>vv.v.>.>.>..>>vv>vvv>v>..>.v.v>>vvv>>>vv.v>>>>.v>>.v>>..v>>........>v>.v.v..>>.v>vv....vv>v..vv.>v.>....>v..v.
..v.vvvvv.>vv.v.v>.vv>.>>>>vvv..>>>....v.>..v...>..>.....>vvv>vv........v>>>.>v.>>>v...v..>>v.....v..>.v>.v>v......v>.>.vv....v.vv...v>>.>.
v...>..v.v>...>.v.v.>vv>>v.v.>>.>..vv>>>.......>..v.>v..v.>.>.>..vvv.v.>.>.v.vv>.>.v...>v.....vvv.>v>>>v.v..>v..vv>..>..v..v..>..>.>v>.v.>v
..>v..>.>..>.>>>.v.vv>...v>.>.v.v.vv>v>.>>.....v......>vv>v>.>v.v.v...vv.vv.....>>>>vv>v.v....>...v>>.v>.vv.>.v..v..>v>>.v>...v.v..>..>>..>
>>.v.vv......v>>.vv....v>>.v>>.v..>v>..v>>v..v...v..>.v....>.>.vv>>..vv>>.v..v..>...>vvvv....>v>.>..>..v>>...v>...vv.v>...v....>v...>...vv.
....>.>.v>.v.>...vv>.vvv.>v...v.v...v>.>.>>.>v>..>v..>..>..>.v..v>vv..v.>.v..v>>vv>>.v..v.>v>>>v>..>>v>>.>.>.>>..>>..v.v>.>..v>.>v..v>v.>..
>.v.>v.....vv.>>>>>>.v..v>...v.>.....vv>>v>.>.v.vv..v.v.vvv.>.v.v.>>..>..>..>..v.>..v.v>>..>...vv.>v>vv>.>v>.>..>...v>>>>.>v.v>>>..v....>.>
.>..v..>..v......v...v.>.vv..v..>v.>.....v.v.v.v....vvv>vvv.>..>>.>.vv>v....>...>.vvv.v>v..>.v..>>...v...>v.v.vv..v.v.>..>..>.....>.>..>>..
..vv>...v.>>....>.vvv..v.....>v.....>>v.v.>..v..>>>v...>>.>.vv>......>v...v>.>v.>.v>.vv...>..v.>..v.....v>.vv....>.>v...v.>v>..v>v>.....v.>
v.v.v>..>vvv>..>.vv.>>.>>v>v>..vv>.>vv.v.vv.>.v>vv>vvvv.vv>..>.v>>.>.vv.v...v.vv.v..>vv>..v.v.>..v.>.v>.v....>.>..>v.v.>..vv.vv...v....>>..
..>...v..>v..>.v..v>vv.v.>>v.......v>v.....>...>>.>>....>...>v>>..>vvvv>vv..vv.....vv.>......v>>.>>vv>>>...>>v>>..v>..>>.>.v>vv.>vv.>..>..>
v>..v.vv...v..v.>>..vv.v.v.v.v..v...>....>>>vv>>..>..>.v..v.>.v..>vv.....>>..>.>..v>v.>..>>..v.vvv..>vv.>...v..>v>...>>.>..>>>..vv.>>>vv...
v>.>v......>v.>.>..v>..>..>v.>vv...>..v.v>.v..v.v...>..>.>>v...v.>>.vv>...vv..v>>..>v.>>>v>>.v.>..v.>vv........v>.>vv..>v>>..v..>v.>v>.vv>.
v>..>.v.v.>.>..v>.>>>>>..>.>vv>v.>.v>>.v.vv...>>.>....>...v.>.>v>>.>..>..>vv.>>>v..v>.>v.v>v>vv>.......v>>v.>..vvv.>v>v>v.>...v>.>>.v.v.v.>
v..v>>.v>>.vv.>.....v..v>...v>v.>v.>..>>.v.v.v>......>>...v.v>..>..v.>vvv>..>.>vvv>>....>>>>>.>.>.v>>>>.v......>>>>.vv....>...>.>>....>>v>.
.>.>.vv.....>v.v>v.v.>v...v.vv.>.>.v.v>v>>>.vv..>>.v>vv..>>>.>>>>.v..>vvv....>.v>..>.v>.vv...>>v.>>..v.>...>..vv>..>>>>..vv>v.>.>.>>v>.v...
.v....>..>v......>..>>....>v.v..vv...v...vv...>>..>..vv..>v>.>.vv..v.v.v.>.v>.>>>.>....>v...v>.vv>..vv....>v.....>..>..vv.>>>v.>v.vv..>>>v.
.v>>>..>>.>>>.v>>.>v.v>.v....vv...v..>>..>>v>>..>v>v>..vvv...v>.v.>.>...vv.v>..v>.>......v>.v>>...>.v......>>v.v...v..v.v>.>..>.>.v.>>.vv.v
..vv.vv.>....>..>..vv>v>>v>vv>v.v..v...>.v>v>.....>..v>.>.>>..>..>...v>.>.v...>>..v>.>>v.>vv.v.vvv>>..vv>>.v.>.>vv...v..v.v..v.vv...>>.....
>>>..v>............v>..v.vv..>..>>.v>.>..>....v>...>......v.>.v...v.>..vv......>>>.>...>.v.>v>>v>>.vv..vv>.v.>.>.vv.v>.>..v.....>...v.v..>>
>>......>>v.v.vv..>.>>...>v..>.vvv..>>v...v...v.v......v.v...v.vv....>.>.>v..v.v..v>v.v>v.v>vv>.v.v.....>>.>.v>.>vvv..>vv..>>...v>>.v.>>>>.
v>v..vvvv.v.>....vvvvv.vv>.>v.>.v>.vvv.>..v....vvv..>v>v.v.>>.v>v>.>.......>v....>.....vv.v.v>v>>vv>.v.>>..>..vvvv>.>vv...>>..vv..>.>.v>vv.
.vv..>.>>...........>.v>.v.>v.>>>.....>>>v.v.vv.v....v.v.>..v....v>>.>v>v.v...v>.v.v.vv>.....v>....>..>v>>v.vv..........v...v>...vv..>v>.v.
>...vvv>vv>.v>>....v.v..>v.v..>>.v.>vv.>v.>..v..vvvv..v>vvv......v....>.v.>.v>.>v.vvv.>...>.vvv.>........v>v>v...>>.vv>.>.>v.>v.v.>...>v.>v
>..>>.>..>..>.v>vv>v...>v..v..>v..>.....v.....v..>.v>..>v>.v.>v...v>.v..v.v.....v>.>v>.....v>vvv>>v>.vv..v>>.>.>..>>vv...>vv>>.>v.v>>>>..>.
.v>...>>>.>.>.>..>..v>.v.>..v.>>v....v..v.v.>....>.>....v>.........v>>...>>>.>.v.>>.vv..vvv.>...>.>>>....>vv...v>.v.v>.>>.v..v>.v..>.>>>.v.
>.>..>v..>..vvv>.>.v.>>......>.v>..>>.>.v.>.v.vv....>v.v>...vv.>v.>...>vvv.vvvv.>>>>>v.>v..v>v....>v>...v>>.vvv>...v....>>vv....>>v.>.>.>.>
......v.>........>.v>.v.>>v...>v>...>.>v>..>>>....v.vv..vv>.>>>.v>>...>v...>.v>.>v...>.>vv.vvv>..>.>..vv..vv>.>.>>....>.v>>v>..>v.>>.vv...>
v....v.>.vv.vv...v..v.>v>..>.v..v.>.>.v...v>>..v.v.>.v......v..>...>.>.......v.v...v.vv.>v..v..>vv...>.v.v>v>.>...v....v........>....v.v>..
>>..>>.>..v..v...v>v....>v.>.>..v.>.v>.v>vv>.v.>>vv.v>.>.>>v>.>>>..vv.>>>...v..v.>vv.v...>>>>vv.v>.>..v>.v>..vv>v.>...>.v...v.v>...vv>..v..
v.>....>>..v..v>.>v.v>v>>.v.>v.>v..v...>v.>..>....v>vvv>>.......>v.v.v>>vv.>.....v>v..vvv....>.v.vv...v>>v>..v>.>.v..v..v...>..>.>v.>vv>>.v
..v.>>v..v>v.>v>.v...v.v.v.>v....>v..v..>..>...>..v.v.>.>..>v.v>v>>>v>>v>.....>.>>.v>....>vv>v.v.>>.v>>>.>v...vv..vv>>vv>>.>>>vvv.>>..>v.v.
>v...>....>.>......>>>vv..>vvv..>..>>..>vv>..v.>.v>vv>..v>.v>>.....v>>..>..v...>.vv>vv.v.v>v.>.v..>.v.>.v>>v>..>>>>.v.v>...>.>.>.v.>..v.>v.
>....v.v>>.>.>vv.>...>.vvv>.>.v.>..>.v>>>..v>>v>vvvvvvvv...>..v..v.vvv.>vvv...vvvv..v>>>v>>v>>v>...>vv>v...v>>.>.>.>>v>.>.v>vv....vv..>..>.
..v.v.>.vv>..v...vv..v..v...>.>.>.>>..v.....>........>...v.....v..v>.v.>.>.>v..>>v..v.v.>...>vvv.v..v>.vvv>.>.>>.>vv..v.vv>.vv.v..>.v>...v.
..>...v..v>v>>v>vv....>.....>v...vvvv....vv.v..vv.>.v.>>.>..>v>.>>..>...>..>......>.>.vv.>v>...>>.v>.>.v>........>>>>>>.>.v...v>.>..>.>..v.
.vvv>..v>>....v.....v.v.vv..>v.v>>....v>v..>>>.>....vv.v.v>.>....v>>>.>.v....v.>v..>vv>...>..vv...v.v...>v.>..v.vv..>.v.v>>..>.vv>v...v>.v.
..>>..v..v.v..v>v..v.>v>...v>..>>v.>v.v>v.v..>>v.v...vvvvvv>vvvv...>.>..>>>>.v.v>.v..v>...v..v.>v......v>>>....>vv...v...>vv...>.>>>>>v>.>.
vv>v..>.vvv..>>>>...v>...v>.v>>...>>>.v>>...v>..v..vv.vvv.v>.>>v>..v>.v>v.v..v...v.vv>v......>........>...v>v>...v>.v.>v..>>v...>...>.v.>>>
vv..>>......v.>.>>>.>>>vv>>>.>...v....>...>>vv..v..>>>..v>.v>...>.>v>>vv>...>>>.v..>.v.>...>.v...v.>..v..>v.v..v..v.v.v.v....>>v..>.v.v>>v.
..>>v.vv...v>>v..>v.>v>>..v..>.>.....>.vvv....>>>...v>...>v>vv..>...v....>..v>.v..>.v.>.>.>.>...>v..>..>v>..>>...v>>>v....>..>>..>>.v.....>
..v...>v.>>v.>..>v.v.>>vv..>..>.v.vv.v...v....>v>....v>.>..>>.v.v.v......v.>.v>v>>>.>...>>..vvv.>...v.>..v>.v.vvvv....v.v.>.v.....>...v..v.
...>..v>..vv...>>..v>>>..>..>.>.>vv.>..v...>..>.>.>v...v>..v..vvv.vvv.v........>>>v..v..>.>>.....>v>v.vv.v>v..v>>v>>v.v>.v.>..v..>vv>.v>.>.
v..>v>v...>..>>>>>.....v...>..v>>.>..v>..>>...vv..>>>.>.>vv....>...v.>...>vv>.v.>>..vv......v..>.>vvv..>v>.>>..v..v>>...v>vvv.>>.v..>v.>.>>
..>.>v>>>v.>vv>..v>..>v..v..>..>.v.v.>v>.>.vvv>vv.>.>v.>>v..>>.vv..>v>.>>..v.>vv..>>vv.>>vv>>....>.v..>.....v.>vv..v.vv>>.>.>>>...>.>v..v.v
..>vv....vv....v..>.v..vv..>>vvvv...>.vvv.>v>.v.v.>>.v.v>.>.v.>>>..v...v..>..v...vv.>v>>v>vv...v.v...v.vv.vvv..v.>>....>v>...v.>...v.v>..v.
..v>>...>.....>>v..v>..>.v..>vv.>>>.v>v..v>.v>.>..v.>....>>v.>>v.>..>..v>..>.>>..>.vv.>>...v>vv.v.v.>>.>>>.v.>v....v...>>>>v>...v..>v..>v.>
...>>v.v...>......v...>v.v.>>...v...v>>..>vv....>v....>...>>..>>..>v.>v>>>.v.>..v>>.v.v..>.>>..v.vv......vv.vv.v.v>.v>.v..v>v>>..v.vvv..>>>
.>>.vv>.>...v>vv>...v.>..vv..v..>vv..v.>.>.vv.>vv..>...>vv..>vvv>v>v...>..>vv...>>>.v..>..vvv.......v>.v......v...>.....>..v.v..v....v.v..>
....v>>...>vv>v>>v>..>...v..>...>>v.>vvv.>.>.vvv..v...>.....v.>>..v>vvv>..v...>>......v..>....v.v..vv>>>...vv>..>.>..vv>...vvv...v...v.....
..>v.>....>>...>..>......>.>v..v.>.vv..v..>v..v>vv>>...>v....>.vv>.>.>>>.>......vv..>>>v>>vv....vv..v..>...v.>>......v>v.vv>.>>...v>.v....v
v...v..>>v.....v..>..>v>.>>>.>>v.v.>.v..>v.v.v.v.v>v..>.>...v.>>vvv...vvv.>>>>vvv>.v>..vv>........v..vvv>.>v>.>.v...v>v..>>...>..>>>>>>>vv.
.>.v.v.vv.>vvvv>.v..>.>.v.vv.>...v..v..>vv..v.v...v>......>..v>v>.v.....v...vv>>v.v.............>>.>>......v>>.vvvvv>vvv..v....>v......v>>.
>v..vvv..>...v.>>..v.>.>.vv.v.>v..>vv.v>v...vv>>>.v.>vvv>....v>>>vv..v>.>.>>...v.>...v...>>..vvv....>>.v.v.>..v.>..vv..>.vv>>vvvv>..>.>....
...vv.v.vv..>...>..>>>>>...>......v.>.>..>..vv.v..v.v..>>>>.>v>v.>v>v.>.>>v......v..v>>vv...vv.v>vv.v.>..>v>.>..v>.v....vvv>v.>.>>v.vv.>>.v
>v.....>v>v.>...>.....vvv.>.>....>.v....>..>>v>v>>>vv...vv.>v..vvvv>..v.v.v...vvv.>>>....v....vv....v....>..v.v>v>.v.>.v.v.vv>>..v.vvv>..v.
>..>.vv>..vv>.>v.vv.>.>v.>.v>>>>vvv.>.>v>..>vv.v.>>.v>v.>v...vv..vv.vv..v.>....v>.>v.>v.v>..>..>>.vv>..>v.>>.....>>v.vv...v>.>.>>>v...>>v..
.vv.>..v>>.v>vv.v...v>v.......v...vv.>.>v.>>vv..>v.>.>v.v>..>v.v>.>.vv.v>>..v..>.>>..>...>.v.>vv>>vv.>>.v.v>.>.....v>..>.>.vvvv>>.>v...v..v
...>...>>..>v...>........>v..>..>v...>..v>v.>v>v.>v>>.v...>......>>..vvv>>...vv.>v.>v..v.vv....v>v>v.>...>.>...v.v>.>vv..>>....>>..v>...>>.
>......>..v.>>.>..>.vv....>.>.v.v.>.v..>.....v.>>v..vv.>v.v....v...v>..vv.>>.v.v>.vv>....>v>.v.>..vv..vv..vv.....>...>..vv.>.vv>vv.v>v>>>..
.v>.vv>>vv..vv....v>..>v..>.v.>.>..>.>>v..vvv>....>.>vvvv>v......v.vv>>>.v.>.v..>v>.....vv....vv>>.....>.>>..v...>.v...>.v>.v>.>..>..>v>>v.
..v..>vv..v.vv........v.>....v..vv...>.>.>v..v..>>v>.>v.>v..v..v.v>v..v.vv..v...vv...>v..v..v.>..>>v..v....>v...>>>>.v>v.>v...>v....v......
...>>.v..>vvv>.vv>..vvv..vvv>.....v...>>v..>.>v...vv.>v>.vvv..>.>.....>>...vv>>v>..>.v.v.>>.v.>.v....>>..>.v.v..vv>......vv>.>.v..vv.>....v
v.>>>>v...>>..v>v.>v>..>v.>.>.>.>..v...>>.>v>>.>>.v.v......>v..v...>v.v>.>>..>..>..v..>.v..>v>v.>>....>.>.v.>vv.vv>v.>>>...v.>>..v.>....v>.
v>>v.v..>.....>.vvv>....v>>.....v.vv.>.>>.v>>>..v.v>.>>..v.vv.vv.v....v..>>.>.>.......>..v.>.v.v.v>vv..>vv>.v.v.v.v>v>v...>>.......>vv>v.v>
>vv.vv.>>>..vv.>v>v.>vvv.>.>>>>>.vvv.>..>v.v>v..>.>...v>.....v>..vv...v>...v.v..>.>>v.>.>vvvv>..v...>>..vvv.>.>....vv..>.>v.v>..>vvv.>..>>>
.>v.v>...v.....v.>...v.v>.>v>.>...v..>.>.>.>v>.>...>v...v......>>v>vvv>.>v>.>.vv.>v>v.v>.>v.>..vv.v>v..>.v>..>v.v..>..>v.v.>v.v.>.>vv>.>>.>
.>>.vv.vv>>.vv>......v..>....>>..v.>v.vvv>>v.v..>v.v.>...v>v.>.>v.v.v..v>vv>.>...>>v>..vvv........>v...>>v>>v...>v.>......v..v>>v.v...>v>..
v.>v.>...>..vv......v....>.v..>.>>vv>v..v..v>v.>..>..vv....vv.vv.>.>>.>.vv.....vvvv..v>..>.v.>>>.v>.vv>...vvv>..>....v.v.>..vvvv>.v>...v.vv
..>v.......v>>vv.v......>v>..v.>v.v.>.vv.>..v...>.v>..v>v.>v>>v>.v..v.v.v..v.v>..vv.>v>>.>>v>>.>.>.>>..vv>.>>...>...v>vv.>.....>.>>>>.v..v.
.v>..>v>v.>vv>v>>v>v....>v..v.>v.>...v...v.>...v.v..vv.v..v...v........v>.>vv.>vvv.>.>....>..>>.>>v..v.>>.>>v>...>vv..>v>>v>vv....>.v>v.>.v
..v.>>v.vv...vvvv..>...v.>>....vv...>>vv.v...>..v...v.>.vvvv..vvv..v>v>..v...v....>.>.>vv>..>.>.......v...v.>.v.>.v...v...>v......vv.vv>v.>
v>vv>>.v....v.>....v..v.>.>.>>>v.>.....>..>...v.>..v..v.>>...>.v>v.....v>.v.....v...v...vv.>>.v>>vv..v.>v.v>..>v.v>.>....v.vv..>>....v.....
v>vv..v......>v.>...v.....>vv.>>>>..>.>v.v>...>>>..>vv>..>.>....>.>v>v>...>...vv.>.>...v>>vvvvv>v>..vv>.v.v.>>..>vv>...v>..v>v..>.>v>v>>..v
>>.v>...vv.>>vv..v>>>..>v>.v...>vv......>v...>.>.v.v..v>..v.v..>..vvvv......v..>>..vv.>>>v>.>.>v>>>v>...v...vv..>.v.>..vvv>>vv>v.v.>v>.....
.v..>..v..>.>v.>v.v>..>v>.>v..>>..>.>.>.vv>vvv>.....>...vv>>....>v>...>>..v...v.v..v>v.>>v.vvv.>>.>...v..>>>>.>.v.>>.>v>.>v.v>>vv.>....>vv.
..........>v>vvv..v...>>.>>..v..>>.v..v>...>.v.>..>>>>...vv..vv.vv>>>vv.v.v.>....>.>..v.v>....>.>..>vv.vvv.>....v..>.v>>..v.>>v.>>..>..>>..
.v.>..vv...vv....>v>..>v>v....v.v....>v..v>>vv..>>vv......>..vvv...vv.v>......>>.>v>v.v..v....v.>.v.>.>......v....>.....>v>>....v>v>.v>v..v
v.>>>v..vvv>v.>.>.....v..v>...>v>......>vv>..v...v.>..v.>>>..>>....>..v.v...vvv....>>>>..>>.v.v.....>...>>.v.vvv.>.>>>>..>.v>..>>>>..>v.>vv
..v..v>v.v>>v>..>v.v....>v.v.>>>.>..v....v..>>.v>.....>...vv..>v...v.vv...>.v.>.v....v..>>.vvv>>v..>.>.....>.vv..v..v.>...>....>..>..>vvvv.
>v.v>..>..v.>>.>>..>>>..>v>>....>.>vv..>>v>...vv..>v...>..>.v.>.>v>.>.....>.vv.v.v...>>>vv>>.vv.v......v...v.vv.>>.>>>v..v.>>v...v...v>.>>v
v.vv....v.>>..>....>.v.>.....>.>.vvv.v.....>.>..>.v>..v>.vv.>...>vv...>.>...>.>v.>.>.v..>.v..v..v..vv>v....>v..vv>v>vvv.v>vv..>>v>>v.>v...v
..>..>.>>.>vvv.>v>v>.v...>..v..>v.....v>>....>vv>>>..>.vvv>.v.v.v>v>...>.>.v..v..v.>vv...v.....v>.>.>v>.>>>v>..>....v.>>>v....>>.v..>..v>v.
>>..v.>>>>...vvv..v.vv.......vvv>..>>>.v..v.>v.....>vv>v....>......>..>v>..>vv>v..>v..v....v>>...>.>v..>v.>...v>.>v.>.v>.v.v...vvv>>.v>>>..
.>v.v>v.v......v>...>>v>vv>...v>>v..vv>>v.v..v..v>v>..>.v>v.>...v>..v....v>..>...vv......v..>..vv...>.>>.v.v..vv...>.v>.>..v>vv>>.v>...>>.v
.>.>.>>.>....v>...>...v>.vvv.>..>..v>>v...v>.....v.v..>..>>....v..v..>v>..>>v..>v..v..>>>v..v...>.vv.>vv>vvv.v...v.>v.>.>>>.>>>..vvv>>.>.v>
..>.v...v.>.>.v>v.v.>v..v..v>..vv..v...>vvv>>.v>v.>.>.>vvvvv..>>v.>.>...v.......v>.v..>>..v>.....v>.>.>.>.>.>v..v.v..v.v>>..v>.v....>...v.v
..v..v..>.v>v.v.v..v....v>...>..v>vv..>.>.v>.v>vv>v...vv.v.>>....v>vv...v..>.>v...v.vv>v..v..>v...>.v.v..>..vv>..v>...>..>v...v>.>>.>..v.>>
...v...>.vv...>>v..v.v....v.v>v..v.vvv.....>.........vv..>.v.>v...>...v..v..>>..vv.>.vvv>v...vv>>...v.vvv...vvv.>..>>vv.vvv.>.v.>.>.v>>vv..
.v>>vv.v.v>>>>.>>v.....v>........>..v..>.v>>.>..v>..>v..v>.....>vv>v>v..>>>>...v.vv.>....>.v>>.>v>>>v.>.v....v...>vv..>...>>..>>.>>>v...v>v
.....>>v.v.>>..v>v.vv.v>..>...>>..>v.vvvv.>..>.vvv.>..vv.....>...v>v.v....v....v>v.>>>>.v..>>>>vv.v.vv>v.>>...vv...v...vv>...>>.>>..>v..v.v
....>.v>.v>>v>v>.>>...>>v>..>>.v>v>>..v..v>.v.vv>v.v>v......>>>>v...>.>>...>>....>vv>>>>v..>....v..v>vvv.>....v>.vv..v>.vvv..>v..>.v.v>>...
v.>...>v.>>..>v.v.v.>.>vv>..v>.>.>v>>>>v...>.v>>>>>vv>v.>.vv.....vvv>>.v.>.>>.v...v...>...v>>>v.v>v.>.>vv>.>>v..>>>v.v...>..v>.v.>...vv...v
...v..............v.v..v>>>v>.>....>..>v.>v.v...>>>v.v...>>.>.>.v.v.>>.v.>>....>..>>>v>.v..v>....>.vv..>.>vv>>v.v>..v.>..>vvv..>>...>.>v..v
.v>..>v>>...vv.vvv.>.vvv>>v>.v..>.>...>v..v>.>v>.>v.>....>.vv.v.vvv>..v>..v.v..>v>.v.>....>>v.v.v.>.>>>..v>...>v>>>>.v....vv>>>>v..vvv..v.>
.v>v....>.>>.>....>v>>.>.>..>>>.v.....>.>.v>>.>v....v>...>>.>.>v....>..v>v..v>>.>v..vvv>vv>v...v..vv.v>...>.....>....>>v>>vv..>.v.>vv...vvv
>....v....v>v>v...>.vv...v>.>..>>...>v....vv.v....>v...v..>......v..v>..>v...>vvvv.v.v>v>>vv>.>vv.>>..vvv......>vvv>...>>.v..v.>.>v>...>>vv
.....v>.>.....>v>.v...>>>...vvv.>v.......>>..>..v>..>v..v....v>v.>..v.v...vv>>.......v>>......v...>.>>vv>v..v..>.vvv.>...v>>.>v>..vv..>....
..v........>>..v>>..v>>v>v....v.>..>.>>.>.>..v.>>>>.>>..v.>v>>v>v.>.v..>.vv.>>....>.vv>..v.>>..v>vvvv.v>..>>........v.>>...>>>...>...>v.>.v
>>>vv...>.>.>....>v.v>v>.>v.>....v..>vv...>.>v.>v..>v>v>v.>>>.v..>>..v..v>..v.>.>v>v.v>>v>..v..vv......v.>.>..v>>>v>v.>.v...>v...>vvv..v.>.
....v.>.>.>v.>v..>v>>...>.....>..v>v>>...>..v...v>....>>...v.v.>v>...v...>..vvv..v.>.>>vv.v....>v>.>.>.v>>...>v.>vv.v>.v>v....>.>..>.>v.>>v
>v....>>....>..>..v.v.....>v.v..>.v.....v>>>.>.v>.vvvv.>v.v..>v..>>v.>>vvv...>..>>.vvv....v.v....>.>v..>v....v>>.vv.v>.v..>v.....v.>..v...v
.>v.v.>vv>v....v..vv..v.>..>........v..v>v.>vv...v.v.v.......v>v>.vv..>>..vv>>.>>...>...vv...>vvv..v>.>>....>>.>.>....v...vv.vv>>..>.>....>
.v...v.....v.>....v>>....v>..>>>......>..vvv..v>>.vv>.>vv.v.>.vv>.>>....>v.>.>...vv.>...vv.vvv.......>....v.>v>>>v..>v..v.v.vvv...>.>...>>>
v.>.v>>vv>>...vvvv>>vv>.>v..vv>v>..v....>...>...>>>......vv.v>v..v..v>v.v>v>.v>>....>v.v.>.vv..vv.>>....vv..>..v....v..v>v..v>>.v..v.v>.>v>
vv>v..v>.v..>v.v.v.vv.>v.v.......v.v>v...>..>>>>.vv>..>.>>.v..>vv.v...v..v.v.vv...v...>..v>.>....>>.>>..v.>..v...>v..>>>..>>>v...v>.....v.>
..vv>>>...>.v.v....v.>>v>.>..>v.v.>vvv>v...>.v>..v.....v>v..>v>...v>.v.>..vv......v>v.vv.v>..>v>v>..v..v.>..v..>v.v>>...>...>>..v...>v>..v.
.>>v>v..v>...>v>.>..v>.v....>>v..vv.>vv...>v...>.v...vv.>v..>..v>>.>.v>v.v.v.>v....v...>>v.>..>...>.>vv.v.>>..v>>....v..>>......>>>.>.v...v
vv>....>>>>.>>v...vv...>>.v.v.v..>.v>.v>v>.v.>vv.vv...>>.>.>v...vv...v.>>......vvv>..>..>...>>......>...>>vv..>>>>.........v>v...vv.v>v...>
>...v>.v....>...v>v>v>......v......v>>>.vv..vv>....v.......>.>..>.v>.>.>v.v...v>v>>.>.>.....>>.>>v>..vv..vvv...v>...v....>..v.>v.>>.>v.vv..
v>v.>v.vv>v.>>...v>>.>..v.v.v.vv.v..>v>..>...>>v>.>.>.v>..>>........>....v.>.v.v>.>.v.>.v>.>.vvvvv...>v.>>vv.>..v>...>...v>.v>>v.>.v>vv..v.
v>..v....v.>...>.......>.v.v.>>>..>..v>.>>.>v>vvv..>....v>v.v.v>.........v.v.v>...>>..>.>...>v....v.>vv.......v..>.>>..vvv...v...>v>vvv>.vv
..v.v..vv.>...>v.v>>..>..v.v..>>v.v>>.v>v..vvvv>>.vv...>v.>>....>..>.vv......>.>>>v.>>.>.vv>....v.>.....>v..v.....vvvv.v.....vv..v...v>.v.v
.v..vv..v..>v..v.v>.>..v...>.vv..vv>..>..>.v..>>.vv..v...>>....>.>>.vv..>>.v...v>...>v>.>vv>v>>...vv>>v..v..>..vvv..>>>.>>v>..vv>.>v..>.v.>
>..v..v..v>.v>..vvv..v>.>..v...>>v>v>..vv....v.v>.v..v...>.......v>.>.v.>.vvvv...v..vv.v.v...v.v.>...>..vv>.v.v>vv.vv>>.....>.>v.v.v>>.vv>>
vv.v...v.v.>..v>.>>.v>v>..v...>...>v..>...v..>..v>vv.v>.>>v...v.vvv.>v....>.>v>..>v>vv..>.vv..>.>.v..>.v.>.v...v>>v..>v>vvv...v.>vv........
v.>.>>v.v.>.>.>v>v.v>......>v....vv.vv.>vvv>.>.>...vv..v>..v>...vv>...v...>>v..>...v>>>vv..v>>..v.v>>>vv.>.>>..>.v.vvv>>v>.>.vvvv.v.>.v....
.v..v.>v>.v.v..>vv..>.....v>.>>v..v.v.>.>>vv>>>....v>>.....v>>.>>.>v.>.v>>.>>.v>v.>>..>>...v>...v...>.v...v.v.>>v..>..>v..>>v...v.v.v.vv>.v
.>v>v.>>.v......v..>..v..>.vv..>v....>>..>>v.>v...>v>>.>>.>>v..v.>v...>>..v>>v.....v>>v..vv.>..vv...v>....>>>..v.>v.v.....v>.>>>>...v....v.
.v>.vv..v...>v.>..>....v..v..v.>....v..v.>>..>v..>.......v....>...>.>v...v...vv>v>....v......>.>>.v>>>>>>..>>v>v..vv.....>.>.vv...>v>..>.vv
.v....vv>>..v>.>v.>v.vvv>..v.>....>vv..>vvv>>>v>.>v.>>v..>>v.v..vv..>.v....>v..>vvv>.v.v>.>.>v>vvvv.vv.>.v.>>>>>.v..v.....v...>vv>>..v.>..v
.>vv...v.v..v......v.>>>..vv.>>vv>.vv.v...>v>>...>>v>.....>>>>>...>>>>v.v>vv>v.v>.v.>>v..>>.>>.>>v>.v.v>..>v........v>....>.>.v.v.vv>v.v>>v
.>>.>.v>vv..>v....vv>..>>>v>.>v.v.v.v....v>.>v.v...>....v......>.v.v.>...v..v>.vv>.vv..vv.>...>.v...>.v..v.>>vvv.>v...v...>>.vvv>>.vv.>.v..
.>.vv>v..v.v..v>>>>..v..>....>v>.>.....>..>>v.vv..v>>...>>.v>vvv>...v>v>>>vv.>...v........>..>.>>>..>v>v>v..v>.....>.....vv.>v.v>..vv>..v..
....>v>.vv..v.v>..v..vv>.>.>.v>>v>>..>..>.>..>v.>.>.v.>>vv....>v.>>..v..vv.>.>.>.v..>>v......v>>..>..>..>v.....>v.>.>..>.>v....>.v.v.vv.v.v
.vv.>.>v.v.v>..v..v..v...>>>>.........vv>>..>.....>v>.>.v.....v..v>...>>>>.>>......>>>v.>>>vvv>v>>>..vv..>>.v..>.v>.v.>..v.v.>..v>..>>>.v.>
.>vvvvvv.vvv..>.>.v>v..>>>.....>v..v...vv>v.....>.v>.v.v....vv>>....>.>vvv.>>>.v...vvv.v>.......v.>.>.....v.v.v.v>.v.>.>.>...>..v>>..v.>.>.
v..v>>..v....>v>.v>...vvv.>...v>.vv>vv>v>vv.....v>.>v.>.v..>v.>>..v>>>.>..>v......>>....v...v..>..vv>v.v.v.>>>vv>.>v.>.v.v.>>.>>>>..v...>..''';