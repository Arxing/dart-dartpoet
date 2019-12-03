part of '../code_writer.dart';

class CodeTransaction<TParent extends CodeContext> extends _Transaction<TParent> with CodeContext<CodeTransaction<TParent>> {
  StringBuffer _buffer = StringBuffer();

  CodeTransaction(CodeContext context, [Map<String, dynamic> args]) : super(context, args);

  @override
  String _collectCode() {
    return _buffer.toString();
  }

  @override
  void _commitFromChild(String code, [Map<String, dynamic> args]) => _buffer.write(code);

  CodeTransaction<TParent> addCode(String code, [bool newLine = false]) {
    if (!_canDoAction()) return this;
    _buffer.write(code);
    newLine ? _buffer.writeln() : null;
    return this;
  }

  CodeTransaction<TParent> addCodeLine(String code) => this.addCode(code, true);

  CodeTransaction<TParent> newLine() {
    if (!_canDoAction()) return this;
    _buffer.writeln();
    return this;
  }

  CodeTransaction<TParent> beginClosure() {
    _buffer.writeln("{");
    return this;
  }

  CodeTransaction<TParent> endClosure() {
    _buffer.writeln("}");
    return this;
  }

  SegmentTransaction<CodeTransaction<TParent>> beginSegments() => SegmentTransaction<CodeTransaction<TParent>>(this);

  IfElseTransaction<CodeTransaction<TParent>> beginIfElse() => IfElseTransaction<CodeTransaction<TParent>>(this);
}
