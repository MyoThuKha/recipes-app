extension StrExtension on String {
  String toCapitalize() {
    if (length == 1) {
      return toUpperCase();
    }
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}
