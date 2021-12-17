import 'dart:math';

class Target {
  int x1;
  int x2;
  int y1;
  int y2;
  Target(this.x1, this.x2, this.y2, this.y1);

  bool inside(int x, int y) {
    return x >= x1 && x <= x2 && y >= y2 && y <= y1;
  }
}

List<int> getVXs(Target s) {
  var vxs = <int>[];
  for (var i = 1; i < 100; i++) {
    var n = (i * (i + 1)) ~/ 2;
    if (n >= s.x1 && n <= s.x2) {
      vxs.add(i);
    }
  }
  return vxs;
}

int run(Target s, int vx, int vy) {
  var x = 0;
  var y = 0;
  var maxY = -10000000000;
  while (x < s.x2 && y > s.y2) {
    x += vx;
    y += vy;
    vx += vx > 0
        ? -1
        : vx < 0
            ? 1
            : 0;
    vy--;
    maxY = max(maxY, y);
    if (s.inside(x, y)) {
      return maxY;
    }
  }
  return -10000000000;
}

calc1(Target s) {
  var vx = getVXs(s)[0];
  var maxY = -10000000000;
  for (var vy = 1; vy < 10000; vy++) {
    maxY = max(maxY, run(s, vx, vy));
  }
  return maxY;
}

calc2(Target s) {
  var vs = 0;
  for (var vx = 1; vx < 1000; vx++) {
    for (var vy = -1000; vy < 1000; vy++) {
      if (run(s, vx, vy) > -10000000000) {
        vs++;
      }
    }
  }
  return vs;
}

aoc17() {
  return calc2(input);
}

var inputT = Target(20, 30, -10, -5);

var input = Target(60, 94, -171, -136);
