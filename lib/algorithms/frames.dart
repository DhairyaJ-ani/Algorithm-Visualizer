// Simple frame used for sorting visualizations
class Frame {
  final List<int> arr;
  final int? a; // index a (e.g., being compared)
  final int? b; // index b (e.g., being compared/swapped)
  final String op; // operation label
  Frame(this.arr, {this.a, this.b, this.op = ''});
}

// Frame for Rabin-Karp visualization
class RKFrame {
  final String text;
  final String pattern;
  final int index; // shift index into text
  final bool match; // whether this window matched
  final int textHash;
  final int patternHash;
  RKFrame({required this.text, required this.pattern, required this.index, required this.match, required this.textHash, required this.patternHash});
}