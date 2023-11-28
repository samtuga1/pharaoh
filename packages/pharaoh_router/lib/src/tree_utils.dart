// :name
bool isParametric(String pattern, {int at = 0}) {
  if (at > (pattern.length - 1)) return false;
  final safeNext = (at + 1) < pattern.length;
  return pattern.codeUnitAt(at) == 58 &&
      safeNext &&
      pattern.codeUnitAt(at + 1) != 58;
}

// ::
bool isDoubleColon(String pattern, {int at = 0}) {
  if (at > (pattern.length - 1)) return false;
  final safeNext = (at + 1) < pattern.length;
  return pattern.codeUnitAt(at) == 58 &&
      safeNext &&
      pattern.codeUnitAt(at + 1) == 58;
}

// *
bool isWildCard(String pattern, {int at = 0}) {
  if (at > (pattern.length - 1)) return false;
  return pattern.codeUnitAt(at) == 42;
}

final alphanumericRegex = RegExp(r'[a-zA-Z0-9]');
bool isAlphabetic(String character) {
  return alphanumericRegex.hasMatch(character);
}

/// `:name/foo/bar` --> `name`
///
/// `:user/`    --> `user`
String getPathParameter(String pattern, {int at = 0}) {
  final length = pattern.length;
  if (at > (length - 1)) {
    throw RangeError('Index is out of bounds of $pattern');
  }
  final sb = StringBuffer();
  for (int i = at; i < length; i++) {
    final char = pattern[i];
    if (!isAlphabetic(char)) break;
    sb.write(char);
  }
  return sb.toString();
}

String getValueinPath(String pattern, {int at = 0}) {
  final length = pattern.length;
  if (at > (length - 1)) {
    throw RangeError('Index is out of bounds of $pattern');
  }
  final sb = StringBuffer();
  for (int i = at; i < length; i++) {
    final char = pattern[i];
    if (char == '/') break;
  }
  return sb.toString();
}

final symbolRegex = RegExp(r'[@/_-]');

typedef IndexedSymbol = ({String symbol, int index});

List<IndexedSymbol> extractIndexedSymbols(String pattern) {
  final List<IndexedSymbol> result = [];
  for (int i = 0; i < pattern.length; i++) {
    final char = pattern[i];
    if (!symbolRegex.hasMatch(char)) continue;
    result.add((index: i, symbol: char));
  }
  return result;
}
