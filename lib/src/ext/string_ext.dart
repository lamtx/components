import 'predicate.dart';

extension StringExt on String {
  bool get isNullOrEmpty => this == null || isEmpty;

  int toIntOrNull() => int.tryParse(this);

  String ifEmpty(String Function() other) {
    if (this != null && isNotEmpty) {
      return this;
    }
    return other();
  }

  String orEmpty() => this ?? "";

  String substringBeforeLast(String delimiter, [String missingDelimiterValue]) {
    final index = lastIndexOf(delimiter);
    if (index == -1) {
      return missingDelimiterValue ?? this;
    } else {
      return substring(0, index);
    }
  }

  String substringAfterLast(String delimiter, [String missingDelimiterValue]) {
    final index = lastIndexOf(delimiter);
    if (index == -1) {
      return missingDelimiterValue ?? this;
    } else {
      return substring(index + delimiter.length, length);
    }
  }

  String get extension => substringAfterLast(".", "");

  String get nameWithoutExtension => substringBeforeLast(".");

  String removeAll(List<int> characters) {
    final sb = StringBuffer();
    for (var i = 0; i < length; i++) {
      final char = codeUnitAt(i);
      if (!characters.contains(char)) {
        sb.writeCharCode(char);
      }
    }
    return sb.toString();
  }

  bool all(Predicate<int> predicate) {
    for (var i = 0; i < length; i++) {
      if (!predicate(codeUnitAt(i))) {
        return false;
      }
    }
    return true;
  }
}
