import 'package:tuple/tuple.dart';

class Polymer {
  Map<String, int> pairs = {};
  Map<String, String> rules = {};
  Map<String, int> counts = {};

  Polymer(String init, List<String> rs) {
    var letters = init.split('');
    for (var i = 1; i < letters.length; i++) {
      pairs[letters[i - 1] + letters[i]] =
          (pairs[letters[i - 1] + letters[i]] ?? 0) + 1;
    }
    for (var l in letters) {
      counts[l] = (counts[l] ?? 0) + 1;
    }

    rules = {
      for (var v
          in rs.map((r) => Tuple2(r.split(' -> ')[0], r.split(' -> ')[1])))
        v.item1: v.item2
    };
  }

  runOnce() {
    var newPairs = <String, int>{};
    for (var p in pairs.keys) {
      var matchingRule = rules[p];
      if (matchingRule != null) {
        var str = matchingRule;
        var c = (pairs[p] ?? 0);
        newPairs[p[0] + str] = (newPairs[p[0] + str] ?? 0) + c;
        newPairs[str + p[1]] = (newPairs[str + p[1]] ?? 0) + c;
        newPairs[p] = (newPairs[p] ?? 0) - c;
        counts[str] = (counts[str] ?? 0) + c;
      }
    }
    for (var k in newPairs.keys) {
      pairs[k] = (pairs[k] ?? 0) + (newPairs[k] ?? 0);
    }
    // print(els);
  }

  run({int times = 1}) {
    for (var i = 0; i < times; i++) {
      runOnce();
    }
  }

  maxMin() {
    var diff = counts.values.reduce((a, b) => a > b ? a : b) -
        counts.values.reduce((a, b) => a < b ? a : b);
    return diff;
  }
}

parse(String s) {
  var splits = s.split('\n\n');
  return Polymer(splits[0], splits[1].split('\n'));
}

calc1(String s) {
  var x = parse(s);
  x.run(times: 10);
  return x.maxMin();
}

calc2(String s) {
  var x = parse(s);
  x.run(times: 40);
  return x.maxMin();
}

aoc14() {
  return calc2(input);
}

const inputT = '''NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C''';

const input = '''KKOSPHCNOCHHHSPOBKVF

NV -> S
OK -> K
SO -> N
FN -> F
NB -> K
BV -> K
PN -> V
KC -> C
HF -> N
CK -> S
VP -> H
SK -> C
NO -> F
PB -> O
PF -> P
VC -> C
OB -> S
VF -> F
BP -> P
HO -> O
FF -> S
NF -> B
KK -> C
OC -> P
OV -> B
NK -> B
KO -> C
OH -> F
CV -> F
CH -> K
SC -> O
BN -> B
HS -> O
VK -> V
PV -> S
BO -> F
OO -> S
KB -> N
NS -> S
BF -> N
SH -> F
SB -> S
PP -> F
KN -> H
BB -> C
SS -> V
HP -> O
PK -> P
HK -> O
FH -> O
BC -> N
FK -> K
HN -> P
CC -> V
FO -> F
FP -> C
VO -> N
SF -> B
HC -> O
NN -> K
FC -> C
CS -> O
FV -> P
HV -> V
PO -> H
BH -> F
OF -> P
PC -> V
CN -> O
HB -> N
CF -> P
HH -> K
VH -> H
OP -> F
BK -> S
SP -> V
BS -> V
VB -> C
NH -> H
SN -> K
KH -> F
OS -> N
NP -> P
VN -> V
KV -> F
KP -> B
VS -> F
NC -> F
ON -> S
FB -> C
SV -> O
PS -> K
KF -> H
CP -> H
FS -> V
VV -> H
CB -> P
PH -> N
CO -> N
KS -> K''';
