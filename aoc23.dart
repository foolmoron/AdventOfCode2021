import 'dart:math';

import 'package:tuple/tuple.dart';
import 'package:collection/collection.dart';

int COMPARISON_NAIVE(StateWithCostAndDist a, StateWithCostAndDist b) {
  return (a.item3 * a.item2).compareTo(b.item3 * b.item2);
}

const MAX_COST = 100000;

// int COMPARISON_SEEDED(StateWithCostAndDist a, StateWithCostAndDist b) {
//   const TARGET_COST = 14629;
//   return (a.item3 * a.item2 * (a.item2 - TARGET_COST).abs())
//       .compareTo((b.item3 * b.item2 * (b.item2 - TARGET_COST).abs()));
// }

typedef State = Tuple4<
    Tuple4<Tuple2<int, int>, Tuple2<int, int>, Tuple2<int, int>,
        Tuple2<int, int>>,
    Tuple4<Tuple2<int, int>, Tuple2<int, int>, Tuple2<int, int>,
        Tuple2<int, int>>,
    Tuple4<Tuple2<int, int>, Tuple2<int, int>, Tuple2<int, int>,
        Tuple2<int, int>>,
    Tuple4<Tuple2<int, int>, Tuple2<int, int>, Tuple2<int, int>,
        Tuple2<int, int>>>;

class Board {
  final spots = <Tuple2<int, int>>[];
  late final State initialState;

  final homes = {
    'A': {
      Tuple2(3, 2),
      Tuple2(3, 3),
      Tuple2(3, 4),
      Tuple2(3, 5),
    },
    'B': {
      Tuple2(5, 2),
      Tuple2(5, 3),
      Tuple2(5, 4),
      Tuple2(5, 5),
    },
    'C': {
      Tuple2(7, 2),
      Tuple2(7, 3),
      Tuple2(7, 4),
      Tuple2(7, 5),
    },
    'D': {
      Tuple2(9, 2),
      Tuple2(9, 3),
      Tuple2(9, 4),
      Tuple2(9, 5),
    },
  };

  final costs = [
    1,
    1,
    1,
    1,
    10,
    10,
    10,
    10,
    100,
    100,
    100,
    100,
    1000,
    1000,
    1000,
    1000,
  ];

  Board(String s) {
    var lines = s.trim().split('\n');
    var pods = {
      'A': <Tuple2<int, int>>[],
      'B': <Tuple2<int, int>>[],
      'C': <Tuple2<int, int>>[],
      'D': <Tuple2<int, int>>[],
    };
    for (var y = 0; y < lines.length; y++) {
      for (var x = 0; x < lines[y].length; x++) {
        if (lines[y][x] != '#') {
          spots.add(Tuple2(x, y));
        }
        if (lines[y][x] != '#' && lines[y][x] != '.') {
          var pos = Tuple2(x, y);
          pods[lines[y][x]]!.add(pos);
        }
      }
    }
    initialState = Tuple4(
        Tuple4.fromList(pods['A']!),
        Tuple4.fromList(pods['B']!),
        Tuple4.fromList(pods['C']!),
        Tuple4.fromList(pods['D']!));
  }

  bool hasWon(State state) {
    return homes['A']!.contains(state.item1.item1) &&
        homes['A']!.contains(state.item1.item3) &&
        homes['A']!.contains(state.item1.item4) &&
        homes['A']!.contains(state.item1.item2) &&
        homes['B']!.contains(state.item2.item1) &&
        homes['B']!.contains(state.item2.item3) &&
        homes['B']!.contains(state.item2.item4) &&
        homes['B']!.contains(state.item2.item2) &&
        homes['C']!.contains(state.item3.item1) &&
        homes['C']!.contains(state.item3.item3) &&
        homes['C']!.contains(state.item3.item4) &&
        homes['C']!.contains(state.item3.item2) &&
        homes['D']!.contains(state.item4.item1) &&
        homes['D']!.contains(state.item4.item3) &&
        homes['D']!.contains(state.item4.item4) &&
        homes['D']!.contains(state.item4.item2);
  }

