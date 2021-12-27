import 'dart:math';

import 'package:collection/collection.dart';

enum PacketType {
  literal,
  operatorBits,
  operatorNum,
}

class Packet {
  int ver;
  int type;
  List<String> payload;
  int? literal;
  int? lengthNum;
  List<Packet> subs = [];

  Packet(this.ver, this.type, this.payload);

  PacketType getType() {
    if (type == 4) {
      return PacketType.literal;
    }
    if (payload[0] == '0') {
      return PacketType.operatorBits;
    } else {
      return PacketType.operatorNum;
    }
  }

  int getTotalBits() {
    return 3 + 3 + payload.length;
  }

  @override
  String toString() {
    var sb = StringBuffer();
    sb.write('{ Ver: $ver | Type: $type | ');
    switch (getType()) {
      case PacketType.literal:
        sb.write('Literal: $literal');
        break;
      case PacketType.operatorBits:
        sb.write('Sub-packet bits: $lengthNum');
        break;
      case PacketType.operatorNum:
        sb.write('Sub-packet num: $lengthNum');
        break;
    }
    sb.write(' }');
    return sb.toString();
  }
}

class PacketRemainingRecord {
  bool bitsMode;
  int remaining;
  int packetIndex;
  Packet? parent;
  PacketRemainingRecord(
      this.bitsMode, this.remaining, this.packetIndex, this.parent);

  void consume(Packet p, bool isLast) {
    if (bitsMode) {
      remaining -= p.getTotalBits();
    } else if (isLast) {
      remaining--;
    }
  }
}

List<Packet> parse(String s) {
  var bits = s
      .split('')
      .expand((c) =>
          int.parse(c, radix: 16).toRadixString(2).padLeft(4, '0').split(''))
      .toList();

  var packets = <Packet>[];
  var packetsRemaining = [PacketRemainingRecord(false, 1, 0, null)];
  var i = 0;
  while (packetsRemaining.isNotEmpty) {
    var ver = int.parse(bits.sublist(i, i += 3).join(''), radix: 2);
    var type = int.parse(bits.sublist(i, i += 3).join(''), radix: 2);

    Function? addPacketsRemaining;
    Packet packet;
    var payloadStart = i;
    if (type == 4) {
      var literalBits = <String>[];
      while (true) {
        var flag = bits[i];
        i += 1;
        literalBits.addAll(bits.sublist(i, i += 4));
        if (flag == '0') {
          break;
        }
      }

      packet = Packet(ver, type, bits.sublist(payloadStart, i));
      packet.literal = int.parse(literalBits.join(''), radix: 2);
    } else {
      var bitsMode = bits[i] == '0';
      var payloadLength = 1 + (bitsMode ? 15 : 11);
      var num =
          int.parse(bits.sublist(i + 1, i += payloadLength).join(''), radix: 2);

      packet = Packet(ver, type, bits.sublist(payloadStart, i));
      packet.lengthNum = num;

      addPacketsRemaining = () => packetsRemaining
          .add(PacketRemainingRecord(bitsMode, num, packets.length, packet));
    }
    print(packet);
    packets.add(packet);

    packetsRemaining.last.parent?.subs.add(packet);

    packetsRemaining.forEachIndexed(
        (i, pr) => pr.consume(packet, i == (packetsRemaining.length - 1)));
    packetsRemaining.removeWhere((pr) => pr.remaining == 0);

    addPacketsRemaining?.call();
  }

  return packets;
}

calc1(String s) {
  var x = parse(s);
  return x.map((p) => p.ver).reduce((acc, i) => acc + i);
}

int eval(int index, List<Packet> packets) {
  var p = packets[index];
  var subs = p.subs.map((s) => eval(packets.indexOf(s), packets));
  switch (p.type) {
    case 0:
      return subs.reduce((int a, int b) => a + b);
    case 1:
      return subs.reduce((int a, int b) => a * b);
    case 2:
      return subs.reduce((int a, int b) => min(a, b));
    case 3:
      return subs.reduce((int a, int b) => max(a, b));
    case 4:
      return p.literal!;
    case 5:
      return eval(packets.indexOf(p.subs[0]), packets) >
              eval(packets.indexOf(p.subs[1]), packets)
          ? 1
          : 0;
    case 6:
      return eval(packets.indexOf(p.subs[0]), packets) <
              eval(packets.indexOf(p.subs[1]), packets)
          ? 1
          : 0;
    case 7:
      return eval(packets.indexOf(p.subs[0]), packets) ==
              eval(packets.indexOf(p.subs[1]), packets)
          ? 1
          : 0;
  }
  throw Exception('Unknown packet type');
}

calc2(String s) {
  var x = parse(s);
  return eval(0, x);
}

aoc16() {
  return calc2(input);
}

const inputT = '''9C0141080250320F1802104A08''';

const input =
    '''420D50000B318100415919B24E72D6509AE67F87195A3CCC518CC01197D538C3E00BC9A349A09802D258CC16FC016100660DC4283200087C6485F1C8C015A00A5A5FB19C363F2FD8CE1B1B99DE81D00C9D3002100B58002AB5400D50038008DA2020A9C00F300248065A4016B4C00810028003D9600CA4C0084007B8400A0002AA6F68440274080331D20C4300004323CC32830200D42A85D1BE4F1C1440072E4630F2CCD624206008CC5B3E3AB00580010E8710862F0803D06E10C65000946442A631EC2EC30926A600D2A583653BE2D98BFE3820975787C600A680252AC9354FFE8CD23BE1E180253548D057002429794BD4759794BD4709AEDAFF0530043003511006E24C4685A00087C428811EE7FD8BBC1805D28C73C93262526CB36AC600DCB9649334A23900AA9257963FEF17D8028200DC608A71B80010A8D50C23E9802B37AA40EA801CD96EDA25B39593BB002A33F72D9AD959802525BCD6D36CC00D580010A86D1761F080311AE32C73500224E3BCD6D0AE5600024F92F654E5F6132B49979802129DC6593401591389CA62A4840101C9064A34499E4A1B180276008CDEFA0D37BE834F6F11B13900923E008CF6611BC65BCB2CB46B3A779D4C998A848DED30F0014288010A8451062B980311C21BC7C20042A2846782A400834916CFA5B8013374F6A33973C532F071000B565F47F15A526273BB129B6D9985680680111C728FD339BDBD8F03980230A6C0119774999A09001093E34600A60052B2B1D7EF60C958EBF7B074D7AF4928CD6BA5A40208E002F935E855AE68EE56F3ED271E6B44460084AB55002572F3289B78600A6647D1E5F6871BE5E598099006512207600BCDCBCFD23CE463678100467680D27BAE920804119DBFA96E05F00431269D255DDA528D83A577285B91BCCB4802AB95A5C9B001299793FCD24C5D600BC652523D82D3FCB56EF737F045008E0FCDC7DAE40B64F7F799F3981F2490''';
