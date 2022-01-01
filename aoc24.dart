import 'package:trotter/trotter.dart';

enum Op {
  inp,
  add,
  mod,
  div,
  eql,
  mul,
}

class Command {
  late Op op;
  late String a;
  String? bVar;
  int? bLit;

  Command(String s) {
    op = Op.values
        .firstWhere((o) => o.toString().split('.')[1] == s.split(' ')[0]);
    a = s.split(' ')[1];
    if (op != Op.inp) {
      bLit = int.tryParse(s.split(' ')[2]);
      if (bLit == null) {
        bVar = s.split(' ')[2];
      }
    }
  }
}

class State {
  int w = 0, x = 0, y = 0, z = 0;

  int get(String? s) {
    switch (s) {
      case 'w':
        return w;
      case 'x':
        return x;
      case 'y':
        return y;
      case 'z':
        return z;
    }
    throw 'Invalid variable name';
  }

  void set(String? s, int i) {
    switch (s) {
      case 'w':
        w = i;
        return;
      case 'x':
        x = i;
        return;
      case 'y':
        y = i;
        return;
      case 'z':
        z = i;
        return;
    }
    throw 'Invalid variable name';
  }

  @override
  String toString() {
    return 'w=$w, x=$x, y=$y, z=$z';
  }
}

State execute(List<Command> commands, List<int> inputs) {
  final state = State();
  var inputIndex = 0;

  int getB(Command c) {
    if (c.bVar != null) {
      return state.get(c.bVar);
    } else {
      return c.bLit!;
    }
  }

  for (var c in commands) {
    switch (c.op) {
      case Op.inp:
        state.set(c.a, inputs[inputIndex++]);
        break;
      case Op.add:
        state.set(c.a, state.get(c.a) + getB(c));
        break;
      case Op.mod:
        state.set(c.a, state.get(c.a) % getB(c));
        break;
      case Op.div:
        state.set(c.a, state.get(c.a) ~/ getB(c));
        break;
      case Op.eql:
        state.set(c.a, state.get(c.a) == getB(c) ? 1 : 0);
        break;
      case Op.mul:
        state.set(c.a, state.get(c.a) * getB(c));
        break;
    }
  }

  return state;
}

List<Command> parse(String s) {
  return s.split('\n').map(Command.new).toList();
}

calc1(String s) {
  // TODO: reverse-engineer graph of instructions
  var x = parse(s);
  var i = 0;
  for (var a in Amalgams(14, [9, 8, 7, 6, 5, 4, 3, 2, 1])()) {
    var r = execute(
      x,
      a,
    );
    i++;
    if (i % 1000000 == 0) {
      print(i);
    }
    if (r.z == 0) {
      print(a.join(''));
    }
  }
}

calc2(String s) {
  var x = parse(s);
  return x;
}

aoc24() {
  return calc1(input);
}

const inputT = '''inp w
add z w
mod z 2
div w 2
add y w
mod y 2
div w 2
add x w
mod x 2
div w 2
mod w 2''';

const input = '''inp w
mul x 0
add x z
mod x 26
div z 1
add x 11
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 6
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 11
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 14
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 15
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 13
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -14
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 1
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 10
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 6
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x 0
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 13
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -6
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 6
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 13
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 3
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -3
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 8
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 13
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 14
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 15
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 4
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -2
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 7
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -9
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 15
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -2
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 1
mul y x
add z y''';
