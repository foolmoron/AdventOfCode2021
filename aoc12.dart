import 'package:tuple/tuple.dart';

class Node {
  final String name;
  final bool isBig;
  List<Node> edges = List.empty(growable: true);

  Node(this.name) : isBig = name.toUpperCase() == name;

  @override
  String toString() {
    return name;
  }
}

class Graph {
  final Node start;
  final Node end;
  final List<Node> verts;

  Graph(this.start, this.end, this.verts);

  @override
  String toString() {
    return verts
        .map((i) => '${i.name}: ' + i.edges.map((e) => e.name).join(', '))
        .join('\n');
  }
}

Graph parse(String s) {
  var edges = s.split('\n').map((l) => l.split('-').toList()).toList();
  var nodes = edges.expand((element) => element).toSet().map(Node.new).toList();
  for (var node in nodes) {
    for (var edge in edges) {
      if (edge[0] == node.name) {
        node.edges.add(nodes.firstWhere((n) => n.name == edge[1]));
      } else if (edge[1] == node.name) {
        node.edges.add(nodes.firstWhere((n) => n.name == edge[0]));
      }
    }
  }
  return Graph(nodes.firstWhere((n) => n.name == 'start'),
      nodes.firstWhere((n) => n.name == 'end'), nodes);
}

List<List<Node>> getPaths(
    Node end, Node current, List<Node> path, Map<Node, int> visited) {
  var newPath = [...path, current];
  if (current == end) {
    return [newPath];
  }

  var newVisited = {...visited};
  newVisited[current] = newVisited[current]! - 1;

  return current.edges
      .where((e) => visited[e] != 0)
      .map((e) {
        return getPaths(end, e, newPath, newVisited);
      })
      .expand((e) => e)
      .toList();
}

List<List<Node>> calc(Graph graph, Node? nodeToVisitDouble) {
  var visited = <Node, int>{};
  for (var v in graph.verts) {
    visited[v] = v.name.toUpperCase() == v.name
        ? 0x7fffffffffffffff // basically infinity
        : v == graph.start || v == graph.end || v != nodeToVisitDouble
            ? 1
            : 2;
  }

  return getPaths(graph.end, graph.start, [], visited);
}

out(List<List<Node>> paths) {
  print(paths.map((p) => p.join(',')).join('\n'));
}

calc1(String s) {
  var graph = parse(s);
  var paths = calc(graph, null);
  out(paths);
  return paths.length;
}

calc2(String s) {
  var graph = parse(s);
  var allPaths = graph.verts
      .where((v) => v != graph.start && v != graph.end && !v.isBig)
      .map((v) => calc(graph, v))
      .expand((element) => element)
      .map((path) => path.join(','))
      .toSet()
      .toList();
  return allPaths.length;
}

aoc12() {
  return calc2(input);
}

const inputT = '''start-A
start-b
A-c
A-b
b-d
A-end
b-end''';

const input = '''rf-RL
rf-wz
wz-RL
AV-mh
end-wz
end-dm
wz-gy
wz-dm
cg-AV
rf-AV
rf-gy
end-mh
cg-gy
cg-RL
gy-RL
VI-gy
AV-gy
dm-rf
start-cg
start-RL
rf-mh
AV-start
qk-mh
wz-mh''';
