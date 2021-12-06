List<int> parse(String s) => s.split(',').map(int.parse).toList();

calc1(String s, {days = 80}) {
  var nums = parse(s);
  for (var d = 0; d < days; d++) {
    // log('Day $d');
    // log('$nums');
    var adds = 0;
    for (var i = 0; i < nums.length; i++) {
      nums[i]--;
      if (nums[i] < 0) {
        nums[i] = 6;
        adds++;
      }
    }
    for (var i = 0; i < adds; i++) {
      nums.add(8);
    }
  }
  // log('Day $days: $nums');
  return nums.length;
}

var memo = <int, int>{};
var runs = 0;
int fish(int index, int afterDays) {
  var key = index * 100000 + afterDays;
  if (memo.containsKey(key)) {
    return memo[key]!;
  }
  runs++;
  if (afterDays == 0) {
    return 1;
  }
  var newIndex = index - 1;
  if (newIndex < 0) {
    return fish(6, afterDays - 1) + fish(8, afterDays - 1);
  } else {
    var val = fish(newIndex, afterDays - 1);
    memo[key] = val;
    return val;
  }
}

calc2(String s, {days = 80}) {
  var nums = parse(s);

  return nums
      .map((int num) => fish(num, days))
      .fold(0, (int acc, int i) => acc + i);
}

aoc6() {
  return [calc2(input, days: 10000), runs];
}

// const inputT = '''6''';
const inputT = '''3,4,3,1,2''';

const input =
    '''2,4,1,5,1,3,1,1,5,2,2,5,4,2,1,2,5,3,2,4,1,3,5,3,1,3,1,3,5,4,1,1,1,1,5,1,2,5,5,5,2,3,4,1,1,1,2,1,4,1,3,2,1,4,3,1,4,1,5,4,5,1,4,1,2,2,3,1,1,1,2,5,1,1,1,2,1,1,2,2,1,4,3,3,1,1,1,2,1,2,5,4,1,4,3,1,5,5,1,3,1,5,1,5,2,4,5,1,2,1,1,5,4,1,1,4,5,3,1,4,5,1,3,2,2,1,1,1,4,5,2,2,5,1,4,5,2,1,1,5,3,1,1,1,3,1,2,3,3,1,4,3,1,2,3,1,4,2,1,2,5,4,2,5,4,1,1,2,1,2,4,3,3,1,1,5,1,1,1,1,1,3,1,4,1,4,1,2,3,5,1,2,5,4,5,4,1,3,1,4,3,1,2,2,2,1,5,1,1,1,3,2,1,3,5,2,1,1,4,4,3,5,3,5,1,4,3,1,3,5,1,3,4,1,2,5,2,1,5,4,3,4,1,3,3,5,1,1,3,5,3,3,4,3,5,5,1,4,1,1,3,5,5,1,5,4,4,1,3,1,1,1,1,3,2,1,2,3,1,5,1,1,1,4,3,1,1,1,1,1,1,1,1,1,2,1,1,2,5,3''';
