
part of ywz_blue_plugin;

class HexUtils {

  static List<int> randomSixByte() {
    List<int> list = [];
    Random random = Random();
    for (int i = 0; i < 6; i++) {
      int j = random.nextInt(256);
      list[i] = j & 0xff;
    }
    return Int8List.fromList(list);
  }

  static bool isValid(List<int> sBytes, List<int> dBytes) {
    if (dBytes[0] != deal(sBytes[0])) {
      return false;
    }
    if (dBytes[1] != deal(sBytes[1])) {
      return false;
    }
    if (dBytes[2] != deal(sBytes[2])) {
      return false;
    }
    if (dBytes[3] != deal(sBytes[3])) {
      return false;
    }
    if (dBytes[4] != deal(sBytes[4])) {
      return false;
    }
    if (dBytes[5] != deal(sBytes[5])) {
      return false;
    }
    return true;
  }

  static List<int> get8Data(List<int> sBytes) {
    List<int> newList = [];
    newList[0] = ((sBytes[0] +
            sBytes[1] +
            sBytes[2] +
            sBytes[3] +
            sBytes[4] +
            sBytes[5]) ^
        0x45);
    newList[1] = ((sBytes[0] * 1 +
            sBytes[1] * 2 +
            sBytes[2] * 3 +
            sBytes[3] * 4 +
            sBytes[4] * 5 +
            sBytes[5] * 6) ^
        0x95);
    newList[2] = ((sBytes[0] + sBytes[1] + sBytes[2] + 0x8d) ^ 0x15);
    newList[3] = ((sBytes[3] + sBytes[4] + sBytes[5] + 0x1c) ^ 0x74);
    newList[4] = ((sBytes[0] + sBytes[2] + sBytes[4] + 0x90) ^ 0xcd);
    newList[5] = ((sBytes[1] + sBytes[3] + sBytes[5] + 0x47) ^ 0x11);
    return Int8List.fromList(newList);
  }

  static int deal(int i) {
    return i > 0 ? i : i + 256;
  }
}
