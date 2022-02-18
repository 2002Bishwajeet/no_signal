extension SplitString on String {
  List<String> splitByLength(int length) =>
      [substring(0, length), substring(length)];
}
