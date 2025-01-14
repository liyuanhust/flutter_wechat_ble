class HexUtils {
  static int CODE0 = "0".codeUnitAt(0);
  static int CODE9 = "9".codeUnitAt(0);
  static int CODEA = "A".codeUnitAt(0);
  static int CODEZ = "Z".codeUnitAt(0);
  static int CODEa = "a".codeUnitAt(0);
  static int CODEz = "z".codeUnitAt(0);

  static List<String> DIGITS_LOWER = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    'a',
    'b',
    'c',
    'd',
    'e',
    'f'
  ];

  static int toDigit(int codePoint) {
    int result = -1;
    if (CODE0 <= codePoint && codePoint <= CODE9) {
      result = codePoint - CODE0;
    } else if (CODEa <= codePoint && codePoint <= CODEz) {
      result = 10 + (codePoint - CODEa);
    } else if (CODEA <= codePoint && codePoint <= CODEZ) {
      result = 10 + (codePoint - CODEA);
    }
    return result;
  }

  /// convert string to hex bytes
  static List<int> decodeHex(String data) {
    int len = data.length;
    if ((len & 0x01) != 0) {
      throw new Exception("Odd number of characters.");
    }
    List<int> out = [];// List(len >> 1);
    // two characters form the hex value.
    for (int i = 0, j = 0; j < len; i++) {
      int f = toDigit(data.codeUnitAt(j)) << 4;
      j++;
      f = f | toDigit(data.codeUnitAt(j));
      j++;
      out.add((f & 0xFF));
      // out[i] = (f & 0xFF);
    }
    return out;
  }

  /// convert hex bytes to hex string
  static String encodeHex(List<int> data) {
    int l = data.length;
    StringBuffer buffer = new StringBuffer();
    for (int i = 0, j = 0; i < l; i++) {
      int d = data[i];
      buffer.write(DIGITS_LOWER[(240 & d) >> 4]);
      buffer.write(DIGITS_LOWER[15 & d]);
    }
    return buffer.toString();
  }
}
