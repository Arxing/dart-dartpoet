class DartFormatter {
  String raw;
  int indentDepth = 0;
  int indentSpaceSize = 2;

  DartFormatter.create();

  String format(String raw) {
    List<String> lines = raw.split('\n');
    StringBuffer buffer = StringBuffer();
    for (var line in lines) {
      if (line.isNotEmpty) {
        String lastChar = line[line.length - 1];
        if (lastChar == '}') indentDepth--;
        buffer.write(calcIndentSpacing());
        if (lastChar == '{') indentDepth++;
      }
      buffer.writeln(line);
    }
    return buffer.toString();
  }

  String calcIndentSpacing() {
    return ' ' * indentSpaceSize * indentDepth;
  }
}