  int getDists(State state) {
    var minA1 = homes['A']!
        .map((e) =>
            (e.item1 - state.item1.item1.item1).abs() +
            (e.item2 - state.item1.item1.item2).abs())
        .reduce(min);
    var minA2 = homes['A']!
        .map((e) =>
            (e.item1 - state.item1.item2.item1).abs() +
            (e.item2 - state.item1.item2.item2).abs())
        .reduce(min);
    var minA3 = homes['A']!
        .map((e) =>
            (e.item1 - state.item1.item3.item1).abs() +
            (e.item2 - state.item1.item3.item2).abs())
        .reduce(min);
    var minA4 = homes['A']!
        .map((e) =>
            (e.item1 - state.item1.item4.item1).abs() +
            (e.item2 - state.item1.item4.item2).abs())
        .reduce(min);
    var minB1 = homes['B']!
        .map((e) =>
            (e.item1 - state.item2.item1.item1).abs() +
            (e.item2 - state.item2.item1.item2).abs())
        .reduce(min);
    var minB2 = homes['B']!
        .map((e) =>
            (e.item1 - state.item2.item2.item1).abs() +
            (e.item2 - state.item2.item2.item2).abs())
        .reduce(min);
    var minB3 = homes['B']!
        .map((e) =>
            (e.item1 - state.item2.item3.item1).abs() +
            (e.item2 - state.item2.item3.item2).abs())
        .reduce(min);
    var minB4 = homes['B']!
        .map((e) =>
            (e.item1 - state.item2.item4.item1).abs() +
            (e.item2 - state.item2.item4.item2).abs())
        .reduce(min);
    var minC1 = homes['C']!
        .map((e) =>
            (e.item1 - state.item3.item1.item1).abs() +
            (e.item2 - state.item3.item1.item2).abs())
        .reduce(min);
    var minC2 = homes['C']!
        .map((e) =>
            (e.item1 - state.item3.item2.item1).abs() +
            (e.item2 - state.item3.item2.item2).abs())
        .reduce(min);
    var minC3 = homes['C']!
        .map((e) =>
            (e.item1 - state.item3.item3.item1).abs() +
            (e.item2 - state.item3.item3.item2).abs())
        .reduce(min);
    var minC4 = homes['C']!
        .map((e) =>
            (e.item1 - state.item3.item4.item1).abs() +
            (e.item2 - state.item3.item4.item2).abs())
        .reduce(min);
    var minD1 = homes['D']!
        .map((e) =>
            (e.item1 - state.item4.item1.item1).abs() +
            (e.item2 - state.item4.item1.item2).abs())
        .reduce(min);
    var minD2 = homes['D']!
        .map((e) =>
            (e.item1 - state.item4.item2.item1).abs() +
            (e.item2 - state.item4.item2.item2).abs())
        .reduce(min);
    var minD3 = homes['D']!
        .map((e) =>
            (e.item1 - state.item4.item3.item1).abs() +
            (e.item2 - state.item4.item3.item2).abs())
        .reduce(min);
    var minD4 = homes['D']!
        .map((e) =>
            (e.item1 - state.item4.item4.item1).abs() +
            (e.item2 - state.item4.item4.item2).abs())
        .reduce(min);
    return minA1 +
        minA2 +
        minA3 +
        minA4 +
        minB1 +
        minB2 +
        minB3 +
        minB4 +
        minC1 +
        minC2 +
        minC3 +
        minC4 +
        minD1 +
        minD2 +
        minD3 +
        minD4;
  }
}

bool stateOverlaps(State s, Tuple2<int, int> pos) {
  return s.item1.item1 == pos ||
      s.item1.item2 == pos ||
      s.item2.item1 == pos ||
      s.item2.item2 == pos ||
      s.item3.item1 == pos ||
      s.item3.item2 == pos ||
      s.item4.item1 == pos ||
      s.item4.item2 == pos;
}

typedef StateWithCostAndDist = Tuple3<State, int, int>;

const dirs = [
  [0, 1],
  [1, 0],
  [0, -1],
  [-1, 0]
];

