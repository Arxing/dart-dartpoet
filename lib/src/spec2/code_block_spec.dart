part of 'spec.dart';

class CodeBlockSpec extends Spec {
  static const String KEY_USE_EXPRESSION_BODY = "use_expression_body";

  List<String> statements = [];

  int get lines => statements.length;

  @override
  SpecKind get kind => SpecKind.CODE_BLOCK;

  @override
  List<SpecKind> get supportedChildKinds => [];

  CodeBlockSpec.empty();

  CodeBlockSpec.lines(List<String> lines) {
    addLines(lines);
  }

  CodeBlockSpec.line(String line) : this.lines([line]);

  void addLine(String line) => line.split("\n").forEach((line) => statements.add(line));

  void addLines(List<String> lines) => lines.forEach((line) => addLine(line));

  @override
  String code() {
    bool useExpressionBody = args[KEY_USE_EXPRESSION_BODY] ?? lines == 1;
    StringBuffer code = StringBuffer();
    if (lines == 1 && useExpressionBody) {
      code.write("=> ${statements.single}");
    } else if (lines >= 1) {
      code.write("{\n${statements.join("\n")}\n}");
    }
    return code.toString();
  }
}

enum CodeBlockEmptiedCollectingMode { nothing, emptyBlock, end }
