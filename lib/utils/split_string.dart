/// Extension method on String
/// We created a new String extension method called 'splitByLength'
/// that will split a string into a list of strings of a given length.
/// To know more about extension methods, check out this doc:
/// https://dart.dev/guides/language/extension-methods
extension SplitString on String {
  List<String> splitByLength(int length) =>
      [substring(0, length), substring(length)];
}
