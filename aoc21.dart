import 'dart:math';

import 'package:trotter/trotter.dart';

class DieDeterministic {
  int cycle;
  int num = 0;
  int rollCount = 0;

  DieDeterministic(this.cycle);

  int roll() {
    rollCount++;
    var ret = num + 1;
    num = (num + 1) % cycle;
    return ret;
  }
}

class Game {
  late List<int> positions;
  int currPlayer = 0;
  late List<int> scores;
  DieDeterministic die = DieDeterministic(100);

  Game(List<int> pos) {
    positions = pos.map((e) => e - 1).toList();
    scores = List.filled(positions.length, 0);
  }

  void round() {
    var move = die.roll() + die.roll() + die.roll();
    positions[currPlayer] = (positions[currPlayer] + move) % 10;
    scores[currPlayer] += positions[currPlayer] + 1;
    currPlayer = (currPlayer + 1) % positions.length;
  }

  void play() {
    while (!scores.any((e) => e >= 1000)) {
      round();
    }
  }

  int getLosingScore() {
    return scores.firstWhere((e) => e < 1000);
  }
}

calc1(List<int> s) {
  var g = Game(s);
  g.play();
  return g.getLosingScore() * g.die.rollCount;
}

Iterable<List<int>> perms(int maxRounds) {
  var numRolls = maxRounds * 3 * 2;
  var perms = Amalgams(numRolls, [1, 2, 3]);
  return perms();
}

bool eval(final List<int> game, final int target) {
  var p = [0, 0];
  var s = [0, 0];
  var l = (game.length / 3);
  for (var i = 0; i < l; i++) {
    var i2 = i % 2;
    var move = game[i * 3 + 0] + game[i * 3 + 1] + game[i * 3 + 2];
    p[i2] = (p[i2] + move) % 10;
    s[i2] += p[i2] + 1;
    if (s[i2] >= target) {
      return i2 == 0;
    }
  }
  return false;
}

calc2(List<int> s) {
  var p1 = 0;
  var p2 = 0;
  for (var perm in perms(6)) {
    eval(perm, 21) ? p1++ : p2++;
  }
  return [p1, p2];
}

aoc21() {
  return calc2(input);
}

const inputT = [4, 8];

const input = [3, 4];
