class CodeWriter {
  _FragmentsTransaction _currentLineToken;
  StringBuffer _buffer;

  CodeWriter() {
    _buffer = StringBuffer();
  }

  _FragmentsTransaction beginFragments() {
    _currentLineToken = _FragmentsTransaction._(this);
    return _currentLineToken;
  }

  CodeWriter addCode(String code) {
    _buffer.write(code);
    return this;
  }

  CodeWriter addCodeIf(bool condition, String code) {
    condition ? addCode(code) : null;
    return this;
  }

  CodeWriter addCodeIfNot(bool condition, String code) => addCodeIf(!condition, code);

  CodeWriter newLine() {
    _buffer.writeln();
    return this;
  }

  CodeWriter beginClosure() {
    _buffer.writeln("{");
    return this;
  }

  CodeWriter endClosure() {
    _buffer.writeln("}");
    return this;
  }

  String output() => _buffer.toString();
}

class _FragmentsTransaction {
  CodeWriter _context;

  List<String> _segments = [];

  _FragmentsTransaction._(this._context);

  _FragmentsTransaction put(String segment) {
    _segments.add(segment);
    return this;
  }

  _FragmentsTransaction putIf(bool condition, String segment) {
    condition ? put(segment) : null;
    return this;
  }

  _FragmentsTransaction putIfNot(bool condition, String segment) => putIf(!condition, segment);

  CodeWriter commit() {
    _context.addCode(_segments.join(" "));
    return _context;
  }
}
