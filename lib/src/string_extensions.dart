import 'package:characters/characters.dart';

extension StringExtention on String {
  /// Reverse a string.
  ///
  /// ```dart
  /// print('Apple'.reversed) -> elppa
  /// ```
  ///
  String get reversed {
    final charRange = Characters(this).iteratorAtEnd;
    final buffer = StringBuffer();

    while (charRange.moveBack()) {
      buffer.write(charRange.current);
    }

    return buffer.toString();
  }

  /// Adding a prefix to a string
  ///
  /// ```dart
  /// final url = 'www.example.com';
  /// final fullURL = url.withPrefix('https://');
  /// print(fullURL); -> https://www.example.com
  /// ```
  ///
  String withPrefix(String prefix) {
    if (startsWith(prefix)) {
      return this;
    }
    return '$prefix$this';
  }

  /// Counting words in a string
  ///
  /// ```dart
  /// final phrase = 'The sun in Berlin';
  /// print('Words count: ${phrase.wordCount}'); -> 4
  /// ```
  ///
  int get wordCount => RegExp(r'(\w+)').allMatches(this).length;

  /// Replacing a search term in String
  ///
  /// ```dart
  /// final phrase =
  /// 'How much wood would a woodchuck chuck if a woodchuck would chuck wood?';
  /// print(phrase.replacingOccurrences('would', 'should')); ->
  /// How much wood should a woodchuck chuck if a woodchuck should chuck wood?
  /// ```
  ///
  String replacingOccurrences(String search, String replacement) =>
      replaceAll(RegExp('$search'), replacement);

  /// Returns characters of a string.
  ///
  /// ```dart
  /// print('apple'.chars) -> ['a', 'p', 'p', 'l', 'e']
  /// ```
  ///
  Iterable<String> get chars => Characters(this);

  /// Capitalize a string
  ///
  /// ```dart
  /// print('apple'.capitalize()) -> Apple
  /// print('Apple'.capitalize()) -> Apple
  /// ```
  ///
  String capitalize() {
    switch (length) {
      case 0:
        return this;
      case 1:
        return toUpperCase();
      default:
        return substring(0, 1).toUpperCase() + substring(1);
    }
  }

  /// Decapitalize a string
  ///
  /// ```dart
  /// print('Apple'.decapitalize()) -> apple
  /// print('apple'.decapitalize()) -> apple
  /// ```
  ///
  String decapitalize() {
    switch (length) {
      case 0:
        return this;
      case 1:
        return toLowerCase();
      default:
        return substring(0, 1).toLowerCase() + substring(1);
    }
  }

  /// Check if string is valid email format.
  ///
  /// ```dart
  /// print('me@me.com'.isValidEmail) -> true
  /// ```
  ///
  bool get isValidEmail => RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(this);

  /// Checks if the given string is a palindrome.
  ///
  /// ```dart
  /// print('lol'.isPalindrome) -> true
  /// print('Berlin'.isPalindrome) -> false
  /// ```
  ///
  bool get isPalindrome {
    for (var i = 0; i < this.length / 2; i++) {
      if (this[i] != this[this.length - 1 - i]) return false;
    }
    return true;
  }

  /// Replaces chars of a String with [replace].
  ///
  /// The default value of [replaceChar] is *.
  /// [begin] determines the start of the 'replacing'. If [begin] is null, it starts from index 0.
  /// [end] defines the end of the 'replacing'. If [end] is null, it ends at String length divided by 2.
  /// If String is empty or consists of only 1 char, the method returns null.
  ///
  ///  ```dart
  /// print('1234567890'.replaceCharacters()) -> *****67890
  /// print('1234567890'.replaceCharacters(begin: 3, end: 8)) -> 123*****90
  /// print('1234567890'.eplaceCharacters(end: 4, replaceChar: '#')) -> ####567890
  /// ```
  ///
  String replaceCharacters({
    int begin = 0,
    int end,
    String replaceChar = '*',
  }) {
    final buffer = StringBuffer();
    if (this.length <= 1) {
      return null;
    }
    if (end == null) {
      end = (this.length / 2).round();
    } else {
      if (end > this.length) {
        end = this.length;
      }
    }
    for (var i = 0; i < this.length; i++) {
      if (i >= end) {
        buffer.write(String.fromCharCode(this.runes.elementAt(i)));
        continue;
      }
      if (i >= begin) {
        buffer.write(replaceChar);
        continue;
      }
      buffer.write(String.fromCharCode(this.runes.elementAt(i)));
    }
    return buffer.toString();
  }

  /// Splits String in chunks with the [chunkSize].
  ///
  /// ```dart
  /// print('1234567890'.chunkSize(chunkSize: 3)) ->  ['12', '34', '56', '78', '90']
  /// ```
  ///
  List<String> chunk({int chunkSize}) {
    final chunked = <String>[];
    for (var i = 0; i < this.length; i += chunkSize) {
      final end = (i + chunkSize < this.length) ? i + chunkSize : this.length;
      chunked.add(this.substring(i, end));
    }
    return chunked;
  }

  /// Add a [char] at a [position] with the String.
  ///
  /// The boolean [repeat] defines whether to add the [char] at every [position].
  /// If [position] is greater than the length of String, it will return String.
  /// If [repeat] is true and [position] is 0, it will return String.
  ///
  ///  ```dart
  /// print('1234567890'.addCharAtPosition('-', 5)) ->  '12345-67890'
  /// print('1234567890'.addCharAtPosition('-', 5)) ->  '123-456-789-0'
  /// ```
  ///
  String addCharAtPosition(
    String char,
    int position, {
    bool repeat = false,
  }) {
    if (!repeat) {
      if (this.length < position) {
        return this;
      }
      final before = this.substring(0, position);
      final after = this.substring(position, this.length);
      return before + char + after;
    } else {
      if (position == 0) {
        return this;
      }
      final buffer = StringBuffer();
      for (var i = 0; i < this.length; i++) {
        if (i != 0 && i % position == 0) {
          buffer.write(char);
        }
        buffer.write(String.fromCharCode(this.runes.elementAt(i)));
      }
      return buffer.toString();
    }
  }
}