StateWithCostAndDist? search(Board b) {
  var start = Tuple3(b.initialState, 0, b.getDists(b.initialState));

  var toVisit = HeapPriorityQueue<StateWithCostAndDist>(COMPARISON_NAIVE);
  toVisit.add(start);

  var bestCosts = <State, int>{start.item1: 0};
  StateWithCostAndDist? bestState;

  var t = Stopwatch()..start();

  while (toVisit.isNotEmpty) {
    var curr = toVisit.removeFirst();
    if (b.hasWon(curr.item1) &&
        (bestState == null || bestState.item2 > curr.item2)) {
      bestState = curr;
      print(curr);
      continue;
    }

    for (var i = 0; i < 16; i++) {
      late Tuple4<Tuple2<int, int>, Tuple2<int, int>, Tuple2<int, int>,
          Tuple2<int, int>> letter;
      late Tuple2<int, int> pod;
      switch (i) {
        case 0:
          letter = curr.item1.item1;
          pod = letter.item1;
          break;
        case 1:
          letter = curr.item1.item1;
          pod = letter.item2;
          break;
        case 2:
          letter = curr.item1.item1;
          pod = letter.item3;
          break;
        case 3:
          letter = curr.item1.item1;
          pod = letter.item4;
          break;
        case 4:
          letter = curr.item1.item2;
          pod = letter.item1;
          break;
        case 5:
          letter = curr.item1.item2;
          pod = letter.item2;
          break;
        case 6:
          letter = curr.item1.item2;
          pod = letter.item3;
          break;
        case 7:
          letter = curr.item1.item2;
          pod = letter.item4;
          break;
        case 8:
          letter = curr.item1.item3;
          pod = letter.item1;
          break;
        case 9:
          letter = curr.item1.item3;
          pod = letter.item2;
          break;
        case 10:
          letter = curr.item1.item3;
          pod = letter.item3;
          break;
        case 11:
          letter = curr.item1.item3;
          pod = letter.item4;
          break;
        case 12:
          letter = curr.item1.item4;
          pod = letter.item1;
          break;
        case 13:
          letter = curr.item1.item4;
          pod = letter.item2;
          break;
        case 14:
          letter = curr.item1.item4;
          pod = letter.item3;
          break;
        case 15:
          letter = curr.item1.item4;
          pod = letter.item4;
          break;
      }

      for (var dir in dirs) {
        var next = Tuple2(pod.item1 + dir[0], pod.item2 + dir[1]);
        if (b.spots.contains(next) && !stateOverlaps(curr.item1, next)) {
          late State nextState;
          switch (i) {
            case 0:
              nextState = curr.item1.withItem1(letter.withItem1(next));
              break;
            case 1:
              nextState = curr.item1.withItem1(letter.withItem2(next));
              break;
            case 2:
              nextState = curr.item1.withItem1(letter.withItem3(next));
              break;
            case 3:
              nextState = curr.item1.withItem1(letter.withItem4(next));
              break;
            case 4:
              nextState = curr.item1.withItem2(letter.withItem1(next));
              break;
            case 5:
              nextState = curr.item1.withItem2(letter.withItem2(next));
              break;
            case 6:
              nextState = curr.item1.withItem2(letter.withItem3(next));
              break;
            case 7:
              nextState = curr.item1.withItem2(letter.withItem4(next));
              break;
            case 8:
              nextState = curr.item1.withItem3(letter.withItem1(next));
              break;
            case 9:
              nextState = curr.item1.withItem3(letter.withItem2(next));
              break;
            case 10:
              nextState = curr.item1.withItem3(letter.withItem3(next));
              break;
            case 11:
              nextState = curr.item1.withItem3(letter.withItem4(next));
              break;
            case 12:
              nextState = curr.item1.withItem4(letter.withItem1(next));
              break;
            case 13:
              nextState = curr.item1.withItem4(letter.withItem2(next));
              break;
            case 14:
              nextState = curr.item1.withItem4(letter.withItem3(next));
              break;
            case 15:
              nextState = curr.item1.withItem4(letter.withItem4(next));
              break;
          }
          var nextCost = b.costs[i] + curr.item2;
          if ((bestCosts[nextState] ?? 0x7fffffff) > nextCost &&
              nextCost < MAX_COST) {
            bestCosts[nextState] = nextCost;
            toVisit.add(Tuple3(nextState, nextCost, b.getDists(nextState)));
            if (bestCosts.length % 1000000 == 0) {
              print(
                  '${bestCosts.length ~/ 1000000}M - ${t.elapsedMilliseconds}ms');
            }
          }
        }
      }
    }
  }

  return null;
}

calc1(String s) {
  var x = Board(s);
  return search(x);
}

aoc23() {
  return calc1(input);
}

const inputTT = '''
#############
#...........#
###B#A#C#D###
###A#B#C#D###
###B#C#A#D###
###A#B#C#D###
#############
''';

const inputT = '''
#############
#...........#
###B#C#B#D###
###A#D#C#A###
#############
''';

const input = '''
#############
#...........#
###D#B#D#B###
###C#A#A#C###
###A#B#C#D###
###A#B#C#D###
#############
''';

const input2 = '''
#############
#...........#
###D#B#D#B###
###D#C#B#A###
###D#B#A#C###
###C#A#A#C###
#############
''';
